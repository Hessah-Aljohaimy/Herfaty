class shopOwnerModel {
  String DOB = "";
 String email="";
  String id = "";
  String logo = "";
  String name =  "";
  String password = "";
  int phone_number=0;
String shopdescription="";
String shopname="";
  shopOwnerModel(
      {required this.DOB,
        required this.email,
      required this.id,
        required this.logo,
      required this.name,
      required this.password,
      required this.phone_number,
      required this.shopdescription,
      required this.shopname

   });

  /*

  CartModal.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
*/

//like video
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
