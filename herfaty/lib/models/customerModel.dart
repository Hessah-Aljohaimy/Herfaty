class customerModel {
  String email = "";
  String id = "";
  String name = "";
  String password = "";

  customerModel({
    required this.email,
    required this.id,
    required this.name,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'id': id,
        'name': name,
        'password': password,
      };

  static customerModel fromJson(Map<String, dynamic> json) => customerModel(
        email: json['email'],
        id: json['id'],
        name: json['name'],
        password: json['password'],
      );
}
