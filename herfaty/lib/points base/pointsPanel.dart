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
      height: 50,
      child: Column(children: [
        Text(
          "مجموع نقاطي",
          style: TextStyle(
              color: Color(0xffF19B1A),
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: "Tajawal"),
        ),
      ]),
    );
  }

//read current user

}
