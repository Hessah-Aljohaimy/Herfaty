class AddProductToCart {
  String? name;
  String? detailsImage;
  String? productId;
  String? customerId;
  String? shopOwnerId;
  String? shopName;
  String? docId;
  int? quantity;
  int? availableAmount;
  num? price;

  AddProductToCart({
    required this.name,
    required this.detailsImage,
    required this.productId,
    required this.customerId,
    required this.shopOwnerId,
    required this.shopName,
    required this.docId,
    required this.quantity,
    required this.availableAmount,
    required this.price,
  });
  AddProductToCart.fromJson(Map<String, dynamic> json) {
    detailsImage = json['image'];
    customerId = json['customerId'];
    shopOwnerId = json['shopOwnerId'];
    shopName = json['shopName'];
    productId = json['productId'];
    docId = json['docId'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    availableAmount = json['avalibleAmount'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = detailsImage;
    data['customerId'] = customerId;
    data['productId'] = productId;
    data['docId'] = docId;
    data['name'] = name;
    data['price'] = price;
    data['quantity'] = quantity;
    data['avalibleAmount'] = availableAmount;
    data['shopOwnerId'] = shopOwnerId;
    data['shopName'] = shopName;

    return data;
  }
}
