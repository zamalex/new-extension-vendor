import 'package:flutter/material.dart';
import 'package:salon_vendor/Providers/orders_model.dart';
import 'package:salon_vendor/Providers/datetime.dart';
class AppointmentDetails extends StatelessWidget {

  Data order;
  AppointmentDetails(this.order);
  final mGrey = const Color.fromRGBO(118, 123, 128, 1);
  final dGrey = const Color.fromRGBO(184, 189, 194, 1);
  final mYellow = const Color.fromRGBO(93, 174, 255, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(118, 123, 128, 1),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Appointment Details',style: TextStyle(
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
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 30,
                  ),
                  title: Text(
                    order.user_name,
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
                    Icon(
                      Icons.location_pin,
                      color: mGrey,
                      size: 30,
                    ),
                    'Address'),
                SizedBox(
                  height: 5,
                ),
                Text(
                  order.user_address??'',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 10,
                ),
                _iconText(
                    Icon(
                      Icons.location_pin,
                      color: mGrey,
                      size: 30,
                    ),
                    'Email address'),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Ahlam_Ab22@gmail.com',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 10,
                ),
                _iconText(
                    Icon(
                      Icons.location_pin,
                      color: mGrey,
                      size: 30,
                    ),
                    'Phone number'),
                SizedBox(
                  height: 5,
                ),
                Text(
                  order.user_phone,
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
                    Icon(
                      Icons.location_pin,
                      color: mGrey,
                      size: 30,
                    ),
                    'Service code. ${order.id}'),
                SizedBox(
                  height: 10,
                ),
                _iconText(
                    Icon(
                      Icons.location_pin,
                      color: mGrey,
                      size: 30,
                    ),
                    'Invoice summary'),
                SizedBox(
                  height: 10,
                ),
                if(order.deliveryStatus=='pending')
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
                else if(order.deliveryStatus=='active')
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
                else if(order.deliveryStatus=='done')
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
                      order.deliveryStatus,
                      style: TextStyle(color: mYellow),
                    ),
                    RichText(
                        text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Booked by',
                            style: TextStyle(color: mYellow)),
                        TextSpan(
                            text: ' ${DateTime.parse(
                                order.bookingDateTime.replaceAll('  ', ' '))
                                .toLocalDateString}',
                            style: TextStyle(color: Colors.black)),
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 30,
                  ),
                  title: Text(
                    'AMohamed',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(
                    'Pro barber',
                    style: TextStyle(color: mGrey),
                  ),
                  trailing: ElevatedButton.icon(
                    onPressed: null,
                    icon: Text(
                      '4.8',
                      style: TextStyle(color: Colors.black),
                    ),
                    label: Icon(
                      Icons.star,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.grey,
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
                    Icon(
                      Icons.location_pin,
                      color: mGrey,
                      size: 30,
                    ),
                    order.paymentType),
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
                      '${order.grandTotal} SAR',
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
                      '${order.grandTotal} SAR',
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

  Widget _iconText(Widget icon, String text) {
    return Row(
      children: [
        icon,
        Text(
          text,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        )
      ],
    );
  }

  Widget _iconTextLight(Widget icon, String text) {
    return Row(
      children: [
        icon,
        Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: 17),
        )
      ],
    );
  }
}
