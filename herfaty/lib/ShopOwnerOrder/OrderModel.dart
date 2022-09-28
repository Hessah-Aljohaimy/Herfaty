import 'package:flutter/services.dart';

class orderModel {
  String shopOwnerID;
  late String customerID;
  late String orderDate;
  late String orderDay;
  late int qantity;
  late double totalPrice;
  late String image;

  orderModel(
      {required this.shopOwnerID,
      required this.customerID,
      required this.orderDate,
      required this.orderDay,
      required this.qantity,
      required this.totalPrice,
      required this.image});
}
