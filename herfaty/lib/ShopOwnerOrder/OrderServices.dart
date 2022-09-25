import 'package:flutter/material.dart';

import 'OrderModel.dart';

class OrderServices {
  static List<orderModel> getOrderList() {
    return [
      new orderModel(
          id: '1',
          title: 'First',
          date: '1-1-2022',
          Day: "sunday",
          qantity: 3,
          price: 50,
          image: "a"),
      new orderModel(
          id: '2',
          title: 'Secound',
          date: '1-1-2022',
          Day: "sunday",
          qantity: 3,
          price: 50,
          image: "a"),
    ];
  }
}
