import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/constants/size.dart';
import 'package:herfaty/models/ownerServices.dart';
import 'package:herfaty/points%20base/RewardsCarousel.dart';
import 'package:herfaty/points%20base/peofile_circle.dart';
import 'package:herfaty/points%20base/pointsPanel.dart';
import 'package:herfaty/points%20base/points_Instructions.dart';
import 'package:herfaty/points%20base/reviewOwnerPanle.dart';

import 'package:herfaty/widgets/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ShopOwnerOrder/list.dart';
import 'ownerProductsCateg.dart';

class ownerHomeScreen extends StatefulWidget {
  const ownerHomeScreen({Key? key}) : super(key: key);

  @override
  _ownerHomeScreenState createState() => _ownerHomeScreenState();
}

class _ownerHomeScreenState extends State<ownerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage('assets/images/HomePageBackgroundOwner.png'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: const [
                AppBar(),
                Body(),
                // Services(),
                RewardsCarousel(),

                Rewards(),
                const SizedBox(
                  height: 10,
                ),
                // Indicator(),
                PointPanel(),
                const SizedBox(
                  height: 10,
                ),
                PiointsInstruction(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    print('entering body method ==================');
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class ownerServicesCard extends StatelessWidget {
  final ownerServices ownerService;
  const ownerServicesCard({
    Key? key,
    required this.ownerService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        // Within the SecondRoute widget
        padding: const EdgeInsets.all(10),

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                ownerService.photo,
                height: kCategoryCardImageSize,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(ownerService.name,
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Tajawal",
                    fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class AppBar extends StatefulWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  String thisOwnerName = "";
  @override
  void initState() {
    print("this is app bar initState====");
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String thisOwnerId = user!.uid;
    setOwnerName(thisOwnerId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 150,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Color.fromARGB(232, 238, 232, 182),
        gradient: LinearGradient(
          colors: [
            (Color.fromARGB(255, 81, 144, 142)),
            (Color.fromARGB(255, 85, 150, 165)),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: prefer_const_constructors
              Text(
                "مرحباً بك  ${thisOwnerName} ",
                // ignore: prefer_const_constructors
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: "Tajawal"),
                //textDirection: TextDirection.rtl,
              ),
              /* profileButton(
                icon: Icons.account_circle_sharp,
                onPressed: () {},
              ),*/
              // ProfileCicle()
            ],
          ),
          // const SizedBox(
          //   height: 20,
          // ),
        ],
      ),
    );
  }
  //======================================================================================

  Future<void> setOwnerName(String thisOwnerId) async {
    String existedName = await getName(thisOwnerId);
    if (existedName != "") {
      setState(() {
        thisOwnerName = existedName;
      });
    } else {
      setState(() {
        thisOwnerName = "أيها الحرفي";
      });
    }
  }

//===================================================================================
  Future<String> getName(String thisOwnerId) async {
    String OwnerName = "";
    final OwnersDoc = await FirebaseFirestore.instance
        .collection('shop_owner')
        .where("id", isEqualTo: thisOwnerId)
        .get();

    if (OwnersDoc.size > 0) {
      var data = OwnersDoc.docs.elementAt(0).data() as Map;
      OwnerName = data["name"];
      print("existed name is ${OwnerName}");
    }
    return OwnerName;
  }
}

class Services extends StatelessWidget {
  const Services({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<List<ownerServices>>(
              stream: readCaterories(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('somting wrong \n ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final cItems = snapshot.data!.toList();

                  return GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 24,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          child: ownerServicesCard(
                            ownerService: cItems[index],
                          ),
                          onTap: () {
                            if (cItems[index].name == "لعبة") {
                            } else if (cItems[index].name == "احصائيات") {}
                          });
                    },
                    itemCount: cItems.length,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }
}

// Stream to reach collection

Stream<List<ownerServices>> readCaterories() => FirebaseFirestore.instance
    .collection('ownerServices')
    .snapshots()
    .map((snapshot) => snapshot.docs
        .map((doc) => ownerServices.fromJson(doc.data()))
        .toList());
