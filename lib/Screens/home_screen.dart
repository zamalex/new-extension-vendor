import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:extension_vendor/Providers/constants.dart';
import 'package:extension_vendor/Screens/Notification/NotificationList.dart';
import 'package:extension_vendor/Screens/appoinment/appointment_list.dart';
import 'package:extension_vendor/Screens/order/orders_list.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0; //New
  List<Widget> _pages = <Widget>[
    AppointmentList(),
    OrderList(),
    UserNotificationsList(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
   final kPrimaryColor =  Color.fromRGBO(127, 71, 150, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(235, 235, 235, 1),
        showSelectedLabels: false,
        showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [

          BottomNavigationBarItem(

              icon: Container(
                  height: 40,
               //   margin: EdgeInsets.symmetric(horizontal: 5),
                  // padding: EdgeInsets.all(8),
                  decoration:  BoxDecoration(
                    color: _selectedIndex==0? Color.fromRGBO(127, 71, 150, 1):Colors.transparent,
                    borderRadius:  BorderRadius.circular(20),
                  ),
                  child: _selectedIndex==0?Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [Image.asset(
                    'assets/images/Calendar Selected@3x.png',
                    width: 20,
                    height: 20,
                    color: _selectedIndex==0?Colors.white:kPrimaryColor,

                  ),Text('Appointments'.tr(),style:TextStyle(color: Colors.white),)],):Image.asset(
                    'assets/images/Calendar Selected@3x.png',
                    width: 20,
                    height: 20,
                    color: kPrimaryColor,
                  )
              ),
              label: ''
          ),

          BottomNavigationBarItem(

              icon: Container(
                  height: 40,
                //  margin: EdgeInsets.symmetric(horizontal: 5),
                  // padding: EdgeInsets.all(8),
                  decoration:  BoxDecoration(
                    color: _selectedIndex==1? Color.fromRGBO(127, 71, 150, 1):Colors.transparent,
                    borderRadius:  BorderRadius.circular(20),
                  ),
                  child: _selectedIndex==1?Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [Image.asset(
                    'assets/images/Buy Selected@3x.png',
                    width: 20,
                    height: 20,
                    color: _selectedIndex==1?Colors.white:kPrimaryColor,

                  ),Text('Orders'.tr(),style:TextStyle(color: Colors.white),)],):Image.asset(
                    'assets/images/Buy@3x.png',
                    width: 20,
                    height: 20,
                    color: kPrimaryColor,
                  )
              ),
              label: ''
          ),
          BottomNavigationBarItem(

              icon: Container(
                  height: 40,
                 // margin: EdgeInsets.symmetric(horizontal: 5),
                  // padding: EdgeInsets.all(8),
                  decoration:  BoxDecoration(
                    color: _selectedIndex==2? Color.fromRGBO(127, 71, 150, 1):Colors.transparent,
                    borderRadius:  BorderRadius.circular(20),
                  ),
                  child: _selectedIndex==2?Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [Image.asset(
                    'assets/images/Notification@3x.png',
                    width: 20,
                    height: 20,
                    color: _selectedIndex==2?Colors.white:kPrimaryColor,

                  ),Text('Notifications'.tr(),style:TextStyle(color: Colors.white),)],):Image.asset(
                    'assets/images/Notification@3x.png',
                    width: 20,
                    height: 20,
                    color: kPrimaryColor,
                  )
              ),
              label: ''
          ),

        ],
      ),
    );
  }
}
