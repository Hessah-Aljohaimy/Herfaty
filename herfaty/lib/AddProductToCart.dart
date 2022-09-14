import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:herfaty/Product1.dart';

class AddProductToCart {
  String name;
  String detailsImage;
  String productId;
  String customerId;
  int quantity;
  int availableAmount;
  num price;

  AddProductToCart({
    required this.name,
    required this.detailsImage,
    required this.productId,
    required this.customerId,
    required this.quantity,
    required this.availableAmount,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = detailsImage;
    data['customerId'] = customerId;
    data['docId'] = productId;
    data['name'] = name;
    data['price'] = price;
    data['quantity'] = quantity;
    data['avalibleAmount'] = availableAmount;

    return data;
  }
}
