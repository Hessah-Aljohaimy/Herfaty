class shopOwnerModel {
  String DOB = "";
  String email = "";
  String id = "";
  String logo = "";
  String name = "";
  String password = "";
  String phone_number = "";
  String shopdescription = "";
  String shopname = "";
  shopOwnerModel(
      {required this.DOB,
      required this.email,
      required this.id,
      required this.logo,
      required this.name,
      required this.password,
      required this.phone_number,
      required this.shopdescription,
      required this.shopname});

  Map<String, dynamic> toJson() => {
        'DOB': DOB,
        'email': email,
        'id': id,
        'logo': logo,
        'name': name,
        'password': password,
        'phone_number': phone_number,
        'shopdescription': shopdescription,
        'shopname': shopname,
      };

  static shopOwnerModel fromJson(Map<String, dynamic> json) => shopOwnerModel(
        DOB: json['DOB'],
        email: json['email'],
        id: json['id'],
        logo: json['logo'],
        name: json['name'],
        password: json['password'],
        phone_number: json['phone_number'],
        shopdescription: json['shopdescription'],
        shopname: json['shopname'],
      );
}
