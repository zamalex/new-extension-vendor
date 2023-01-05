import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:extension_vendor/Providers/appoinment_model.dart';
import 'package:extension_vendor/Providers/constants.dart';
import 'package:extension_vendor/Providers/notification_model.dart';
import 'package:extension_vendor/Providers/orders_model.dart';
import 'package:extension_vendor/Providers/orders_provider.dart';
import 'package:extension_vendor/Screens/appoinment/appointment_details.dart';
import 'package:extension_vendor/Screens/vendor_login.dart';
import 'package:extension_vendor/Widgets/notification_wedgit.dart';
import 'package:extension_vendor/Widgets/order_wedgit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/change_locale_dialog.dart';
// import 'package:takafol/Providers/constants.dart';
// import 'package:takafol/Utilities/static_functions.dart';
// import 'package:takafol/Widgets/loginCustomeAlert.dart';
// import 'package:takafol/Widgets/notification_wedgit.dart';

class AppointmentList extends StatefulWidget {
  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {

  TextEditingController controller = new TextEditingController();
 
  // List<UserNotification> userNotifications = <UserNotification>(new UserNotification(id:1,title:'test title', time:'12',content:'text content',isRead: false));
  var _init = true;
  var isNotificationLoaded = true;
  ScrollController _scrollController = new ScrollController();

  int page = 1;
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
  Future<void> goAppoinmentDetails(Data appointment) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AppointmentDetails(appointment)),
    );
  }

  onSearchTextChanged(String text) async {
    //   _searchResult.clear();
    //   if (text.isEmpty) {
    //     setState(() {});
    //     return;
    //   }

    //   _userDetails.forEach((userDetail) {
    //     if (userDetail.firstName.contains(text) || userDetail.lastName.contains(text))
    //       _searchResult.add(userDetail);
    //   });

    //   setState(() {});
    // }
  }


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


    Future.delayed(Duration.zero).then((value){
      Provider.of<OrdersProvider>(context, listen: false).getAppointments(page);

    });

    _scrollController
        .addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Future.delayed(Duration.zero).then((value){
          Provider.of<OrdersProvider>(context, listen: false).getAppointments(++page);

        });        }
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
  void showLanguageDialog() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            // height: 220,
            child: ChangeLocaleDoialog(),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    ).then((value){
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(child: Icon(Icons.language,color: Colors.white,),onTap: showLanguageDialog,)

          ,InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('token');
              Constants.USER_TOKEN = null;

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => VendorLogin()),
              );
            },
            child:  Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Logout'.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,

                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10,)
        ],
        title: Text(
          'Appointments'.tr(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        backgroundColor:  Color.fromRGBO(127, 71, 150, 1),
      ),
      body: Column(
        children: [
          new Container(
            color:  Color.fromRGBO(127, 71, 150, 1),
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    onSubmitted: (query)=>Provider.of<OrdersProvider>(context, listen: false).search(query),
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      Provider.of<OrdersProvider>(context, listen: false).clear();
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
          Provider.of<OrdersProvider>(context,).loading?Center(child: CircularProgressIndicator(),): Expanded(
            child: isNotificationLoaded
                ? ListView.builder(
                  controller: _scrollController,
                    itemCount: Provider.of<OrdersProvider>(context,).appointmeents.length,
                    itemBuilder: (context, index) => OrderWedgit(
                        Provider.of<OrdersProvider>(context,).appointmeents[index],
                        () => goAppoinmentDetails(Provider.of<OrdersProvider>(context,listen: false).appointmeents[index])),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
    );
  }
}
