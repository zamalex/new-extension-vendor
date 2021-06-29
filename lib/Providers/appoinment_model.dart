class AppointmentModel {
  String time;
  String userName;
  int id;
  String serviceCode;
  String price;
  String status;
  

  AppointmentModel(
      {this.id, this.status, this.time, this.userName, this.serviceCode, this.price});
}