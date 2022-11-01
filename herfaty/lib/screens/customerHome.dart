// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:herfaty/cart/cart.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/constants/size.dart';
import 'package:herfaty/models/Category.dart';
import 'package:herfaty/topShops/topShops.dart';
import 'package:herfaty/points%20base/peofile_circle.dart';
import 'package:herfaty/widgets/profile_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../CustomerProducts/CustomerProductsList.dart';
import '../CustomerProducts/wishList/CustomerWishList.dart';

class customerHomeScreen extends StatefulWidget {
  const customerHomeScreen({Key? key}) : super(key: key);

  @override
  _customerHomeScreenState createState() => _customerHomeScreenState();
}

class _customerHomeScreenState extends State<customerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/cartBack1.png'),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: [
              AppBar(),
              Body(),
              categories(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "تصنيفات المنتجات",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: "Tajawal"),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class CategoryCard extends StatefulWidget {
  final Category category;
  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 4.0,
              spreadRadius: .05,
            ), //BoxShadow
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                widget.category.photo,
                height: kCategoryCardImageSize,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.category.name,
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Tajawal",
                    fontSize: 16)),
            /*Text(
              "${category.noOfProducts.toString()} منتج",
              style: Theme.of(context).textTheme.bodySmall,
            ),*/
          ],
        ),
      ),
    );
  }
}

class AppBar extends StatefulWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  String thisCustomerName = "";
  @override
  void initState() {
    print("this is app bar initState====");
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String thisCustomerId = user!.uid;
    setCustomerName(thisCustomerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 150,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          colors: [
            (Color.fromARGB(255, 81, 144, 142)),
            (Color.fromARGB(255, 85, 150, 165)),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          /* Align(
            alignment: Alignment.topLeft,
            child: profileButton(
              icon: Icons.favorite,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomerWishList()));
              },
            ),
          ),*/
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "مرحبًا بك ${thisCustomerName} ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: "Tajawal"),
              ),
              ProfileCircleCustomer()
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: InkWell(
              child: Container(
                height: 45,
                width: double.infinity,
                margin: EdgeInsets.only(right: 160),
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /* Image.asset(
                      "assets/icons/starno.gif",
                      height: 25,
                    ),*/
                    Text(
                      "تعرف على المتاجر الأكثر نقاطاً",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        //fontFamily: "Tajawal"
                      ),
                    ),
                    Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 15,
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => topShops()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  //======================================================================================
  Future<void> setCustomerName(String thisCustomerId) async {
    String existedName = await getName(thisCustomerId);
    if (existedName != "") {
      setState(() {
        thisCustomerName = existedName;
      });
    } else {
      setState(() {
        thisCustomerName = "أيها المشتري";
      });
    }
  }

  //===================================================================================
  Future<String> getName(String thisCustomerId) async {
    String CustomerName = "";
    final customersDoc = await FirebaseFirestore.instance
        .collection('customers')
        .where("id", isEqualTo: thisCustomerId)
        .get();
    if (customersDoc.size > 0) {
      var data = customersDoc.docs.elementAt(0).data() as Map;
      CustomerName = data["name"];
      print("existed name is ${CustomerName}");
    }
    return CustomerName;
  }
}

class categories extends StatelessWidget {
  const categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<List<Category>>(
              stream: readCaterories(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('somting wrong \n ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final cItems = snapshot.data!.toList();

                  return GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 24,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          child: CategoryCard(
                            category: cItems[index],
                          ),
                          onTap: () {
                            if (cItems[index].name == "فنون الورق والتلوين") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomerProductsList(
                                        categoryName: "فنون الورق والتلوين")),
                              );
                            }
                            if (cItems[index].name == "الخرز والإكسسوار") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomerProductsList(
                                        categoryName: "الخرز والإكسسوار")),
                              );
                            }
                            if (cItems[index].name == "الفخاريات") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomerProductsList(
                                        categoryName: "الفخاريات")),
                              );
                            }
                            if (cItems[index].name == "الحياكة والتطريز") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomerProductsList(
                                        categoryName: "الحياكة والتطريز")),
                              );
                            }
                          });
                      /*return CategoryCard(
                        category: cItems[index],
                      );*/
                    },
                    itemCount: cItems.length,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}

// Stream to reach collection

Stream<List<Category>> readCaterories() => FirebaseFirestore.instance
    .collection('categories')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Category.fromJson(doc.data())).toList());
