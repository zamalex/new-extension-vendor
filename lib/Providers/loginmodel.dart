import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:extension_vendor/Providers/constants.dart';

import 'http_manager.dart';


class LoginModel {
  LoginModel({
    this.accessToken,
    this.user,
    this.result,
    this.message
  });

  String accessToken;
  String message;
  User user;
  bool result;


  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
      accessToken: json['access_token'].toString(),
      result: json['result'].toString()=='true',
      user: User.fromJson(json['user']as Map<String,dynamic>),
      message: json['message'].toString()??''
  );


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    data['access_token'] = this.accessToken;

    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }

  Future<LoginModel> loginUser(String email, String password) async {
    var param = {
      'phone': email,
      'email': email,
      'password': password,
    };



    try {


      Response response ;
      response = await HttpManager.getInstance().post('${Constants.DOMAIN}auth/login',data: param);
      //response = await HttpManager.getInstance().post();
      final responseJson = response.data;
      if(responseJson['result'] as bool==false){
        return LoginModel(result: false,message:responseJson['message'].toString() );
      }

      return LoginModel.fromJson(responseJson as Map<String,dynamic>);
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future sendPlayerID(String id) async {

    Map<String, String> headers = {
      'Authorization': 'Bearer ${Constants.USER_TOKEN}',
      'Content-Type': 'application/json',
      'Current-Locale':Intl.getCurrentLocale()
    };

    Map<String,dynamic> body = {
      'player_id':id,
    };


    try {
      var response = await http.post(
          Uri.parse('${Constants.DOMAIN}notifications/subscribe'),
          headers: headers,
          body:jsonEncode(body)
      );

      print('request  is '+'${Constants.DOMAIN}notifications/subscribe');
      print('response  is '+response.body);
      print('body  is '+body.toString());


      return true;

    } catch (error) {
      print(error);
      return false;
    }
  }

}

class User {
  User({
    this.id,
    this.name,
    this.avatar,
    this.email,
    this.type,
    this.phone,
  });

  int id;
  String name;
  String avatar;
  String type;

  String phone;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: int.parse(json['id'].toString()),
    name: json['name'].toString(),
    avatar: json['avatar'].toString(),
    email: json['email'].toString(),
    type: json['type'].toString(),

    phone: json['phone'].toString(),
  );


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }

}
