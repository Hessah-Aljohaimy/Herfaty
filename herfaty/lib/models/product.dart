import 'package:herfaty/models/category.dart';

class Product {
  String? id;
  String? name;
  String? dsscription;
  String? categoryName;
  String? image;
  String? shopOwnerId;
  int? avalibleAmount;
  double? price;
  String? shopName;

  Product(
      {this.id,
      this.name,
      this.dsscription,
      required this.categoryName,
      this.image,
      this.avalibleAmount,
      this.price,
      this.shopOwnerId,
      this.shopName
      });
  Map<String, dynamic> toMap(String id) {
    return {
      'id': id,
      'name': name,
      'dsscription': dsscription,
      'categoryName': categoryName,
      'image': image,
      'avalibleAmount': avalibleAmount,
      'price': price,
      'shopName':shopName,
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = image;
    data['id'] = this.id;
    data['name'] = name;
    data['dsscription'] = dsscription;
    data['price'] = price;
    data['avalibleAmount'] = avalibleAmount;
    data['categoryName'] = categoryName;
    data['shopOwnerId'] = shopOwnerId;
    data['shopName']=shopName;
    return data;
  }
}
