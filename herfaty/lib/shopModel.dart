class ShopModel {
  String? uid;
  String? description;
  String? logo;
  String? shop_name;
  String? shop_owner_email;

  ShopModel(
      {this.uid,
      this.description,
      this.logo,
      this.shop_name,
      this.shop_owner_email});
  factory ShopModel.fromMap(map) {
    return ShopModel(
      uid: map['uid'],
      description: map['description'],
      logo: map['logo'],
      shop_name: map['shop_name'],
      shop_owner_email: map['shop_owner_email'],
    );
  }

  Map<String, dynamic> toMAp() {
    return {
      'uid': uid,
      'description': description,
      'logo': logo,
      'shop_name': shop_name,
      'shop_owner_email': shop_owner_email,
    };
  }
}
