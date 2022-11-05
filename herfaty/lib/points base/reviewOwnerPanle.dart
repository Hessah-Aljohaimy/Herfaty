// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:herfaty/rating/ratingsList.dart';

class reviewOwnerPanle extends StatefulWidget {
  const reviewOwnerPanle({super.key});

  @override
  State<reviewOwnerPanle> createState() => _reviewOwnerPanleState();
}

class _reviewOwnerPanleState extends State<reviewOwnerPanle> {
  double averageShopRating = 0;
  int numberOfRatings = 0;

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String thisShopOwnerId = user!.uid;
    //--------------------------------------------------------
    setShopAverageRating(thisShopOwnerId);
    setNumOfRatings(thisShopOwnerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String thisShopOwnerId = user!.uid;
    //--------------------------------------------------------
    return SizedBox(
        height: 60,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // SizedBox(
            //   width:4,
            // ),
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.only(left: 5),
              width: 210,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color.fromARGB(79, 68, 172, 232)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(19, 128, 208, 255).withOpacity(.4),
                    blurRadius: 6.0,
                    spreadRadius: .05,
                  ), //BoxShadow
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Image.asset(
                      "assets/images/star-100.png",
                      width: 32,
                    ),
                  ),
                  Container(
                    // width: 80,
                    // height: 30,
                    child: Builder(builder: (context) {
                      return TextButton(
                        child: Text(
                          "تقييمات متجري",
                          style: TextStyle(
                              color: Color(0xff44ADE8),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Tajawal"),
                        ),
                        onPressed: () {
                          setShopAverageRating(thisShopOwnerId);
                          setNumOfRatings(thisShopOwnerId);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ratingsList(
                                thisShopOwnerId: thisShopOwnerId,
                                averageShopRating: averageShopRating,
                                numberOfRatings: numberOfRatings,
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                  IconButton(
                    padding: EdgeInsets.only(bottom: 5),
                    constraints: BoxConstraints(),
                    onPressed: () {
                      setShopAverageRating(thisShopOwnerId);
                      setNumOfRatings(thisShopOwnerId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ratingsList(
                            thisShopOwnerId: thisShopOwnerId,
                            averageShopRating: averageShopRating,
                            numberOfRatings: numberOfRatings,
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_forward_rounded,
                      size: 22,
                      color: Color(0xff44ADE8),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ));
  }

//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  Future<void> setShopAverageRating(String thisOwnerId) async {
    double existedShopRating = await getShopAverageRating(thisOwnerId);
    setState(() {
      averageShopRating = existedShopRating;
    });
  }

  //=======================================================================================
  Future<double> getShopAverageRating(String shopOwnerId) async {
    double averageShopRating = 0;
    num sumRating = 0;
    final shopDoc = await FirebaseFirestore.instance
        .collection('rating')
        .where("shopOwnerId", isEqualTo: shopOwnerId)
        .get();
    if (shopDoc.size > 0) {
      for (int i = 0; i < shopDoc.size; i++) {
        var data = shopDoc.docs.elementAt(i).data() as Map;
        double thisDocRating = data["starsNumber"];
        sumRating += thisDocRating;
      }

      averageShopRating = sumRating / shopDoc.size;
      String inString = averageShopRating.toStringAsFixed(2);
      averageShopRating = double.parse(inString);
    }
    return averageShopRating;
  }

//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  Future<void> setNumOfRatings(String thisOwnerId) async {
    int existedRatingsNum = await getNumOfRatings(thisOwnerId);
    setState(() {
      numberOfRatings = existedRatingsNum;
    });
  }

  //=======================================================================================
  Future<int> getNumOfRatings(String shopOwnerId) async {
    int existedRatingsNum = 0;
    final shopDoc = await FirebaseFirestore.instance
        .collection('rating')
        .where("shopOwnerId", isEqualTo: shopOwnerId)
        .get();
    if (shopDoc.size > 0) {
      existedRatingsNum = shopDoc.size;
      print("shop ratings doc size is ${shopDoc.size}");
    }
    return existedRatingsNum;
  }

//=============================================================================================
///////////////////////////////////////////////////////////////////////////////
}
