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
      height: 180,
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
            //*************************This part contains product photo:
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 180,
                width: 180,
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

            //**********************This part contains product name, price and shop name
            Positioned(
              top: 10,
              right: 20,
              child: SizedBox(
                height: 136,
                //because our image is 200, so the siz of this box = width -200
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
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
                      child: Text(
                        "${widget.shopRanking.toString()}",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Tajawal",
                          color: kPrimaryLight,
                        ),
                      ),
                    ),
                    //product name===========================================================
                    Text(
                      widget.shop.name,
                      style: const TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Tajawal",
                        color: Colors.black,
                      ),
                    ),

                    //اسم المتجر  ===========================================================
                    if (widget.shop.points > 2)
                      Text(
                        "${widget.shop.points.toString()} نقاط",
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Tajawal",
                          color: kPrimaryLight,
                        ),
                      ),
                    if (widget.shop.points == 2)
                      Text(
                        "نقطتين",
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Tajawal",
                          color: kPrimaryLight,
                        ),
                      ),
                    if (widget.shop.points == 1)
                      Text(
                        "نقطة",
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Tajawal",
                          color: kPrimaryLight,
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
