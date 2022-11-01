// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/models/ratingModel.dart';
import 'package:herfaty/rating/ratingCard2.dart';

class ratingsList extends StatefulWidget {
  ratingsList({
    Key? key,
    required this.thisShopOwnerId,
    required this.averageShopRating,
    required this.numberOfRatings,
  }) : super(key: key);

  final String thisShopOwnerId;
  final double averageShopRating;
  final int numberOfRatings;
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
      backgroundColor: Colors.white,
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
              const SizedBox(height: 5),
              Container(
                //---------------------------------------------------------------------------
                //مستطيل في أعلى الليست يعرض نسبة تقييم المتجر وعدد تقييمات
                padding: const EdgeInsets.all(0),
                margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(.2),
                      blurRadius: 5.0,
                      spreadRadius: .05,
                    ), //BoxShadow
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Star icon
                    Container(
                        //padding: const EdgeInsets.only(bottom: 0, right: 10),
                        height: 55,
                        width: 55,
                        child: Image.asset('assets/images/star-100.png')),
                    // Icon(
                    //   Icons.star,
                    //   color: Colors.amber,
                    //   size: 55.0,
                    // ),
                    // عدد نجوم هذا التقييم رقمًا
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 18.0, left: 10, right: 5),
                      child: Text(
                        "${widget.averageShopRating}",
                        style: const TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Tajawal",
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    //عدد التققيمات
                    Padding(
                      padding: const EdgeInsets.only(top: 22.0),
                      child: Text(
                        "بناءً على (${widget.numberOfRatings}) من التقييمات",
                        style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Tajawal",
                          decoration: TextDecoration.underline,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                    //  عدد نجوم هذا التقييم على شكل نجوم ممتلئة نسبيًا
                    // StarRating(
                    //   //rating: widget.averageShopRating,
                    //   rating: 2,
                    //   onChangeRating: (int rating) {},
                    // )
                  ],
                ),
              ),
              //-------------------------------------------------------------------------------------------
              Expanded(
                child: Stack(
                  children: [
                    //This is to list all of our items fetched from the DB========================
                    StreamBuilder<List<ratingModel>>(
                      stream: readRatings(widget.thisShopOwnerId),
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
                          //sort the products according to date
                          ratings.sort((a, b) {
                            return DateTime.parse(b.dateTime)
                                .compareTo(DateTime.parse(a.dateTime));
                          });
                          // ratings.sort((a, b) {
                          //   return DateTime.parse(b.time)
                          //       .compareTo(DateTime.parse(a.time));
                          // });

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
                            // return ListView.builder(
                            //   itemCount: ratings.length,
                            //   itemBuilder: (context, index) => ratingCard(
                            //       itemIndex: index,
                            //       ratingItem: ratings[index],
                            //       averageShopRating: widget.averageShopRating),
                            // );
                            return ListView.separated(
                              separatorBuilder: (_, __) => const Divider(
                                height: 0,
                                thickness: 1,
                                indent: 20,
                                endIndent: 20,
                                color: kPrimaryColor,
                              ),
                              itemCount: ratings.length,
                              itemBuilder: (context, index) => ratingCard2(
                                  itemIndex: index,
                                  ratingItem: ratings[index],
                                  averageShopRating: widget.averageShopRating),
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
  Stream<List<ratingModel>> readRatings(String thisShopOwnerId) {
    return FirebaseFirestore.instance
        .collection('rating')
        .where('shopOwnerId', isEqualTo: thisShopOwnerId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ratingModel.fromJson(doc.data()))
            .toList());
  }

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
      leading: IconButton(
        padding: EdgeInsets.only(right: 20),
        icon: const Icon(
          Icons.arrow_back,
          color: Color.fromARGB(255, 26, 96, 91),
          size: 22.0,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
