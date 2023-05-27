// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:herfaty/points%20base/RewardsCarousel.dart';
import 'package:herfaty/points.dart/pointsList.dart';
import 'package:herfaty/rating/ratingsList.dart';

//import '../pages/signupHerafy.dart';

class PointPanel extends StatefulWidget {
  const PointPanel({super.key});

  @override
  State<PointPanel> createState() => _PointPanelState();
}

class _PointPanelState extends State<PointPanel> {
  String thisOwnerId = "";
  int pointss = 0;
  double averageShopRating = 0;
  int numberOfRatings = 0;

  void initState() {
    print("============this is point panel initState====");
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    thisOwnerId = user!.uid;
    setOwnerPoints(thisOwnerId);
    //--------------------------------------------------------
    // setShopAverageRating(thisOwnerId);
    // setNumOfRatings(thisOwnerId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //To update shop rating continuously
    // CollectionReference reference =
    //     FirebaseFirestore.instance.collection('rating');
    // reference.snapshots().listen((querySnapshot) {
    //   querySnapshot.docChanges.forEach((change) async {
    //     setShopAverageRating(thisOwnerId);
    //     setNumOfRatings(thisOwnerId);
    //   });
    // });
    //===============================================
    print('entering rewards scroll method ==================');
    return StreamBuilder<List<ShopOwner>>(
        stream: getpoints1(thisOwnerId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("somting wrong \n ${snapshot.error}");
          } else if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final owner = snapshot.data!.toList();
            print("aaaaaaaaaaa ${owner.length}");

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
                  "${owner[0].points}",
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
                      //alignment: Alignment.topRight,
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
                            MaterialPageRoute(
                                builder: (context) => PointsList()),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
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
                //==================
              ]),
            );
          } else {
            return Center();
          }
        });
  }

//read current user
  //===================================================
  //reding the current user earned points
  Future<void> setOwnerPoints(String thisOwnerId) async {
    int existedPoints = await getpoints(thisOwnerId);
    if (existedPoints != 0) {
      setState(() {
        pointss = existedPoints;
      });
    } else {
      setState(() {
        pointss = 0;
      });
    }
  }

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

//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  Future<void> setShopAverageRating(String thisOwnerId) async {
    double existedShopRating = await getShopAverageRating(thisOwnerId);
    setState(() {
      averageShopRating = existedShopRating;
    });
  }

  //=======================================================================================
  Future<double> getShopAverageRating(String shopOwnerId) async {
    double averageShopRating = 0;
    num sumRating = 0;
    final shopDoc = await FirebaseFirestore.instance
        .collection('rating')
        .where("shopOwnerId", isEqualTo: shopOwnerId)
        .get();
    if (shopDoc.size > 0) {
      for (int i = 0; i < shopDoc.size; i++) {
        var data = shopDoc.docs.elementAt(i).data() as Map;
        double thisDocRating = data["starsNumber"];
        sumRating += thisDocRating;
      }

      averageShopRating = sumRating / shopDoc.size;
      String inString = averageShopRating.toStringAsFixed(2);
      averageShopRating = double.parse(inString);
      print(
          "=====this is point panel===== shop average rating is ${averageShopRating} ");
    }
    return averageShopRating;
  }

//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  Future<void> setNumOfRatings(String thisOwnerId) async {
    int existedRatingsNum = await getNumOfRatings(thisOwnerId);
    setState(() {
      numberOfRatings = existedRatingsNum;
    });
  }

  //=======================================================================================
  Future<int> getNumOfRatings(String shopOwnerId) async {
    int existedRatingsNum = 0;
    final shopDoc = await FirebaseFirestore.instance
        .collection('rating')
        .where("shopOwnerId", isEqualTo: shopOwnerId)
        .get();
    if (shopDoc.size > 0) {
      existedRatingsNum = shopDoc.size;
      print("shop ratings doc size is ${shopDoc.size}");
    }
    return existedRatingsNum;
  }

//=============================================================================================
  Container points_instructions() {
    return Container(
      padding: const EdgeInsets.all(5),
      // color: Colors.black,
      height: 210,
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
            Expanded(
              flex: 3,
              child: Text(
                " إذا قمت بجمع عدد أكبر النقاط و الكؤوس سيتم عرض متجرك من المتاجر الأفضل مبيعا عند المشتريين في لائحة المتاجر المميزة",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Tajawal"),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

//===================================================
Stream<List<ShopOwner>> getpoints1(String thisOwnerId) {
  int OwnerPoints = 0;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  String thisOwnerIdd = user!.uid;
  print("aaaaaaa $thisOwnerIdd");
  return FirebaseFirestore.instance
      .collection('shop_owner')
      .where("id", isEqualTo: thisOwnerIdd)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => ShopOwner.fromJson(doc.data())).toList());
  /* final OwnersDoc =  FirebaseFirestore.instance
        .collection('shop_owner')
        .where("id", isEqualTo: thisOwnerId)
        .get();
         var data = OwnersDoc.data() as Map;
    if (OwnersDoc.size > 0) {
      var data = OwnersDoc.docs.elementAt(0).data() as Map;
      OwnerPoints = data["points"];
      print("existed points is ${OwnerPoints}");
    }
    return OwnerPoints;
  }*/
}

class ShopOwner {
  String id;
  final String name;
  final String email;
  final String password;
  final String DOB;
  final String phone_number;
  final String logo;
  final String shopname;
  final String shopdescription;
  final int points;
  final String location;

  ShopOwner(
      {this.id = '',
      required this.name,
      required this.email,
      required this.password,
      required this.DOB,
      required this.phone_number,
      required this.logo,
      required this.shopname,
      required this.shopdescription,
      required this.points,
      required this.location});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'DOB': DOB,
        'logo': logo,
        'phone_number': phone_number,
        'shopdescription': shopdescription,
        'shopname': shopname,
        'points': points,
        'location': location
      };
  static ShopOwner fromJson(Map<String, dynamic> json) => ShopOwner(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      DOB: json['DOB'],
      logo: json['logo'],
      phone_number: json['phone_number'],
      shopdescription: json['shopdescription'],
      shopname: json['shopname'],
      points: json['points'],
      location: json['location']);
}
