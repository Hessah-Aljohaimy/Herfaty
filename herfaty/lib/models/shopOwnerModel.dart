class shopOwnerModel {
  String shopOwnerId = "";
 

  shopOwnerModel(
      {required this.shopOwnerId,
   });

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
     
        'id': shopOwnerId,
      
      };

  static shopOwnerModel fromJson(Map<String, dynamic> json) => shopOwnerModel(
        shopOwnerId: json['id'],
       
      );
}
