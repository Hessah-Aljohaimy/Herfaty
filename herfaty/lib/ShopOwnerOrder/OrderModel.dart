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
  Map<String, num> products;

<<<<<<< HEAD
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
=======
class orderModel {
  String shopOwnerID = "";
  String customerID = "";
  String image = "";
  String orderDate = "";
  String qantity = "";
  String totalPrice = "";
  String orderDay = "";
>>>>>>> 1ad8d0a6efc74cc48261a0fb36fffe68963b8171

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
