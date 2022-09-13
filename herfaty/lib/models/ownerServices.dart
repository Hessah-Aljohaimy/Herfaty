class ownerServices {
  String photo;
  String name;

  ownerServices({
    required this.name,
    required this.photo,
  });

  Map<String, dynamic> toJson() => {
        'photo': photo,
        'name': name,
      };

  static ownerServices fromJson(Map<String, dynamic> json) => ownerServices(
        name: json['name'],
        photo: json['photo'],
      );
}




/*
List<ownerServices> servicesList = [
  ownerServices(
    name: 'منتجاتي ',
    photo: 'assets/icons/products.png',
  ),
];
*/
