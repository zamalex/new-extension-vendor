import 'package:flutter/material.dart';

class Constants {
  static const DOMAIN = "http://takaful.badee.com.sa/api/v1/";

  
  //Global var
  // static User CURRENT_USER = User();
  static String USER_TOKEN = "";
  static String PLAYER_ID = "";
  static var HEADER = {
    "Accept": "application/json",
    // "Authorization": "bearer " + Constants.USER_TOKEN,
    "Authorization": "Bearer " + Constants.USER_TOKEN,
  };

  static var LOCATION = {"latitude": "0", "longitude": "0"};
  static var NO_INTERNET_CONNECTION = 'لا يوجد انترنت';
  static var SERVER_ERROR = 'حدث خطأ .. حاول لاحقا';

  static const BACKGROUND_COLOR = Color.fromRGBO(246, 247, 251, 1);
}
