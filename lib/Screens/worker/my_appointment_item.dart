import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salon_vendor/Providers/orders_model.dart';
import 'package:salon_vendor/Providers/orders_provider.dart';
import 'package:salon_vendor/Screens/order/order_details.dart';
import 'package:salon_vendor/Widgets/seperator_wedgit.dart';
import 'package:salon_vendor/Providers/datetime.dart';
class MyAppointmentItem extends StatefulWidget {


  Data order;
  MyAppointmentItem(this.order);

  @override
  State<MyAppointmentItem> createState() => _MyAppointmentItemState();
}

class _MyAppointmentItemState extends State<MyAppointmentItem> {
  String services = '';

  final mGrey = const Color.fromRGBO(174, 117, 106, 1);

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
                        widget.order.id.toString(),
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
                      '${widget.order.grandTotal} SAR',
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
                        widget.order.deliveryStatus=='on_the_way'?'active':widget.order.deliveryStatus,
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
                              Provider.of<OrdersProvider>(context, listen: false).acceptRegectAppointment('Rejected', widget.order.id.toString());
                            },
                            child: Text(
                              'Cancel',
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
                              Provider.of<OrdersProvider>(context, listen: false).acceptRegectAppointment('Accepted', widget.order.id.toString(),payment:widget.order.paymentStatus);

                            },
                            child: Text(
                              'Accept',
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
