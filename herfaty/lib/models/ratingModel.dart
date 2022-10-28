class ratingModel {
  num starsNumber = 0;
  String orderId = "", shopOwnerId = "", comment = "";

  ratingModel({
    required this.starsNumber,
    required this.shopOwnerId,
    required this.orderId,
    required this.comment,
  });

  ratingModel.fromJson(Map<String, dynamic> json) {
    starsNumber = json['starsNumber'];
    shopOwnerId = json['shopOwnerId'];
    orderId = json['orderId'];
    comment = json['comment'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['starsNumber'] = this.starsNumber;
    data['shopOwnerId'] = this.shopOwnerId;
    data['orderId'] = this.orderId;
    data['comment'] = this.comment;
    return data;
  }
}
