class ownerLocModel {
  String shopName = "";
  String location = "";
 
  ownerLocModel(
      {required this.shopName,
      required this.location,
    });

  Map<String, dynamic> toJson() => {
        'shopName': shopName,
        'location': location,
     
      };

  static ownerLocModel fromJson(Map<String, dynamic> json) => ownerLocModel(
        shopName: json['shopName'],
        location: json['location'],
      
      );


  //      Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['location'] = location;
   
  //   data['shopName'] = shopName;
  
  //   return data;
  // }
}