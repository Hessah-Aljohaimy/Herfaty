// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herfaty/AddProduct.dart';
import 'package:herfaty/OwnerProducts/OwnerProductsList.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/OwnerProducts/OwnerProductsList.dart';
import 'package:herfaty/constants/size.dart';
import 'package:herfaty/models/Category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ownerProductsCategScreen extends StatefulWidget {
  const ownerProductsCategScreen({Key? key}) : super(key: key);

  @override
  _ownerProductsCategScreenState createState() =>
      _ownerProductsCategScreenState();
}

class _ownerProductsCategScreenState extends State<ownerProductsCategScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/cartBack1.png'),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: const [
              appBar(),
              Body(),
              categories(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProduct()),
            );
          },
          label: const Text('أضف منتج جديد'),
          icon: const Icon(Icons.add),
          backgroundColor: Color(0xff51908E),
          extendedPadding: EdgeInsetsDirectional.only(start: 100.0, end: 100.0),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        //bottomNavigationBar: ,
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

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
              Text("تصنيفات المنتجات",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontFamily: "Tajawal")),
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

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

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
                category.photo,
                height: kCategoryCardImageSize,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(category.name,
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

class appBar extends StatelessWidget {
  const appBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      height: 100,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Color.fromARGB(232, 238, 232, 182),
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
          SizedBox(
            height: 22,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0, right: 10),
                child: Text(
                  "  قم بإختيار التصنيف لعرض منتجاتك  ",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: "Tajawal"),
                  textDirection: TextDirection.rtl,
                ),
              ),
              /* profileButton(
                icon: Icons.account_circle_sharp,
                onPressed: () {},
              ),*/
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
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
                                    builder: (context) => OwnerProductsList(
                                        categoryName: "فنون الورق والتلوين")),
                              );
                            }
                            if (cItems[index].name == "الخرز والإكسسوار") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OwnerProductsList(
                                        categoryName: "الخرز والإكسسوار")),
                              );
                            }
                            if (cItems[index].name == "الفخاريات") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OwnerProductsList(
                                        categoryName: "الفخاريات")),
                              );
                            }
                            if (cItems[index].name == "الحياكة والتطريز") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OwnerProductsList(
                                        categoryName: "الحياكة والتطريز")),
                              );
                            }
                          });
                    },
                    itemCount: cItems.length,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
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
