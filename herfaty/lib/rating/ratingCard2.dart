// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/models/ratingModel.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class ratingCard2 extends StatefulWidget {
  const ratingCard2({
    Key? key,
    required this.itemIndex,
    required this.ratingItem,
    required this.averageShopRating,
  }) : super(key: key);

  final int itemIndex;
  final ratingModel ratingItem;
  final num averageShopRating;

  @override
  State<ratingCard2> createState() => _ratingCard2State();
}

class _ratingCard2State extends State<ratingCard2> {
  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; //to get the width and height of the app
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListTile(
        tileColor: Colors.white,
        minVerticalPadding: 10,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        //leading: FlutterLogo(size: 72.0),
        title: Text(
          widget.ratingItem.comment,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            fontFamily: "Tajawal",
            color: Colors.black,
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // عدد نجوم هذا التقييم رقمًا
                Padding(
                  padding: const EdgeInsets.only(top: 9.0, left: 5.0),
                  child: Text(
                    "${widget.ratingItem.starsNumber}",
                    style: const TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Tajawal",
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                //  عدد نجوم هذا التقييم على شكل نجوم ممتلئة نسبيًا
                RatingStars(
                  editable: false,
                  rating: widget.ratingItem.starsNumber,
                  color: Colors.amber,
                  iconSize: 28,
                ),
              ],
            ),
            //-----------------------------------------------------
            Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Date Icon
                Icon(
                  Icons.access_time_outlined,
                  color: kPrimaryLight,
                  size: 16.0,
                ),

                //*************************This part contains rating date التاريخ
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, right: 5.0),
                  child: Text(
                    widget.ratingItem.date,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Tajawal",
                      color: Color.fromARGB(255, 93, 91, 91),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
