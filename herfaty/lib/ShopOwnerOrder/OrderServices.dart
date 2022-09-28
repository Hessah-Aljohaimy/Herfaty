import 'package:flutter/material.dart';

import 'OrderModel.dart';

class OrderServices {
  static List<orderModel> getOrderList() {
    return [
      new orderModel(
        shopOwnerID: '1',
        customerID: '2',
        orderDate: '2/2/1444',
        orderDay: "sunday",
        qantity: 3,
        totalPrice: 30,
        image: "a",
      ),
      new orderModel(
        shopOwnerID: '1',
        customerID: '2',
        orderDate: '2/2/1444',
        orderDay: "sunday",
        qantity: 3,
        totalPrice: 30,
        image: "a",
      ),
    ];
  }
}
