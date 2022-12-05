import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:extension_vendor/Providers/orders_model.dart';
import 'package:extension_vendor/Screens/order/order_details.dart';
import 'package:extension_vendor/Widgets/seperator_wedgit.dart';
import 'package:extension_vendor/Providers/datetime.dart';
class OrderWedgit extends StatelessWidget {
 Data order;
  Future<void> Function() onTapFunc;

  OrderWedgit(
      this.order,this.onTapFunc);

  @override
  Widget build(BuildContext context) {

    

    return Container(
      constraints: BoxConstraints(minHeight: 60),
      margin: EdgeInsets.all(16),
      child: GestureDetector(
        onTap: onTapFunc,
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
                        order.id.toString(),
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
                      order.grandTotal,
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
                  order.user_name,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromRGBO(184, 189, 194, 1),
                    fontFamily: "Almarai",
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 8.0, bottom: 8),
                    child: Text(
                      DateTime.parse(order.bookingDateTime.replaceAll('  ', ' ')).toLocalDateString,
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
                      DateFormat('hh:mm a').format(DateTime.parse(order.bookingDateTime.replaceAll('  ', ' '))),
                      style: TextStyle(
                        color: Color.fromRGBO(26, 26, 26, 1),
                        fontFamily: "Almarai",
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
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
                        order.deliveryStatus,
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
            ],
          ),
        ),
      ),
    );
  }
}
