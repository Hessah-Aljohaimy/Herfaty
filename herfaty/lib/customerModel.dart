class CustomerModel {
  String? uid;
  String? customer_name;
  String? email;
  String? password;

  CustomerModel({this.uid, this.customer_name, this.email, this.password});

  //fromserver
  factory CustomerModel.fromMap(map) {
    return CustomerModel(
      uid: map['uid'],
      customer_name: map['customer_name'],
      email: map['email'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMAp() {
    return {
      'uid': uid,
      'customer_name': customer_name,
      'email': email,
      'password': password,
    };
  }
}
