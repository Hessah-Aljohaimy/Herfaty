import 'package:herfaty/models.dart/category.dart';

class Product {
  String? name;
  String? dsscription;
  String? categoryName;
  String? image;
  int? avalibleAmount;

  Product({
    this.name,
    this.dsscription,
    required this.categoryName,
    this.image,
    this.avalibleAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dsscription': dsscription,
      'categoryName': categoryName,
      'image': image,
      'avalibleAmount': avalibleAmount
    };
  }
}
