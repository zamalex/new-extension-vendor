import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:extension_vendor/Providers/appoinment_model.dart';
import 'package:extension_vendor/Providers/constants.dart';
import 'package:extension_vendor/Providers/orders_model.dart';
import 'package:extension_vendor/Providers/datetime.dart';
import 'package:extension_vendor/Providers/orders_provider.dart';
import 'package:extension_vendor/Providers/tstt.dart';
class AppointmentDetails extends StatefulWidget {

  Data order;
  AppointmentDetails(this.order);

  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  String services='';

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

  final mGrey = const  Color.fromRGBO(127, 71, 150, 1);

  final dGrey = const Color.fromRGBO(184, 189, 194, 1);

  final mYellow = const Color.fromRGBO(93, 174, 255, 1);


  @override
  Widget build(BuildContext context) {
    widget.order.items.data.forEach((element) {
      services = services+element.productName+'\n';
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const  Color.fromRGBO(127, 71, 150, 1),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Appointment Details'.tr(),style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),),
        centerTitle: true,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10),
          color: const Color.fromRGBO(248, 248, 248, 1),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: /*CircleAvatar(
                    child: ClipRRect(child: Image.asset('assets/images/welcome.png'),borderRadius: BorderRadius.circular(50),),
                    backgroundColor: Colors.grey,
                    radius: 30,
                  )*/Icon(Icons.person,color: Constants.kPrimaryColor,),
                  title: Text(
                    widget.order.user_name,
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(
                    'Saudi Arabia'.tr(),
                    style: TextStyle(color: mGrey),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                /*_iconText(
                   'assets/images/Location@3x.png',
                    'Address'),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.order.user_address??'',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),*/
                /*SizedBox(
                  height: 10,
                ),
                _iconText(
                    'assets/images/Message@3x.png',
                    'Email address'),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Ahlam_Ab22@gmail.com',
                  style: TextStyle(color: Colors.black),
                ),*/
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 10,
                ),
                if(Constants.USER_TYPE!='staff')
                _iconText(
                   'assets/images/Call@3x.png',
                    'Phone number'.tr()),
                SizedBox(
                  height: 5,
                ),


                if(Constants.USER_TYPE!='staff')
                  Text(
                  widget.order.user_phone,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                _iconText(
                    'assets/images/Document@3x.png',
                    '${'Order no.'.tr()} ${widget.order.code}'),
                SizedBox(
                  height: 10,
                ),
               /* _iconText(
                    Icon(
                      Icons.list_alt,
                      color: mGrey,
                      size: 30,
                    ),
                    'Invoice summary'),*/
                SizedBox(
                  height: 10,
                ),
                if(widget.order.deliveryStatus=='pending')
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 2,
                      color: mYellow,
                    )),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 2,
                      color: dGrey,
                    )),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 2,
                      color: dGrey,
                    )),
                  ],
                )
                else if(widget.order.deliveryStatus=='confirmed')
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                            thickness: 2,
                            color: mYellow,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: Divider(
                            thickness: 2,
                            color: mYellow,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: Divider(
                            thickness: 2,
                            color: dGrey,
                          )),
                    ],
                  )
                else if(widget.order.deliveryStatus=='finished')
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                              thickness: 2,
                              color: mYellow,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Divider(
                              thickness: 2,
                              color: mYellow,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Divider(
                              thickness: 2,
                              color: mYellow,
                            )),
                      ],
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.order.deliveryStatus.tr()/*=='on_the_way'?'active':widget.order.deliveryStatus*/,
                      style: TextStyle(color: mYellow),
                    ),
                    RichText(
                        text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Booked by'.tr(),
                            style: TextStyle(color: mYellow)),
                        TextSpan(
                            text: ' ${DateTime.parse(
                                widget.order.bookingDateTime.replaceAll('  ', ' '))
                                .toLocalDateString}',
                            style: TextStyle(color: Colors.black)),
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              if(widget.order.booking_staff_name!=null)  ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  /*leading: CircleAvatar(
                    child: ClipRRect(child: Image.asset('assets/images/welcome.png'),borderRadius: BorderRadius.circular(50),),
                    backgroundColor: Colors.grey,
                    radius: 30,
                  ),*/
                  title: Text(
                    '${widget.order.booking_staff_name}',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(
                    'Salon staff'.tr(),
                    style: TextStyle(color: mGrey),
                  ),
                 /* trailing: ElevatedButton.icon(
                    onPressed: null,
                    icon: Text(
                      '4.8',
                      style: TextStyle(color: Colors.black),
                    ),
                    label: Icon(
                      Icons.star,
                      color: Colors.black,
                    ),
                  ),*/
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 8.0, bottom: 8),
                  child: Column(children:
                    widget.order.items.data.map((e){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.productName,
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            '${e.price} ${'SAR'.tr()}',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      );
                    }).toList()
                  ,)
                ),
                SizedBox(
                  height: 20,
                ), Text(
                  'Notes'.tr(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${widget.order.notes}',
                  style: TextStyle(color: Colors.black),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Text(
                  'Payment Method'.tr(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                SizedBox(
                  height: 10,
                ),
                _iconTextLight(
                    'assets/images/Wallet@3x.png',
                    widget.order.paymentType),
                SizedBox(
                  height: 10,
                ),

                Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Order summary'.tr(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal price'.tr(),
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      '${widget.order.subtotal} ${'SAR'.tr()}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Coupon Discount'.tr(),
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      '${widget.order.coupon_discount} ${'SAR'.tr()}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),


                SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Balance Discount'.tr(),
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      '${widget.order.balance} ${'SAR'.tr()}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total'.tr(),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${widget.order.grandTotal} ${'SAR'.tr()}',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed:() async {
                          await PrintInv.generateInvoice(widget.order,PdfPageFormat.a4);
                          print('object');

                        },
                        child: Text(
                          'Print Invoice'.tr(),
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
                        onPressed: (){/*changeStatus(widget.order.deliveryStatus);*/showStatusesDialog(context);},
                        child: Text(
                          'Change Status'.tr(),
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(mGrey)),
                      ),
                    )),
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget _iconText(String icon, String text) {
    return Row(
      children: [
        Image.asset(icon,width: 20,height: 20,),
        SizedBox(width: 10,),

        Text(
          text,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        )
      ],
    );
  }

  Widget _iconTextLight(String icon, String text) {
    return Row(
      children: [
        Image.asset(icon,width: 20,height: 20,),
        SizedBox(width: 10,),

        Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: 17),
        )
      ],
    );
  }
}
