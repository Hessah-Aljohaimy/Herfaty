class Category {
  String photo;
  String name;
  //int noOfProducts;

  Category({
    required this.name,
    //required this.noOfProducts,
    required this.photo,
  });

  Map<String, dynamic> toJson() => {
        'photo': photo,
        'name': name,
      };

  static Category fromJson(Map<String, dynamic> json) => Category(
        name: json['name'],
        photo: json['photo'],
      );
}
