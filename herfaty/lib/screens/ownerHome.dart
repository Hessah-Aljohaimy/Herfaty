import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/constants/size.dart';
import 'package:herfaty/models/ownerServices.dart';
import 'package:herfaty/screens/owner_base_screen.dart';
import 'package:herfaty/widgets/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ownerProductsCateg.dart';

class ownerHomeScreen extends StatefulWidget {
  const ownerHomeScreen({Key? key}) : super(key: key);

  @override
  _ownerHomeScreenState createState() => _ownerHomeScreenState();
}

class _ownerHomeScreenState extends State<ownerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: const [
            AppBar(),
            Body(),
            Services(),
          ],
        ),
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
              Text("الصفحة الرئيسية ",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ],
          ),
        ),
      ],
    );
  }
}

class ownerServicesCard extends StatelessWidget {
  final ownerServices ownerService;
  const ownerServicesCard({
    Key? key,
    required this.ownerService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        // Within the SecondRoute widget
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
                ownerService.photo,
                height: kCategoryCardImageSize,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(ownerService.name,
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold)),
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
                "مرحباً بكَ أيها الحِرَفِيّ",
                // ignore: prefer_const_constructors
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
                //textDirection: TextDirection.rtl,
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

class Services extends StatelessWidget {
  const Services({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<List<ownerServices>>(
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
                          child: ownerServicesCard(
                            ownerService: cItems[index],
                          ),
                          onTap: () {
                            if (cItems[index].name == "منتجاتي") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ownerProductsCategScreen()),
                              );
                            }
                          });
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

Stream<List<ownerServices>> readCaterories() => FirebaseFirestore.instance
    .collection('ownerServices')
    .snapshots()
    .map((snapshot) => snapshot.docs
        .map((doc) => ownerServices.fromJson(doc.data()))
        .toList());
