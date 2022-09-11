class CartModal {
  String image = "";
  String title = "";
  double price = 0.0;
  int quantity = 0;

  CartModal(
      {required this.image,
      required this.title,
      required this.price,
      required this.quantity});

  CartModal.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}
