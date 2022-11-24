import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/topShops/shopCard.dart';
import 'package:herfaty/topShops/shopProduct.dart';

import '../models/shopOwnerModel.dart';

class topShops extends StatefulWidget {
  topShops({
    Key? key,
  }) : super(key: key);

  @override
  State<topShops> createState() => _topShopsState();
}

class _topShopsState extends State<topShops> {
  //variable to store the category name from categories page
  Stream<List<shopOwnerModel>> readShops() => FirebaseFirestore.instance
      .collection('shop_owner')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => shopOwnerModel.fromJson(doc.data()))
          .toList());

  //======================================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      appBar: topShopsAppBar(context),
      ///////////////////////////////////////////////////////////////////////////////////////////////
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/cartBack1.png'),
          fit: BoxFit.cover,
        )),
        height: double.infinity,
        child: StreamBuilder<List<shopOwnerModel>>(
          stream: readShops(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final allShops = snapshot.data!.toList(); //all shops

              final data = snapshot.data!;
              bool allZeros = false;
              bool tenPoints = false;
              bool fiftyPoints = false;
              bool hundredPoints = false;
              bool twoHundredPoints = false;
              bool fiveHundredPoints = false;
              List<shopOwnerModel> topShops1 = [];
              List<shopOwnerModel> topShops2 = [];
              List<shopOwnerModel> topShops3 = [];
              List<shopOwnerModel> topShops4 = [];
              List<shopOwnerModel> topShops5 = [];
              Map<shopOwnerModel, int> shopAndRank1 = {};
              Map<shopOwnerModel, int> shopAndRank2 = {};
              Map<shopOwnerModel, int> shopAndRank3 = {};
              Map<shopOwnerModel, int> shopAndRank4 = {};
              Map<shopOwnerModel, int> shopAndRank5 = {};

              //------------------------
              if (data.isNotEmpty) {
                allShops.sort((a, b) {
                  return b.points.compareTo(a.points);
                });

                if (allShops[0].points == 0) {
                  allZeros = true;
                }

                if (!allZeros) {
                  //counters for top shops
                  int counter1 = 0;
                  int counter2 = 0;
                  int counter3 = 0;
                  int counter4 = 0;
                  int counter5 = 0;
                  int counterAll = 0;
                  //-----------------------

                  num topPoint = allShops[counterAll].points;

                  //first
                  if (topPoint >= 500) {
                    fiveHundredPoints = true;
                    //first shop here
                    counter1++;
                    shopAndRank1[allShops[counterAll]] = counter1;
                    counterAll++;
                    //loop the rest
                    for (int i = counterAll; i < allShops.length; i++) {
                      //if no more in first
                      if (allShops[i].points < 500) {
                        topPoint = allShops[counterAll].points;
                        break;
                      }
                      //compare if equal points
                      if (allShops[i].points != allShops[i - 1].points) {
                        if (counter1 == 5) break;
                        counter1++;
                        shopAndRank1[allShops[i]] = counter1;
                      } //if they not equal
                      else if (allShops[i].points == allShops[i - 1].points) {
                        shopAndRank1[allShops[i]] = counter1;
                      }
                      counterAll++;
                    }
                  }
                  print("-----------------$counterAll");

                  //check if there is shops not in the next
                  for (int i = counterAll; i < allShops.length; i++) {
                    if (allShops[i].points < 500) {
                      topPoint = allShops[counterAll].points;
                      break;
                    }
                    counterAll++;
                  }
                  //check if ther is no more shops
                  if (counterAll == allShops.length) topPoint = 0;

                  //second
                  if (topPoint >= 200) {
                    twoHundredPoints = true;
                    counter2++;
                    shopAndRank2[allShops[counterAll]] = counter2;
                    counterAll++;
                    //loop the rest
                    for (int i = counterAll; i < allShops.length; i++) {
                      //if no more in second
                      if (allShops[i].points < 200) {
                        topPoint = allShops[counterAll].points;
                        break;
                      }
                      //compare if equal points
                      if (allShops[i].points != allShops[i - 1].points) {
                        if (counter2 == 5) break;
                        counter2++;
                        shopAndRank2[allShops[i]] = counter2;
                      } //if they not equal
                      else if (allShops[i].points == allShops[i - 1].points) {
                        shopAndRank2[allShops[i]] = counter2;
                      }
                      counterAll++;
                    }
                  }

                  //check if there is shops not in the next
                  for (int i = counterAll; i < allShops.length; i++) {
                    if (allShops[i].points < 200) {
                      topPoint = allShops[counterAll].points;
                      break;
                    }
                    counterAll++;
                  }
                  //check if ther is no more shops
                  if (counterAll == allShops.length) topPoint = 0;

                  //third
                  if (topPoint >= 100) {
                    hundredPoints = true;
                    counter3++;
                    shopAndRank3[allShops[counterAll]] = counter3;
                    counterAll++;
                    //loop the rest
                    for (int i = counterAll; i < allShops.length; i++) {
                      //if no more in third
                      if (allShops[i].points < 100) {
                        topPoint = allShops[counterAll].points;
                        break;
                      }
                      //compare if equal points
                      if (allShops[i].points != allShops[i - 1].points) {
                        if (counter3 == 5) break;
                        counter3++;
                        shopAndRank3[allShops[i]] = counter3;
                      } //if they not equal
                      else if (allShops[i].points == allShops[i - 1].points) {
                        shopAndRank3[allShops[i]] = counter3;
                      }
                      counterAll++;
                    }
                  }

                  //check if there is shops not in the next
                  for (int i = counterAll; i < allShops.length; i++) {
                    if (allShops[i].points < 100) {
                      topPoint = allShops[counterAll].points;
                      break;
                    }
                    counterAll++;
                  }
                  //check if ther is no more shops
                  if (counterAll == allShops.length) topPoint = 0;

                  //foruth
                  if (topPoint >= 50) {
                    fiftyPoints = true;
                    counter4++;
                    shopAndRank4[allShops[counterAll]] = counter4;
                    counterAll++;
                    //loop the rest
                    for (int i = counterAll; i < allShops.length; i++) {
                      //if no more in fourth
                      if (allShops[i].points < 50) {
                        topPoint = allShops[counterAll].points;
                        break;
                      }
                      //compare if equal points
                      if (allShops[i].points != allShops[i - 1].points) {
                        if (counter4 == 5) break;
                        counter4++;
                        shopAndRank4[allShops[i]] = counter4;
                      } //if they not equal
                      else if (allShops[i].points == allShops[i - 1].points) {
                        shopAndRank4[allShops[i]] = counter4;
                      }
                      counterAll++;
                    }
                  }

                  //check if there is shops not in the next
                  for (int i = counterAll; i < allShops.length; i++) {
                    if (allShops[i].points < 50) {
                      topPoint = allShops[counterAll].points;
                      break;
                    }
                    counterAll++;
                  }
                  //check if ther is no more shops
                  if (counterAll == allShops.length) topPoint = 0;

                  //last
                  if (topPoint >= 10) {
                    tenPoints = true;
                    counter5++;
                    shopAndRank5[allShops[counterAll]] = counter5;
                    counterAll++;
                    //loop the rest
                    for (int i = counterAll; i < allShops.length; i++) {
                      //if no more in first
                      if (allShops[i].points == 0) {
                        topPoint = allShops[counterAll].points;
                        break;
                      }
                      //compare if equal points
                      if (allShops[i].points != allShops[i - 1].points) {
                        if (counter5 == 5) break;
                        counter5++;
                        shopAndRank5[allShops[i]] = counter5;
                      } //if they not equal
                      else if (allShops[i].points == allShops[i - 1].points) {
                        shopAndRank5[allShops[i]] = counter5;
                      }
                      counterAll++;
                    }
                  }

                  if (fiveHundredPoints) {
                    shopAndRank1.forEach((k, v) => topShops1.add(k));
                  }

                  if (twoHundredPoints) {
                    shopAndRank2.forEach((k, v) => topShops2.add(k));
                  }

                  if (hundredPoints) {
                    shopAndRank3.forEach((k, v) => topShops3.add(k));
                  }

                  if (fiftyPoints) {
                    shopAndRank4.forEach((k, v) => topShops4.add(k));
                  }
                  if (tenPoints) {
                    shopAndRank5.forEach((k, v) => topShops5.add(k));
                  }
                } //end not all zeros
              } //end data not empty
              if (data.isEmpty) {
                return const Center(
                  child: Text(
                    'لا يوجد متاجر بعد',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Tajawal",
                      color: Colors.grey,
                    ),
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      //first
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Image.asset(
                            "assets/images/trophy.png",
                            height: 25,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "كأس الإحتراف",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Tajawal",
                                color: Colors.black
                                //color: Color(0xffFECE00),
                                ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "(المتاجر التي حققت 500 نقطة فأكثر)",
                            style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Tajawal",
                                color: Colors.grey
                                //color: Color(0xffFECE00),
                                ),
                          ),
                        ],
                      ),
                      if (!fiveHundredPoints)
                        Container(
                          height: 50,
                          //color: Colors.white,
                          child: Center(
                            child: Text(
                              'لا يوجد متاجر متصدرة لهذا الكأس',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Tajawal",
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      if (fiveHundredPoints)
                        Container(
                          //height: 130,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.only(left: 10),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: topShops1.length,
                              itemBuilder: (context, index) => shopCard(
                                itemIndex: index,
                                shop: topShops1[index],
                                shopRanking: shopAndRank1[topShops1[index]],
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => shopProduct(
                                        shopID: topShops1[index].id,
                                        shopName: topShops1[index].shopname,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      //second
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Image.asset(
                            "assets/images/trophy.png",
                            height: 25,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "كأس الإبداع",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Tajawal",
                                color: Colors.black
                                //color: Color(0xffFECE00),
                                ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "(المتاجر التي حققت 200 نقطة فأكثر)",
                            style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Tajawal",
                                color: Colors.grey
                                //color: Color(0xffFECE00),
                                ),
                          ),
                        ],
                      ),
                      if (!twoHundredPoints)
                        Container(
                          height: 50,
                          //color: Colors.white,
                          child: Center(
                            child: Text(
                              'لا يوجد متاجر متصدرة لهذا الكأس',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Tajawal",
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      if (twoHundredPoints)
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.only(left: 10),
                          //height: 130,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: topShops2.length,
                            itemBuilder: (context, index) => shopCard(
                              itemIndex: index,
                              shop: topShops2[index],
                              shopRanking: shopAndRank2[topShops2[index]],
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => shopProduct(
                                      shopID: topShops2[index].id,
                                      shopName: topShops2[index].shopname,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      //third
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Image.asset(
                            "assets/images/trophy.png",
                            height: 25,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "كأس المهارة",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Tajawal",
                                color: Colors.black
                                //color: Color(0xffFECE00),
                                ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "(المتاجر التي حققت 100 نقطة فأكثر)",
                            style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Tajawal",
                                color: Colors.grey
                                //color: Color(0xffFECE00),
                                ),
                          ),
                        ],
                      ),
                      if (!hundredPoints)
                        Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              'لا يوجد متاجر متصدرة لهذا الكأس',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Tajawal",
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      if (hundredPoints)
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.only(left: 10),
                          //height: 130,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: topShops3.length,
                            itemBuilder: (context, index) => shopCard(
                              itemIndex: index,
                              shop: topShops3[index],
                              shopRanking: shopAndRank3[topShops3[index]],
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => shopProduct(
                                      shopID: topShops3[index].id,
                                      shopName: topShops3[index].shopname,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      //fourth
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Image.asset(
                            "assets/images/trophy.png",
                            height: 25,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "كأس الإتقان",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Tajawal",
                                color: Colors.black
                                //color: Color(0xffFECE00),
                                ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "(المتاجر التي حققت 50 نقطة فأكثر)",
                            style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Tajawal",
                                color: Colors.grey
                                //color: Color(0xffFECE00),
                                ),
                          ),
                        ],
                      ),
                      if (!fiftyPoints)
                        Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              'لا يوجد متاجر متصدرة لهذا الكأس',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Tajawal",
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      if (fiftyPoints)
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.only(left: 10),
                          //height: 130,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: topShops4.length,
                            itemBuilder: (context, index) => shopCard(
                              itemIndex: index,
                              shop: topShops4[index],
                              shopRanking: shopAndRank4[topShops4[index]],
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => shopProduct(
                                      shopID: topShops4[index].id,
                                      shopName: topShops4[index].shopname,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      //last
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Image.asset(
                            "assets/images/trophy.png",
                            height: 25,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "كأس البدء",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Tajawal",
                                color: Colors.black
                                //color: Color(0xffFECE00),
                                ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "(المتاجر التي حققت 10 نقاط فأكثر)",
                            style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Tajawal",
                                color: Colors.grey
                                //color: Color(0xffFECE00),
                                ),
                          ),
                        ],
                      ),
                      if (!tenPoints)
                        Container(
                          height: 50,
                          //color: Colors.white,
                          child: Center(
                            child: Text(
                              'لا يوجد متاجر متصدرة لهذا الكأس',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Tajawal",
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      if (tenPoints)
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.only(left: 10),
                          //height: 130,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: topShops5.length,
                            itemBuilder: (context, index) => shopCard(
                              itemIndex: index,
                              shop: topShops5[index],
                              shopRanking: shopAndRank5[topShops5[index]],
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => shopProduct(
                                      shopID: topShops5[index].id,
                                      shopName: topShops5[index].shopname,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }
              //..................................................................................
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //AppBar
  AppBar topShopsAppBar(var context) {
    return AppBar(
      shadowColor: Color.fromARGB(255, 39, 141, 134),
      elevation: 3,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        " المتاجر الأكثر نقاطاً",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: kPrimaryColor,
          fontFamily: "Tajawal",
        ),
      ),
      leading: IconButton(
        padding: EdgeInsets.only(right: 20),
        icon: const Icon(
          Icons.arrow_back, //سهم العودة
          color: Color.fromARGB(255, 26, 96, 91),
          size: 22.0,
        ),
        onPressed: () {
          Navigator.pop(context);
        }, //نخليه يرجع لصفحة المنتجات اللي عند عائشة
      ),
    );
  }
}
