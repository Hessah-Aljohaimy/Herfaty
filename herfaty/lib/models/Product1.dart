class Product1 {
  int availableAmount = 0, quantity = 1;
  String productId = "";
  num price = 0;
  String categoryName = "",
      name = "",
      description = "",
      image = "",
      shopOwnerId = "",
      customerId = "",
      docId = "",
      shopName = "";

  Product1({
    required this.productId,
    required this.availableAmount,
    required this.price,
    required this.categoryName,
    required this.name,
    required this.description,
    required this.image,
    required this.shopOwnerId,
    required this.shopName,
  });

  Product1.fromJson(Map<String, dynamic> json) {
    productId = json['id'];
    availableAmount = json['avalibleAmount'];
    price = json['price'];
    categoryName = json['categoryName'];
    name = json['name'];
    description = json['dsscription'];
    image = json['image'];
    shopOwnerId = json['shopOwnerId'];
    shopName = json['shopName'];
  }
  //for retrieving data from wishList
  Product1.fromJson2(Map<String, dynamic> json) {
    image = json['image'];
    customerId = json['customerId'];
    shopOwnerId = json['shopOwnerId'];
    shopName = json['shopName'];
    productId = json['productId'];
    docId = json['docId'];
    description = json['description'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    availableAmount = json['avalibleAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.productId;
    data['avalibleAmount'] = this.availableAmount;
    data['price'] = this.price;
    data['categoryName'] = this.categoryName;
    data['name'] = this.name;
    data['desscription'] = this.description;
    data['image'] = this.image;
    data['shopOwnerId'] = this.shopOwnerId;
    data['shopName'] = this.shopName;

    return data;
  }
}

//temporarily list of used products 
/*
List<Product1> products = [
  Product1(
      id: 1,
      price: 15,
      name: " القلوب النقية",
      description:
          "لوحة االقلوب النقية هي لوحة جميلة ترمز إلى طهارة القلب وحب الخير للجميع، صنعت وزينت باستخدام فن الورق ",
      image: "assets/images/hands.jpg",
      quantity: 3),
  Product1(
      id: 2,
      price: 10,
      name: " كلنا إخوة ",
      description:
          "لوحة جميلة تحمل معنى المحبة والود بين كافة فئات المجتمع، لأن كلنا إخوة ",
      image: "assets/images/people.jpg",
      quantity: 3),
  Product1(
      id: 3,
      price: 15,
      name: "حمار وحشي ورقي ",
      description: "حمار وحشي مصنوع باستخدام فن الورق ",
      image: "assets/images/zebra.png",
      quantity: 3),
  Product1(
      id: 4,
      price: 10,
      name: "لوحة الطبيعة الورقية ",
      description:
          "لوحة جميلة تحتوي على بعض مظاهر الطبيعة، صنعت وزينت باستخدام فن الورق ",
      image: "assets/images/trees.jpg",
      quantity: 3),
  Product1(
      id: 5,
      price: 15,
      name: " أمواج البحر",
      description:
          "لوحة أمواج البحر الجميلة، رسمت ولونت بكل حب، يمكن وضعها في إطار وتعليقها والاستمتع بمظهرها    ",
      image: "assets/images/waves.jpg",
      quantity: 3),
]; */