import 'package:flutter/material.dart';
import 'package:salon_vendor/Widgets/seperator_wedgit.dart';

class OrderWedgit extends StatelessWidget {
  final String status;
  final String time;
  final String userName;
  final String serviceCode;
  final String price;
  OrderWedgit(
      this.status, this.time, this.userName, this.serviceCode, this.price);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 60),
      margin: EdgeInsets.all(16),
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
                      serviceCode,
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
                    price,
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
                userName,
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
                time,
                style: TextStyle(
                  color: Color.fromRGBO(26, 26, 26, 1),
                  fontFamily: "Almarai",
                  fontWeight: FontWeight.bold,
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
                      status,
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
    );
  }
}
