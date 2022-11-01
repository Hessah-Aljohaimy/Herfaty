// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/models/cart_wishlistModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/models/shopOwnerModel.dart';

class shopCard extends StatefulWidget {
  const shopCard({
    Key? key,
    required this.itemIndex,
    required this.shop,
    required this.shopRanking,
    required this.press,
  }) : super(key: key);

  final int itemIndex;
  final shopOwnerModel shop;
  final int? shopRanking;
  final void Function() press;

  @override
  State<shopCard> createState() => _shopCardState();
}

class _shopCardState extends State<shopCard> {
  late FToast fToast;

  bool isFavourite = false;
  bool isAvailable = true;

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String thisCustomerId = user!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String thisCustomerId = user!.uid;

    Size size =
        MediaQuery.of(context).size; //to get the width and height of the app
    return Container(
      decoration: BoxDecoration(
        //color: const Color(0xFFFAF9F6),
        color: Colors.white,
        border: Border.all(color: kPrimaryLight),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            blurRadius: 5.0,
            spreadRadius: .05,
          ), //BoxShadow
        ],
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      height: 100,
      child: InkWell(
        onTap: widget
            .press, // يعني ان المستخدم لما يضغط على الكارد تفتح معاه صفحة جديدة
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              //(small box inside the Big box)
              padding: const EdgeInsets.only(top: 10),
              height: 180,
              decoration: BoxDecoration(
                //color: const Color(0xFFFAF9F6),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            //*************************This part contains photo:
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.1, color: Colors.white),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  //color: Color(0xFFFAF9F6),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: Image.network(
                    widget.shop.logo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            //**********************This part contains points, Rank and shop name
            Positioned(
              top: 1,
              right: 20,
              child: SizedBox(
                height: 100,
                //because our image is 200, so the siz of this box = width -200
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          padding: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            gradient: LinearGradient(
                              colors: [
                                (Color.fromARGB(255, 81, 144, 142)),
                                (Color.fromARGB(255, 85, 150, 165)),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "${widget.shopRanking.toString()}",
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Tajawal",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            widget.shop.shopname,
                            style: const TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Tajawal",
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (widget.shop.points > 10)
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "${widget.shop.points.toString()} نقطة",
                          style: const TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Tajawal",
                              //color: Color(0xffFECE00),
                              color: kPrimaryColor),
                        ),
                      ),
                    if (widget.shop.points == 10)
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "${widget.shop.points.toString()} نقاط",
                          style: const TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Tajawal",
                              //color: Color(0xffFECE00),
                              color: kPrimaryColor),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//=============================================================================================
///////////////////////////////////////////////////////////////////////////////
  Future<void> showToastMethod(
      BuildContext context, String textToBeShown) async {
    Fluttertoast.showToast(
      msg: textToBeShown,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Color.fromARGB(255, 26, 96, 91),
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }
}
