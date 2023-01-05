import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:extension_vendor/Providers/notification_model.dart';
import 'package:extension_vendor/Providers/notifications.dart';
import 'package:extension_vendor/Widgets/notification_wedgit.dart';


class UserNotificationsList extends StatefulWidget {
  @override
  _UserNotificationsListState createState() => _UserNotificationsListState();
}

class _UserNotificationsListState extends State<UserNotificationsList> {
  List<NotificationData> notifications = [];
  bool loading = false;

  // List<UserNotification> userNotifications = <UserNotification>(new UserNotification(id:1,title:'test title', time:'12',content:'text content',isRead: false));
  var _init = true;
  var isNotificationLoaded = true;

  // Future<void> getNotificationList() async {
  //   var userNotification = UserNotification();
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       var response = await userNotification.getNotifications();
  //       if (response[0] == true) {
  //         setState(() {
  //           isNotificationLoaded = true;
  //           userNotifications = response[1];
  //         });
  //       } else {
  //         userNotifications = List<UserNotification>();
  //         // StaticFunctions.showErrorNote(context, response[1]);
  //       }
  //     }
  //   } on SocketException catch (_) {
  //     StaticFunctions.showErrorNote(context, Constants.NO_INTERNET_CONNECTION);
  //   } catch (error) {
  //     StaticFunctions.showErrorNote(context, Constants.SERVER_ERROR);
  //   }
  // }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_init) {
      // getNotificationList();
      // userNotifications.add(
      //      UserNotification(
      //         id: 0,
      //         title: 'title',
      //         content: 'content',
      //         time: '12:00',)
      // );
    }
    _init = false;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      loading = true;
    });
    NotificationResponse().getNotifications().then((value){

      setState(() {
        notifications = value;
        loading = false;
      });
    });
    // if (Constants.USER_TOKEN == "" || Constants.USER_TOKEN == null) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //     // if Constants.USER_TOKEN != ""{

    //     await showDialog(
    //       context: context,
    //       barrierDismissible: false,
    //       builder: (BuildContext context) =>
    //           LoginCustomAlert("عليك تسجيل الدخول أولا", true),
    //     );
    //     // }
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications'.tr(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        backgroundColor:  Color.fromRGBO(127, 71, 150, 1),
      ),
      body: !loading
          ? ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) => UserNotificationWedgit(
                 notifications[index]),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
