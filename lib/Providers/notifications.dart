import 'package:dio/dio.dart';

import 'constants.dart';
import 'http_manager.dart';

class NotificationResponse {
  Data data;
  int statusCode;
  String message;

  NotificationResponse({this.data, this.statusCode, this.message});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    statusCode = json['status_code'];
    message = json['message'];
  }


  Future<List<NotificationData>> getNotifications({int page=1}) async {

    try {

      Response response = await HttpManager.getInstance().get('${Constants.DOMAIN}notifications',options: Options(headers: Constants.HEADER));




      if(response.statusCode>=400){
        return [];

      }else{
        // final responseJson = json.decode(response.data);
        print('response json '+response.data.toString());

        return NotificationResponse.fromJson(response.data).data.notifications;

      }



    } catch (error) {
      print(error);
      return [];
    }
  }
}

class Data {
  List<NotificationData> notifications;

  Data({this.notifications});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      notifications = <NotificationData>[];
      json['data'].forEach((v) {
        notifications.add(new NotificationData.fromJson(v));
      });
    }
  }


}

class NotificationData {
  int id;
  String title;
  String content;
  String createdAt;
  int seen;

  NotificationData({this.id, this.title, this.content, this.createdAt, this.seen});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createdAt = json['created_at'];
    seen = json['seen'];
  }


}