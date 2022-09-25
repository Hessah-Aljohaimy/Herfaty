import 'package:flutter/services.dart';

class orderModel {
  String id;
  late String title;
  late String date;
  late String Day;
  late int qantity;
  late double price;
  late String image;

  orderModel(
      {required this.id,
      required this.title,
      required this.date,
      required this.Day,
      required this.qantity,
      required this.price,
      required this.image});
}
