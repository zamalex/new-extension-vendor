import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:salon_vendor/Providers/http_manager.dart';

import 'constants.dart';



class ApointmentsData {
  List<Data> data;
  bool success;
  int status;

  ApointmentsData({this.data, this.success, this.status});

  ApointmentsData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v as Map<String,dynamic>));
      });
    }
    success = json['success'] as bool;
    status = json['status'] as int;
  }

  Future<List<Data>> getOrders({int page=1}) async {




    try {
      Response response = await Dio().get('${Constants.DOMAIN}shop-staff/orders',options: Options(headers: Constants.HEADER));


      print(response.data);

      if(response.statusCode>=400){
        return [];

      }else{
       // final responseJson = json.decode(response.data);
       // print('response json '+responseJson);
        if(response.data['success'] as bool==false){
          return [];
        }else{
          return ApointmentsData.fromJson(response.data as Map<String,dynamic>).data;
        }
      }



    } catch (error) {
      print(error);
      return [];
    }
  }
  
  
}

class Data {
  int id;
  String orderType;
  String bookingDateTime;
  String code;
  String tax;
  String user_name;
  String user_phone;
  String receiving_date;
  String user_address;
  int userId;
  String paymentType;
  String shippingTypeString;
  String paymentStatus;
  String paymentStatusString;
  String deliveryStatus;
  String deliveryStatusString;
  String grandTotal;
  String date;
  bool cancelRequest;
  bool canCancel;
  Shop shop;
  Order items;

  Data(
      {this.id,
        this.orderType,
        this.bookingDateTime,
        this.code,
        this.userId,
        this.paymentType,
        this.shippingTypeString,
        this.paymentStatus,
        this.paymentStatusString,
        this.deliveryStatus,
        this.deliveryStatusString,
        this.grandTotal,
        this.date,
        this.cancelRequest,
        this.canCancel,
        this.shop,
        this.items});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    orderType = json['order_type']as String;
    bookingDateTime = json['delivery_date_time']as String;
    code = json['code']as String;
    paymentType = json['payment_type']as String;
    userId = json['user_id']as int;
    paymentStatus = json['payment_status']as String;
    paymentStatusString = json['payment_status_string']as String;
    deliveryStatus = json['delivery_status']as String;
    deliveryStatusString = json['delivery_status_string']as String;
    grandTotal = json['grand_total']as String;
    tax = json['tax']as String;
    user_name = json['user_name']as String;
    user_phone = json['user_phone']as String;
    user_address = json['user_address']as String??'';
   // receiving_date = json['receiving_date']as String??'';

    date = json['date']as String;
    cancelRequest = json['cancel_request']as bool;
    canCancel = json['can_cancel']as bool;
    shop = json['shop'] != null ?  Shop.fromJson(json['shop'] as Map<String,dynamic>) : null;
    items = json['items'] != null ?  Order.fromJson(json['items']as Map<String,dynamic>) : null;
  }

}



class Shop {
  List<SalonData> data;

  Shop({this.data});

  Shop.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add( SalonData.fromJson(v as Map<String,dynamic>));
      });
    }
  }


}

class SalonData {
  int id;
  String name;
  String address;
  String phone;
  String longitude;
  String latitude;

  SalonData(
      {this.id,
        this.name,
        this.address,
        this.phone,
        this.longitude,
        this.latitude});

  SalonData.fromJson(Map<String, dynamic> json) {
    id = json['id']as  int;
    name = json['name']as String;
    address = json['address']as String;
    phone = json['phone']as String;
    longitude = json['longitude']as String;
    latitude = json['latitude']as String;
  }

}


class Order {
  List<OrderData> data;

  Order({this.data});

  Order.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add( OrderData.fromJson(v as Map<String,dynamic>));
      });
    }
  }


}
class OrderData {
  String orderType;
  int productId;
  String productName;
  String price;
  int quantity;

  OrderData(
      {this.orderType,
        this.productId,
        this.productName,
        this.price,
        this.quantity});

  OrderData.fromJson(Map<String, dynamic> json) {
    orderType = json['order_type']as String;
    productId = json['product_id']as int;
    productName = json['product_name']as String;
    price = json['price']as String;
    quantity = json['quantity']as int;
  }


}