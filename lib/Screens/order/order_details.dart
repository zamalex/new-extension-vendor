import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:salon_vendor/Providers/orders_model.dart';
import 'package:salon_vendor/Providers/datetime.dart';
import 'package:salon_vendor/Providers/orders_provider.dart';
import 'package:salon_vendor/Providers/tstt.dart';

class OrderDetails extends StatefulWidget {
  Data order;
  OrderDetails(this.order);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final mGrey = const Color.fromRGBO(174, 117, 106, 1);

  final dGrey = const Color.fromRGBO(184, 189, 194, 1);

  final mYellow = const Color.fromRGBO(255, 200, 89, 1);
  changeStatus(String status){
    String status='';
    switch(widget.order.deliveryStatus){
      case 'pending':
        status='confirmed';
        break;
      case 'confirmed':
        status='on_the_way';
        break;
      case 'on_the_way':
        status='delivered';
        break;
      case 'delivered':
        status='delivered';
        break;
      default:
        status='delivered';

    }

    ApointmentsData().changeStatus(status, widget.order.id.toString()).then((value){

      if(value){
        setState(() {
          widget.order.deliveryStatus = status;
        });
      }
      Provider.of<OrdersProvider>(context, listen: false).getOrders(1);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(174, 117, 106, 1),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Order Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        leading: BackButton(color: Colors.white),
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
                  leading: CircleAvatar(
                    child: ClipRRect(child: Image.asset('assets/images/welcome.png'),borderRadius: BorderRadius.circular(50),),
                    backgroundColor: Colors.grey,
                    radius: 30,
                  ),
                  title: Text(
                    widget.order.user_name,
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(
                    'Saudi Arabia',
                    style: TextStyle(color: mGrey),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _iconText(
                    'assets/images/Location@3x.png',
                    'Address'),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.order.user_address ?? '',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
              /*  SizedBox(
                  height: 10,
                ),
                _iconText(
                    'assets/images/MesFsage@3x.png',
                    'Email address'),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.order.user_phone??'',
                  style: TextStyle(color: Colors.black),
                ),*/
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 10,
                ),
                _iconText(
                    'assets/images/Call@3x.png',
                    'Phone number'),
                SizedBox(
                  height: 5,
                ),
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
                    'Order no. ${widget.order.id}'),
                SizedBox(
                  height: 10,
                ),
            /*    _iconText(
                    Icon(
                      Icons.list_alt,
                      color: mGrey,
                      size: 30,
                    ),
                    'Invoice summary'),*/
                SizedBox(
                  height: 10,
                ),
                if (widget.order.deliveryStatus == 'pending')
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
                else if (widget.order.deliveryStatus == 'confirmed')
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
                else if (widget.order.deliveryStatus == 'on_the_way')
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
                  else if (widget.order.deliveryStatus == 'delivered')
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
                      '${widget.order.deliveryStatus}',
                      style: TextStyle(color: mYellow),
                    ),
                    RichText(
                        text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Ordered by',
                            style: TextStyle(color: mYellow)),
                        TextSpan(
                            text: DateTime.parse(
                                    widget.order.bookingDateTime.replaceAll('  ', ' '))
                                .toLocalDateString,
                            style: TextStyle(color: Colors.black)),
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Payment Method',
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
                    widget.order.paymentType ?? ''),
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
                  'Order summary',
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
                      'Total price',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      '${widget.order.grandTotal} SAR',
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
                      'Delivery fees',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      '${widget.order.tax} SAR',
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
                      'Total',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${widget.order.grandTotal} SAR',
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
                          'Print Invoice',
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
                        onPressed: (){changeStatus(widget.order.deliveryStatus);},
                        child: Text(
                          'Change Status',
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

  Widget _iconText(String image , String text) {
    return Row(
      children: [
        Image.asset(image,width: 20,height: 20,),
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
