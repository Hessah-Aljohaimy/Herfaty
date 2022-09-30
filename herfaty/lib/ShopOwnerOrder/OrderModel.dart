class OrderModel {
  String customerId = "";
  String shopOwnerId = "";
  String docId;
  String location = "";
  num total = 0.0;
  String shopName = "";
  String notification = "notPushed";
  String status = "New order";
  String orderDate = "";
  Map<String, dynamic> products;

  OrderModel(
      {required this.customerId,
      required this.shopOwnerId,
      required this.docId,
      required this.location,
      required this.total,
      required this.shopName,
      required this.notification,
      required this.status,
      required this.orderDate,
      required this.products});

  Map<String, dynamic> toJson() => {
        'docId': docId,
        'customerId': customerId,
        'shopOwnerId': shopOwnerId,
        'location': location,
        'total': total,
        'shopName': shopName,
        'notification': notification,
        'status': status,
        'orderDate': orderDate,
        'products': products,
      };

  static OrderModel fromJson(Map<String, dynamic> json) => OrderModel(
      customerId: json['customerId'],
      docId: json['docId'],
      shopOwnerId: json['shopOwnerId'],
      location: json['location'],
      total: json['total'],
      shopName: json['shopName'],
      notification: json['notification'],
      status: json['status'],
      orderDate: json['orderDate'],
      products: json['products']);
}
