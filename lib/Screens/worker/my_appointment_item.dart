import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:extension_vendor/Providers/constants.dart';
import 'package:extension_vendor/Providers/orders_model.dart';
import 'package:extension_vendor/Providers/orders_provider.dart';
import 'package:extension_vendor/Screens/appoinment/appointment_details.dart';
import 'package:extension_vendor/Screens/order/order_details.dart';
import 'package:extension_vendor/Widgets/seperator_wedgit.dart';
import 'package:extension_vendor/Providers/datetime.dart';
class MyAppointmentItem extends StatefulWidget {


  Data order;
  MyAppointmentItem(this.order);

  @override
  State<MyAppointmentItem> createState() => _MyAppointmentItemState();
}

class _MyAppointmentItemState extends State<MyAppointmentItem> {
  String services = '';

  final mGrey = const  Color.fromRGBO(127, 71, 150, 1);

  showStatusesDialog(
      BuildContext context){

    if(Constants.USER_TYPE=='staff')
      Constants.STATUSES = Constants.STAFF_STATUSES;
    showModalBottomSheet(isScrollControlled: true,builder: (context) =>Wrap(
      children: List.generate(Constants.STATUSES.length, (index) => Column(
        children: [
          InkWell(
              onTap: (){
                Navigator.of(context).pop();
                changeStatus(Constants.STATUSES[index]);
              },
              child: Container(margin: EdgeInsets.all(5),child: Text(Constants.STATUSES[index].tr()/*=='finished'?'completed':Constants.STATUSES[index]*/,style: TextStyle(fontSize: 18),))),
          Divider()
        ],
      )),
    ) , context: context,);

  }

  changeStatus(String statuss){
    String status='';
    switch(widget.order.deliveryStatus){
      case 'pending':
        status='confirmed';
        break;
      case 'confirmed':
      case 'on_the_way':
        status='finished';
        break;
      case 'finished':
        status='finished';
        break;
      default:
        status='finished';
    }

    if(statuss=='active')
      statuss='on_the_way';
    status = statuss;
    ApointmentsData().changeStatus(status, widget.order.id.toString(),widget.order.paymentStatus).then((value){

      if(value){
        setState(() {
          widget.order.deliveryStatus = status=='on_the_way'?'active':status;
        });
      }

      if( Constants.USER_TYPE=='staff') {

        Provider.of<OrdersProvider>(context, listen: false).customPage=0;
        Provider.of<OrdersProvider>(context, listen: false)
            .getWorkerAppointments();
      }else
        Provider.of<OrdersProvider>(context, listen: false).getAppointments(1);

    });

  }

  @override
  Widget build(BuildContext context) {

    widget.order.items.data.forEach((element) {
      services = services+element.productName+'\n';
    });



    return Container(
      constraints: BoxConstraints(minHeight: 60),
      margin: EdgeInsets.all(16),
      child: GestureDetector(
        onTap: null,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(mainAxisSize: MainAxisSize.max, children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0, left: 15),
                      child: Text(
                        widget.order.code,
                        style: TextStyle(
                          color: Color.fromRGBO(26, 26, 26, 1),
                          fontFamily: "Almarai",
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(right: 15.0, left: 15, top: 10),
                    child: Text(
                      '${widget.order.grandTotal} ${'SAR'.tr()}',
                      style: TextStyle(
                        color: Color.fromRGBO(26, 26, 26, 1),
                        fontFamily: "Almarai",
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15, top: 10),
                child: Text(
                  widget.order.user_name??'',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromRGBO(184, 189, 194, 1),
                    fontFamily: "Almarai",
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 8.0, bottom: 8),
                child: Text(
                  DateTime.parse(
                      widget.order.bookingDateTime.replaceAll('  ', ' '))
                      .toLocalDateString,
                  style: TextStyle(
                    color: Color.fromRGBO(26, 26, 26, 1),
                    fontFamily: "Almarai",
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 16, left: 8.0, bottom: 8),
                child: Text(
                    DateFormat('hh:mm a').format(DateTime.parse(
                        widget.order.bookingDateTime.replaceAll('  ', ' ')))
                      ,
                  style: TextStyle(
                    color: Color.fromRGBO(26, 26, 26, 1),
                    fontFamily: "Almarai",
                    fontSize: 14,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 16, left: 8.0, bottom: 8),
                child: Text(
                  services,
                  style: TextStyle(
                    color: Color.fromRGBO(26, 26, 26, 1),
                    fontFamily: "Almarai",
                    fontSize: 14,
                  ),
                ),
              ),
              // Flex(
              //     direction: Axis.vertical,
              //     children: [
              //       Expanded(child: Container()),
              //       const MySeparator(color: Colors.grey),
              //     ],
              //   ),

              MySeparator(color: Color.fromRGBO(135, 135, 135, 1)),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 15, right: 14, bottom: 7),
                      child: Text(
                        widget.order.deliveryStatus.tr(),//=='on_the_way'?'active':widget.order.deliveryStatus,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: "Almarai",
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(93, 174, 255, 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed:(){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AppointmentDetails(widget.order)),
                              );
                              //Provider.of<OrdersProvider>(context, listen: false).acceptRegectAppointment('Rejected', widget.order.id.toString());
                            },
                            child: Text(
                              'View'.tr(),
                              style: TextStyle(color: mGrey),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        side: BorderSide(color: mGrey)))),
                          ),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: (){
                             // Provider.of<OrdersProvider>(context, listen: false).acceptRegectAppointment('Accepted', widget.order.id.toString(),payment:widget.order.paymentStatus);
                              showStatusesDialog(context);
                            },
                            child: Text(
                              'Change Status'.tr(),
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(mGrey)),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
