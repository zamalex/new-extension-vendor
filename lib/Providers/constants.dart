import 'package:flutter/material.dart';
import 'package:extension_vendor/Providers/user_model.dart';

class Constants {
  static const DOMAIN = "https://extension.badee.com.sa/api/v2/";

  static List<String> STATUSES = [
    'pending',
  'active'
    ,'confirmed','finished',
  ];
  static List<String> STAFF_STATUSES = [
    'pending',
    'confirmed',
  'active'
    ,'finished',
  ];

  static List<String> STATUSES_ORDER = [
    'pending',
  'on the way'
    ,'confirmed','finished',
  ];
  //Global var
  static User CURRENT_USER = User();
  static String USER_TOKEN = null;
  static String USER_TYPE = '';
  static String PLAYER_ID = "";
  static Color kPrimaryColor =  Color.fromRGBO(127, 71, 150, 1);//Color.fromRGBO(118, 123, 128, 1);
  static var HEADER = {
    "Accept": "application/json",
    // "Authorization": "bearer " + Constants.USER_TOKEN,
    "Authorization": "Bearer " + Constants.USER_TOKEN,
  };

 static Map<String,dynamic> getHeader(){
    return {
      "Accept": "application/json",
      // "Authorization": "bearer " + Constants.USER_TOKEN,
      "Authorization": "Bearer " + Constants.USER_TOKEN,
    };
  }

  static var LOCATION = {"latitude": "0", "longitude": "0"};
  static var NO_INTERNET_CONNECTION = 'لا يوجد انترنت';
  static var SERVER_ERROR = 'حدث خطأ .. حاول لاحقا';

  static const BACKGROUND_COLOR = Color.fromRGBO(246, 247, 251, 1);
}
