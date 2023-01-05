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
import 'my_appointment_item.dart';

class WorkerAppointmentsList extends StatefulWidget {
  @override
  _WorkerAppointmentsListState createState() => _WorkerAppointmentsListState();
}

class _WorkerAppointmentsListState extends State<WorkerAppointmentsList> {

  TextEditingController controller = new TextEditingController();

  var _init = true;
  var isNotificationLoaded = true;
  ScrollController _scrollController = new ScrollController();


  Future<void> goAppoinmentDetails(Data appointment) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AppointmentDetails(appointment)),
    );
  }



  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_init) {

    }
    _init = false;
  }

  @override
  void initState() {
    super.initState();


    Future.delayed(Duration.zero).then((value){
      Provider.of<OrdersProvider>(context, listen: false).getWorkerAppointments();

    });
    _scrollController
        .addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent&&Provider.of<OrdersProvider>(context, listen: false).loadMore) {
        Future.delayed(Duration.zero).then((value){
          Provider.of<OrdersProvider>(context, listen: false).getWorkerAppointments();

        });        }
    });

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
          InkWell(child: Icon(Icons.language,color: Colors.white,),onTap: showLanguageDialog,),

          InkWell(
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
         Expanded(
            child:Consumer<OrdersProvider>(
              builder: (context, value, child) => value.loading?Center(child: CircularProgressIndicator(),): ListView.builder(
                controller: _scrollController,
                itemCount: value.workerAppointments.length,
                itemBuilder: (context, index) =>InkWell
                  (onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppointmentDetails(value.workerAppointments[index])),
                  );
                },child: MyAppointmentItem(value.workerAppointments[index])),
              ),
            )

            ),

        ],
      ),
    );
  }
}
