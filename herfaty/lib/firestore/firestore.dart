// TODO Implement this library.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herfaty/models.dart/product.dart';

class Firestore {
  static Future saveProduct(Product product) async {
    //async because it takes time
    await FirebaseFirestore.instance
        .collection("Products")
        .add(product.toMap());
  }
}
