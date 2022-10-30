import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PiointsInstruction extends StatefulWidget {
  const PiointsInstruction({super.key});

  @override
  State<PiointsInstruction> createState() => _PiointsInstructionState();
}

class _PiointsInstructionState extends State<PiointsInstruction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      // color: Colors.black,
      height: 180,
      width: 390,
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
          height: 12,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "كيف تكسب نقاطك؟",
              style: TextStyle(
                  color: Color.fromARGB(255, 230, 153, 38),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Tajawal"),
            ),
            Positioned(
              // bottom: 50,
              // top: 50,
              child: Image.asset(
                "assets/images/points_trophies/icons8receivecash.png",
                width: 27,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            // Positioned(
            //   // bottom: 50,
            //   // top: 50,
            //   child: Image.asset(
            //     "assets/images/points_trophies/icons8-approval-64.png",
            //     width: 27,
            //   ),
            // ),
            Text(
              "إذا قمت قمت ببيع منتج من منتجاتك ستحصل على 10 نقاط",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Tajawal"),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              "كيف تكسب الكؤوس؟",
              style: TextStyle(
                  color: Color.fromARGB(255, 230, 153, 38),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Tajawal"),
            ),
            Positioned(
              // bottom: 50,
              // top: 50,
              child: Image.asset(
                "assets/images/points_trophies/icons8-trophy-64.png",
                width: 20,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            // Positioned(
            //   // bottom: 50,
            //   // top: 50,
            //   child: Image.asset(
            //     "assets/images/points_trophies/icons8-shop-94.png",
            //     width: 27,
            //   ),
            // ),
            Text(
              "إذا قمت قمت بجمع العدد المطلوب من النقاط ستنال الكأس",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Tajawal"),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              "بماذا تفيدك النقاط؟",
              style: TextStyle(
                  color: Color.fromARGB(255, 230, 153, 38),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Tajawal"),
            ),
            Positioned(
              // bottom: 50,
              // top: 50,
              child: Image.asset(
                "assets/images/points_trophies/icons8-sparkling-64.png",
                width: 20,
              ),
            ),
          ],
        ),
        Row(
          children: [
            // Positioned(
            //   // bottom: 50,
            //   // top: 50,
            //   child: Image.asset(
            //     "assets/images/points_trophies/icons8-shop-94.png",
            //     width: 27,
            //   ),
            // ),
            Text(
              "إذا قمت قمت بجمع العدد المطلوب من النقاط ستنال الكأس",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Tajawal"),
            ),
          ],
        ),
      ]),
    );
  }
}
