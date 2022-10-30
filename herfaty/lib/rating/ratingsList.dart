// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herfaty/CustomerProducts/CustomerProductDetails.dart';
import 'package:herfaty/CustomerProducts/productCard.dart';
import 'package:herfaty/models/Product1.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/models/ratingModel.dart';
import 'package:herfaty/rating/ratingCard.dart';

class ratingsList extends StatefulWidget {
  ratingsList({
    Key? key,
    required this.thisShopOwnerId,
  }) : super(key: key);

  final String thisShopOwnerId;
  @override
  State<ratingsList> createState() => _ratingsListState();
}

class _ratingsListState extends State<ratingsList> {
  String thisShopName = "";
  @override
  void initState() {
    setShopName(widget.thisShopOwnerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String thisCustomerId = user!.uid;
    //====================================================================
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      appBar: ratingsListAppBar(context),
      body: SafeArea(
        child: Container(
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //   image: AssetImage('assets/images/cartBack1.png'),
          //   fit: BoxFit.cover,
          // )),
          child: Column(
            children: [
              const SizedBox(height: 15),
              //هنا المفروض يكن في مربع يعرض نسبة تقييم المتجر وعدد تقييماته
              // ولو في وقت نحط نجون تعرض متوسط النجوم
              Expanded(
                child: Stack(
                  children: [
                    //This is to list all of our items fetched from the DB========================
                    StreamBuilder<List<ratingModel>>(
                      stream: readPrpducts(thisCustomerId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Text(
                              'Something went wrong! ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final ratings = snapshot.data!.toList();
                          final data = snapshot.data!;
                          if (data.isEmpty) {
                            return const Center(
                              child: Text(
                                'لا توجد تقييمات  ',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Tajawal",
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          }
                          //هنا حالة النجاح في استرجاع البيانات...........................................
                          else {
                            return ListView.builder(
                              itemCount: ratings.length,
                              itemBuilder: (context, index) => ratingCard(
                                itemIndex: index,
                                ratingItem: ratings[index],
                              ),
                            );
                          }
                          //..................................................................................
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                    //==================================================================================
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//========================================================================================
  Stream<List<ratingModel>> readPrpducts(String thisShopOwnerId) =>
      FirebaseFirestore.instance
          .collection('rating')
          .where("shopOwnerId", isEqualTo: thisShopOwnerId)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ratingModel.fromJson(doc.data()))
              .toList());

//===================================================================================
  Future<String> getShopName(String thisOwneerId) async {
    String shopName = "";
    final customersDoc = await FirebaseFirestore.instance
        .collection('shop_owner')
        .where("id", isEqualTo: thisOwneerId)
        .get();
    if (customersDoc.size > 0) {
      var data = customersDoc.docs.elementAt(0).data() as Map;
      shopName = data["shopname"];
      print("shop name is ${shopName}");
    }
    return shopName;
  }

//======================================================================================
  Future<void> setShopName(String thisOwnerId) async {
    String existedName = await getShopName(thisOwnerId);
    setState(() {
      thisShopName = existedName;
    });
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////
  //AppBar
  AppBar ratingsListAppBar(var context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        "تقييمات ${thisShopName}",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: kPrimaryColor,
          fontFamily: "Tajawal",
        ),
      ),
    );
  }
}
