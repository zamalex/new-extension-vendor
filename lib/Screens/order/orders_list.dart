import 'dart:io';

import 'package:flutter/material.dart';
import 'package:salon_vendor/Providers/appoinment_model.dart';
import 'package:salon_vendor/Providers/notification_model.dart';
import 'package:salon_vendor/Providers/order_model.dart';
import 'package:salon_vendor/Widgets/notification_wedgit.dart';
import 'package:salon_vendor/Widgets/order_wedgit.dart';
// import 'package:takafol/Providers/constants.dart';
// import 'package:takafol/Utilities/static_functions.dart';
// import 'package:takafol/Widgets/loginCustomeAlert.dart';
// import 'package:takafol/Widgets/notification_wedgit.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<OrderModel> appointmeents = [
    OrderModel(
        id: 1,
        status: "active",
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
        backgroundColor: Color.fromRGBO(118, 123, 128, 1),
        title: Text(
          'Orders',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
      body: isNotificationLoaded
          ? ListView.builder(
              itemCount: appointmeents.length,
              itemBuilder: (context, index) => OrderWedgit(
                  appointmeents[index].status,
                  appointmeents[index].time,
                  appointmeents[index].userName,
                  appointmeents[index].serviceCode,
                  appointmeents[index].price),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
