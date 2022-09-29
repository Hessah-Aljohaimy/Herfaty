import 'package:flutter/services.dart';

class orderModel {
  String shopOwnerID;
  String customerID;
  String image;
  String orderDate;
  String qantity;
  String totalPrice;
  String orderDay;

  orderModel({
    required this.shopOwnerID,
    required this.customerID,
    required this.image,
    required this.orderDate,
    required this.qantity,
    required this.totalPrice,
    required this.orderDay,
  });

  static orderModel fromJson(Map<String, dynamic> json) => orderModel(
        shopOwnerID: json['ShopOwnerID'],
        customerID: json['customerID'],
        image: json['image'],
        orderDate: json['orderDate'],
        qantity: json['qantity'],
        totalPrice: json['totalPrice'],
        orderDay: json['orderDay'],
      );
}
