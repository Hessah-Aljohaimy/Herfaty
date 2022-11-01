import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class reviewOwnerPanle extends StatefulWidget {
  const reviewOwnerPanle({super.key});

  @override
  State<reviewOwnerPanle> createState() => _reviewOwnerPanleState();
}

class _reviewOwnerPanleState extends State<reviewOwnerPanle> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(
              width: 5,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: 200,
              height: 50,
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
              child: Row(
                children: [
                  Positioned(
                    bottom: 50,
                    top: 50,
                    child: Image.asset(
                      "assets/images/points_trophies/icons8-trophy.png",
                      width: 30,
                    ),
                  ),
                  Container(
                    // width: 80,
                    // height: 30,
                    child: Text(
                      "تقييمات متجري",
                      style: TextStyle(
                          color: Color(0xffF19B1A),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Tajawal"),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_rounded,
                      size: 20,
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
}
