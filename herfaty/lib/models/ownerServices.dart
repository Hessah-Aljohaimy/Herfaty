class ownerServices {
  String thumbnail;
  String name;

  ownerServices({
    required this.name,
    required this.thumbnail,
  });
}

List<ownerServices> servicesList = [
  ownerServices(
    name: 'منتجاتي ',
    thumbnail: 'assets/icons/products.png',
  ),
];
