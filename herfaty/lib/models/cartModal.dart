class CartModal {
  String image = "";
  String name = "";
  num price = 0.0;
  int quantity = 0;

  CartModal(
      {required this.image,
      required this.name,
      required this.price,
      required this.quantity});

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
        'image': image,
        'name': name,
        'price': price,
        'quantity': quantity,
      };

  static CartModal fromJson(Map<String, dynamic> json) => CartModal(
        image: json['image'],
        name: json['name'],
        price: json['price'],
        quantity: json['quantity'],
      );
}
