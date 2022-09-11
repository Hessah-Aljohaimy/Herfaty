class Category {
  String thumbnail;
  String name;
  int noOfProducts;

  Category({
    required this.name,
    required this.noOfProducts,
    required this.thumbnail,
  });
}

List<Category> categoryList = [
  Category(
    name: 'الخرز والإكسسوار',
    noOfProducts: 55,
    thumbnail: 'assets/icons/beads.png',
  ),
  Category(
    name: 'الرسم والتلوين',
    noOfProducts: 20,
    thumbnail: 'assets/icons/painting3.png',
  ),
  Category(
    name: 'الحياكة والتطريز',
    noOfProducts: 16,
    thumbnail: 'assets/icons/crochet2.png',
  ),
  Category(
    name: 'الفخاريات',
    noOfProducts: 25,
    thumbnail: 'assets/icons/pottery1.png',
  ),
];
