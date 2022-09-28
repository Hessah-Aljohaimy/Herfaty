class orderModal {
  String customerId = "";
  String shopOwnerId = "";
  String docId;
  String location = "";
  num total = 0.0;
  String shopName = "";
  String productId = "";
  String notification = "notPushed";
  String status = "New order";
  String cartDocId;

  orderModal(
      {required this.customerId,
      required this.shopOwnerId,
      required this.docId,
      required this.location,
      required this.total,
      required this.shopName,
      required this.productId,
      required this.notification,
      required this.status,
      required this.cartDocId});

  Map<String, dynamic> toJson() => {
        'docId': docId,
        'customerId': customerId,
        'shopOwnerId': shopOwnerId,
        'location': location,
        'total': total,
        'shopName': shopName,
        'productId': productId,
        'notification': notification,
        'status': status,
        'cartDocId': cartDocId
      };

  static orderModal fromJson(Map<String, dynamic> json) => orderModal(
      customerId: json['customerId'],
      docId: json['docId'],
      shopOwnerId: json['shopOwnerId'],
      location: json['location'],
      total: json['total'],
      shopName: json['shopName'],
      notification: json['notification'],
      productId: json['productId'],
      status: json['status'],
      cartDocId: json['cartDocId']);
}
