import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/constants/icons.dart';
import 'package:herfaty/constants/size.dart';
import 'package:herfaty/models/Category.dart';
import 'package:herfaty/widgets/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ownerHome.dart';
import 'owner_base_screen.dart';

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
        body: Column(
          children: const [
            AppBar(),
            Body(),
            categories(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
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
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "تصنيفات المنتجات",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
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
            Text(category.name),
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

class AppBar extends StatelessWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: prefer_const_constructors
              Text(
                "مرحباً\n ",
                // ignore: prefer_const_constructors
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                textDirection: TextDirection.rtl,
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
                      return CategoryCard(
                        category: cItems[index],
                      );
                    },
                    itemCount: cItems.length,
                  );
                } else {
                  return Center(child: Text("يتم التحميل"));
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
