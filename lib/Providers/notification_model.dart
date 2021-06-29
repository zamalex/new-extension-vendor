


class UserNotification {
  String title;
  String time;
  String userName;
  bool isRead;
  int id;
  String serviceCode;
  String price;
  

  UserNotification(
      {this.id, this.title, this.time, this.userName, this.isRead = false, this.serviceCode, this.price});

 /* Future<List> getNotifications() async {
    print(Constants.GET_NOTIFICATIONS_URL);

    try {
      var response = await http.get(
        Uri.parse(Constants.GET_NOTIFICATIONS_URL),
        headers: Constants.HEADER,
      );
      final responseJson = json.decode(response.body);
      print(responseJson);
      List<UserNotification> notificationList = new List<UserNotification>();
      if (responseJson["success"] == true) {
        var data = responseJson["data"];

        for (var i = 0; i < data.length; i++) {
          notificationList.add(UserNotification(
              id: data[i]['id'],
              title: 'not geted yet',
              content: data[i]['content'],
              time: data[i]['created_at_human']));
        }

        return [true, notificationList, responseJson["message"]];
      } else {
        return [false, notificationList, responseJson["message"]];
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }*/

 /* Future<void> sendPlayerId(String playerId) async {
    var param = {
      'player_id': playerId,
    };
    print(Constants.REGISTER_URL);
    print(param);

    try {
      var response = await http.post(
        Uri.parse(Constants.SUBSCRIBE_NOTIFICATION),
        body: param,
        // headers: Constants.HEADER,
      );
      final responseJson = json.decode(response.body);
      print(responseJson);
    } catch (error) {
      print(error);
      throw error;
    }
  }*/
}
