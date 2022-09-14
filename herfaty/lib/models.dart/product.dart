import 'package:herfaty/models.dart/category.dart';

class Product {
  String? name;
  String? dsscription;
  String? categoryName;
  String? image;
  int? avalibleAmount;
  double? price;

  Product(
      {this.name,
      this.dsscription,
      required this.categoryName,
      this.image,
      this.avalibleAmount,
      this.price});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dsscription': dsscription,
      'categoryName': categoryName,
      'image': image,
      'avalibleAmount': avalibleAmount,
      'price': price
    };
  }
}
