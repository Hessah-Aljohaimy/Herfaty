import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PointPanel extends StatefulWidget {
  const PointPanel({super.key});

  @override
  State<PointPanel> createState() => _PointPanelState();
}

class _PointPanelState extends State<PointPanel> {
  @override
  Widget build(BuildContext context) {
    print('entering rewards scroll method ==================');
    return Container(
      // color: Colors.black,
      height: 120,
      width: 400,
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
      child: Column(children: [
        SizedBox(
          height: 10,
        ),
        Text(
          "مجموع نقاطي",
          style: TextStyle(
              color: Color(0xffF19B1A),
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: "Tajawal"),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "10 ",
          style: TextStyle(
              color: Color(0xff51908E),
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: "Tajawal"),
        ),
      ]),
    );
  }

//read current user

}
