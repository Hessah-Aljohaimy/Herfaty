class pointsModel {
  String shopOwnerId = "";
  String docId;
  String PointsDate = "";
  num pointsSum = 0;
  num productsNumber = 0;

  pointsModel(
      {required this.shopOwnerId,
      required this.docId,
      required this.PointsDate,
      required this.pointsSum,
      required this.productsNumber});

  Map<String, dynamic> toJson() => {
        'shopOwnerId': shopOwnerId,
        'docId': docId,
        'PointsDate': PointsDate,
        'pointsSum': pointsSum,
        'productsNumber': productsNumber
      };

  static pointsModel fromJson(Map<String, dynamic> json) => pointsModel(
      shopOwnerId: json['shopOwnerId'],
      docId: json['docId'],
      PointsDate: json['PointsDate'],
      pointsSum: json['pointsSum'],
      productsNumber: json['productsNumber']);
}
