import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:herfaty/points%20base/RewardsCarousel.dart';
import 'package:herfaty/points.dart/pointsList.dart';

class PointPanel extends StatefulWidget {
  const PointPanel({super.key});

  @override
  State<PointPanel> createState() => _PointPanelState();
}

class _PointPanelState extends State<PointPanel> {
  int points = 0;
  void initState() {
    print("this is app bar initState====");
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String thisOwnerId = user!.uid;
    setOwnerPoints(thisOwnerId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('entering rewards scroll method ==================');
    return Container(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "مجموع نقاطي",
              style: TextStyle(
                  color: Color(0xffF19B1A),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Tajawal"),
            ),
            Positioned(
              bottom: 50,
              top: 50,
              child: Image.asset(
                "assets/images/points_trophies/icons8-coins-64.png",
                width: 40,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "${points}",
          style: TextStyle(
              color: Color(0xff51908E),
              fontSize: 35,
              fontWeight: FontWeight.bold,
              fontFamily: "Tajawal"),
        ),
        Indicator(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: TextButton(
                child: Text(
                  "سجل نقاطي",
                  style: TextStyle(
                      color: Color(0xff44ADE8),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Tajawal"),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PointsList()),
                  );
                },
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PointsList()),
                );
              },
              icon: Icon(
                Icons.arrow_forward_rounded,
                size: 20,
                color: Color(0xff44ADE8),
              ),
            ),
          ],
        ),
      ]),
    );
  }

//read current user
  //===================================================
  //reding the current user earned points
  Future<void> setOwnerPoints(String thisOwnerId) async {
    int existedPoints = await getpoints(thisOwnerId);
    if (existedPoints != 0) {
      setState(() {
        points = existedPoints;
      });
    } else {
      setState(() {
        points = 0;
      });
    }
  }

  //===================================================
  Future<int> getpoints(String thisOwnerId) async {
    int OwnerPoints = 0;
    final OwnersDoc = await FirebaseFirestore.instance
        .collection('shop_owner')
        .where("id", isEqualTo: thisOwnerId)
        .get();
    if (OwnersDoc.size > 0) {
      var data = OwnersDoc.docs.elementAt(0).data() as Map;
      OwnerPoints = data["points"];
      print("existed points is ${OwnerPoints}");
    }
    return OwnerPoints;
  }
}
