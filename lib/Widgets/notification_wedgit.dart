import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:extension_vendor/Providers/notifications.dart';
import 'package:extension_vendor/Providers/datetime.dart';
class UserNotificationWedgit extends StatelessWidget {
  NotificationData item;
  UserNotificationWedgit(this.item
      );
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
              padding: const EdgeInsets.only(top: 15, left: 15.0, right: 15),
              child: Text(
                item.title??'',
                style: TextStyle(
                  color: Color.fromRGBO(26, 26, 26, 1),
                  fontFamily: "Almarai",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 10),
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only( right: 15.0, left: 15),
                  child: Text(
                    '',
                    style: TextStyle(
                      color: Color.fromRGBO(26, 26, 26, 1),
                      fontFamily: "Almarai",
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ]),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 15.0, left: 15, top: 10),
              child: Text(
                item.content??'',
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
                '${DateTime.parse(item.createdAt.replaceAll('  ', ' ')).toLocalDateString} ${DateFormat('hh:mm a').format(DateTime.parse(item.createdAt.replaceAll('  ', ' ')))}',
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
      ),
    );
  }
}
