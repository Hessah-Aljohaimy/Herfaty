// TODO Implement this library.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herfaty/models/product.dart';

class Firestore {
  static Future saveProduct(Product product) async {
    //async because it takes time

    /* final productToBeAdded = await FirebaseFirestore.instance
        .collection("Products")
        .add(product.toMap(productToBeAdded.id)); */

    /* final productoBeAdded = FirebaseFirestore.instance
        .collection('Products')
        .doc("");*/

    final productToBeAdded =
        FirebaseFirestore.instance.collection('Products').doc();
    final json = product.toJson();
    await productToBeAdded.set(json);
  }
}
