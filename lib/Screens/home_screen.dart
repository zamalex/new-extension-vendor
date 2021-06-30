import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_vendor/Screens/Notification/NotificationList.dart';
import 'package:salon_vendor/Screens/appoinment/appointment_list.dart';
import 'package:salon_vendor/Screens/order/orders_list.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(235, 235, 235, 1),
        showUnselectedLabels: false,
          selectedItemColor: Colors.white,

        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/Document@3x.png',
              width: 32,
              height: 32,
            ),
            activeIcon: Image.asset(
              'assets/images/Calendar Selected@3x.png',
              width: 32,
              height: 32,
              // color: Color.fromRGBO(118, 123, 128, 1),
            ),
            label: 'Appoinments',
            
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/Buy@3x.png',
              width: 32,
              height: 32,
            ),
            activeIcon: Image.asset(
              'assets/images/Buy Selected@3x.png',
              width: 32,
              height: 32,
              // color: Color.fromRGBO(118, 123, 128, 1),
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/Notification@3x.png',
              width: 32,
              height: 32,
            ),
            activeIcon: Image.asset(
              'assets/images/Notification@3x.png',
              width: 32,
              height: 32,
              color: Colors.white,
            ),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}
