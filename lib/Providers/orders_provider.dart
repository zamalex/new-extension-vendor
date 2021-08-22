import 'package:flutter/foundation.dart';

import 'orders_model.dart';

class OrdersProvider extends ChangeNotifier{
  List<Data> appointmeents = [

  ];
  List<Data> allAppointmeents = [

  ];

  List<Data> orders = [];
  List<Data> allOrders = [];


  bool loading = false;


  osearch(String query){
    if(query.isNotEmpty){
        orders = allOrders.where((element) => element.user_name.toLowerCase().contains(query.toLowerCase())||element.id.toString().toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }

  oclear(){
      orders = allOrders;
      notifyListeners();
  }
  search(String query){
    if(query.isNotEmpty){

        appointmeents = allAppointmeents.where((element) => element.user_name.toLowerCase().contains(query.toLowerCase())||element.id.toString().toLowerCase().contains(query.toLowerCase())).toList();

    }
    notifyListeners();
  }

  clear(){

      appointmeents = allAppointmeents;

      notifyListeners();
  }

  getAppointments()async {

    loading = true;
    notifyListeners();

    await ApointmentsData().getOrders(page: 1).then((value){
      print(value.length);

        loading = false;
        appointmeents = value.where((element) => element.orderType=='booking').toList();
        allAppointmeents = value.where((element) => element.orderType=='booking').toList();
      });

    notifyListeners();

  }

  getOrders()async{
    loading = true;
    notifyListeners();

    await ApointmentsData().getOrders(page: 1).then((value){
      loading = false;


        orders = value.where((element) => element.orderType=='purchase').toList();
        allOrders = value.where((element) => element.orderType=='purchase').toList();

    });

    notifyListeners();
  }

}