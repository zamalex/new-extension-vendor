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

  getAppointments(int page)async {

    if(page==1) {
      loading = true;
      notifyListeners();
    }

    await ApointmentsData().getOrders(page: page,type:'booking').then((value){
      print(value.length);

        loading = false;
        if(page==1){
          appointmeents = value.where((element) => element.orderType=='booking').toList();
          allAppointmeents = value.where((element) => element.orderType=='booking').toList();
        }else{
          appointmeents.addAll(value.where((element) => element.orderType=='booking').toList());
          allAppointmeents.addAll(value.where((element) => element.orderType=='booking').toList());
        }

      });

    notifyListeners();

  }

  getOrders(int page)async{
   if(page==1) {
     loading = true;
     notifyListeners();
   }
    await ApointmentsData().getOrders(page: page,type:'purchase').then((value){
      loading = false;

      if(page==1){

        orders = value.where((element) => element.orderType=='purchase').toList();
        allOrders = value.where((element) => element.orderType=='purchase').toList();

      }else{

        orders.addAll(value.where((element) => element.orderType=='purchase').toList());
        allOrders.addAll(value.where((element) => element.orderType=='purchase').toList());

      }

    });

    notifyListeners();
  }

}