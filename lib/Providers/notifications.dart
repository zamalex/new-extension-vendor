import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:salon_vendor/Providers/http_manager.dart';

import 'constants.dart';



class Notifications {
  int id;
  int price;
  String title;
  String description;
  String sentAt;
  Info options;

  Notifications(
      {this.id,
        this.price,
        this.title,
        this.description,
        this.sentAt,
        this.options});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    title = json['title'];
    description = json['description'];
    sentAt = json['sent_at'];
    options =
    json['options'] != null ?  Info.fromJson(json['options']) : null;
  }


  Future<List<Notifications>> getNotifications({int page=1}) async {

    try {

      Response response = await HttpManager.getInstance().get('${Constants.DOMAIN}notifications',options: Options(headers: Constants.HEADER));




      if(response.statusCode>=400){
        return [];

      }else{
        // final responseJson = json.decode(response.data);
        // print('response json '+responseJson);

          return List<Notifications>.from(response.data.map((i) => Notifications.fromJson(i)));

      }



    } catch (error) {
      print(error);
      return [];
    }
  }

}

class Info {
  int orderId;
  String orderType;
  String userName;

  Info({this.orderId, this.orderType, this.userName});

  Info.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderType = json['order_type'];
    userName = json['user_name'];
  }

}