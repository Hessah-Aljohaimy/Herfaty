import 'package:herfaty/models/category.dart';

class Product {
  String? id;
  String? name;
  String? dsscription;
  String? categoryName;
  String? image;
  int? avalibleAmount;
  double? price;

  Product(
      {this.id,
      this.name,
      this.dsscription,
      required this.categoryName,
      this.image,
      this.avalibleAmount,
      this.price});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dsscription': dsscription,
      'categoryName': categoryName,
      'image': image,
      'avalibleAmount': avalibleAmount,
      'price': price
    };
  }
}
