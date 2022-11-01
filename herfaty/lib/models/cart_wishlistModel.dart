class cart_wishlistModel {
  String name = "";
  String detailsImage = "";
  String productId = "";
  String customerId = "";
  String shopOwnerId = "";
  String shopName = "";
  String docId = "";
  String description = "";
  String proudctDate = "";
  int quantity = 1;
  int availableAmount = 0;
  num price = 0;

  cart_wishlistModel({
    required this.name,
    required this.detailsImage,
    required this.productId,
    required this.customerId,
    required this.shopOwnerId,
    required this.shopName,
    required this.docId,
    required this.description,
    required this.quantity,
    required this.availableAmount,
    required this.price,
    required this.proudctDate,
  });
  cart_wishlistModel.fromJson(Map<String, dynamic> json) {
    detailsImage = json['image'];
    customerId = json['customerId'];
    shopOwnerId = json['shopOwnerId'];
    shopName = json['shopName'];
    productId = json['productId'];
    docId = json['docId'];
    description = json['description'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    availableAmount = json['avalibleAmount'];
    proudctDate = json['proudctDate'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = detailsImage;
    data['customerId'] = customerId;
    data['productId'] = productId;
    data['docId'] = docId;
    data['description'] = description;
    data['name'] = name;
    data['price'] = price;
    data['quantity'] = quantity;
    data['avalibleAmount'] = availableAmount;
    data['shopOwnerId'] = shopOwnerId;
    data['shopName'] = shopName;
    data['proudctDate'] = this.proudctDate;
    return data;
  }
}
