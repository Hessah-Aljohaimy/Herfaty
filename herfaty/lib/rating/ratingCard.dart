// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/models/ratingModel.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class ratingCard extends StatefulWidget {
  const ratingCard({
    Key? key,
    required this.itemIndex,
    required this.ratingItem,
    required this.averageShopRating,
  }) : super(key: key);

  final int itemIndex;
  final ratingModel ratingItem;
  final num averageShopRating;

  @override
  State<ratingCard> createState() => _ratingCardState();
}

class _ratingCardState extends State<ratingCard> {
  @override
  Widget build(BuildContext context) {
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
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          //*************************This part contains rating date
          Positioned(
            bottom: 0,
            left: 0,
            child: Text(
              widget.ratingItem.date,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                fontFamily: "Tajawal",
                color: Colors.black,
              ),
            ),
            // ممكن نضيف ايكون ساعة او وقت جنب التاريخ
          ),

          //**********************This part contains rating comment, number of stars
          Positioned(
            top: 20,
            right: 20,
            child: SizedBox(
              height: 136,
              //because our image is 200, so the siz of this box = width -200
              width: size.width - 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //التعليق===========================================================
                  Text(
                    widget.ratingItem.comment,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Tajawal",
                      color: Colors.black,
                    ),
                  ),

                  // عدد النجوم  ===========================================================
                  Row(
                    children: [
                      // عدد نجوم هذا التقييم رقمًا
                      Text(
                        "${widget.ratingItem.starsNumber}",
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Tajawal",
                          color: kPrimaryColor,
                        ),
                      ),
                      //  عدد نجوم هذا التقييم على شكل نجوم ممتلئة نسبيًا
                      RatingStars(
                        editable: false,
                        rating: widget.ratingItem.starsNumber,
                        color: Colors.amber,
                        iconSize: 32,
                      ),
                      // StarRating(
                      //   rating: 0,
                      //   onChangeRating: (int rating) {},
                      // )
                    ],
                  ),
                  //خط في نهاية الكارد
                  Divider(
                    height: 1,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
