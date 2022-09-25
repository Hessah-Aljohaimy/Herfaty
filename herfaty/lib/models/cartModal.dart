class CartModal {
  String customerId = "";
  String docId;
  String image = "";
  String name = "";
  num price = 0.0;
  int quantity = 0;
  int avalibleAmount;
  String shopName = "";

  CartModal(
      {required this.customerId,
      required this.docId,
      required this.image,
      required this.name,
      required this.price,
      required this.quantity,
      required this.avalibleAmount,
      required this.shopName});

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
        'docId': docId,
        'customerId': customerId,
        'image': image,
        'name': name,
        'price': price,
        'quantity': quantity,
        'avalibleAmount': avalibleAmount,
        'shopName': shopName,
      };

  static CartModal fromJson(Map<String, dynamic> json) => CartModal(
        customerId: json['customerId'],
        docId: json['docId'],
        image: json['image'],
        name: json['name'],
        price: json['price'],
        quantity: json['quantity'],
        avalibleAmount: json['avalibleAmount'],
        shopName: json['shopName'],
      );
}
