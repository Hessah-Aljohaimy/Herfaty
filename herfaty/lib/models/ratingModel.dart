class ratingModel {
  double starsNumber = 0;
  String orderId = "", shopOwnerId = "", comment = "", date = "", dateTime = "";

  ratingModel({
    required this.starsNumber,
    required this.shopOwnerId,
    required this.orderId,
    required this.comment,
    required this.date,
    required this.dateTime,
  });

  ratingModel.fromJson(Map<String, dynamic> json) {
    starsNumber = json['starsNumber'];
    shopOwnerId = json['shopOwnerId'];
    orderId = json['orderId'];
    comment = json['comment'];
    date = json['date'];
    dateTime = json['dateTime'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['starsNumber'] = this.starsNumber;
    data['shopOwnerId'] = this.shopOwnerId;
    data['orderId'] = this.orderId;
    data['comment'] = this.comment;
    data['date'] = this.date;
    data['dateTime'] = this.dateTime;
    return data;
  }
}
