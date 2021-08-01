import 'dart:io';

import 'package:flutter/material.dart';
import 'package:salon_vendor/Providers/notification_model.dart';
import 'package:salon_vendor/Providers/notifications.dart';
import 'package:salon_vendor/Widgets/notification_wedgit.dart';
// import 'package:takafol/Providers/constants.dart';
// import 'package:takafol/Utilities/static_functions.dart';
// import 'package:takafol/Widgets/loginCustomeAlert.dart';
// import 'package:takafol/Widgets/notification_wedgit.dart';

class UserNotificationsList extends StatefulWidget {
  @override
  _UserNotificationsListState createState() => _UserNotificationsListState();
}

class _UserNotificationsListState extends State<UserNotificationsList> {
  List<Notifications> notifications = [];
  bool loading = false;
  List<UserNotification> userNotifications = [
    UserNotification(
        id: 1,
        title: "Appointment Request",
        time: "tue, dec 20, 2020 at 15:30",
        userName: "fatma mohamed",
        serviceCode: "#787397",
        price: "60.00 SAR")
  ];
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
    Notifications().getNotifications().then((value){

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
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        backgroundColor: Color.fromRGBO(118, 123, 128, 1),
      ),
      body: !loading
          ? ListView.builder(
              itemCount: userNotifications.length,
              itemBuilder: (context, index) => UserNotificationWedgit(
                 notifications[index]),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
