class ratingModel {
  num starsNumber = 0;
  String orderId = "", shopOwnerId = "", comment = "", date = "", time = "";

  ratingModel({
    required this.starsNumber,
    required this.shopOwnerId,
    required this.orderId,
    required this.comment,
    required this.date,
    required this.time,
  });

  ratingModel.fromJson(Map<String, dynamic> json) {
    starsNumber = json['starsNumber'];
    shopOwnerId = json['shopOwnerId'];
    orderId = json['orderId'];
    comment = json['comment'];
    date = json['date'];
    time = json['time'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['starsNumber'] = this.starsNumber;
    data['shopOwnerId'] = this.shopOwnerId;
    data['orderId'] = this.orderId;
    data['comment'] = this.comment;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}
