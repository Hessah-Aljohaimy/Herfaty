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
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/cartBack1.png'),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: [
              //تبعد لي البوكس اللي يعرض المنتجات عن الشريط العلوي
              const SizedBox(height: 15),
              Expanded(
                child: Stack(
                  children: [
                    //This is to list all of our items fetched from the DB========================
                    StreamBuilder<List<shopOwnerModel>>(
                      stream: readShops(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Text(
                              'Something went wrong! ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final allShops = snapshot.data!.toList(); //all shops

                          final data = snapshot.data!;
                          bool allZeros = false;
                          List<shopOwnerModel> topShops = [];
                          Map<shopOwnerModel, int> t = Map();

                          //------------------------
                          if (data.isNotEmpty) {
                            allShops.sort((a, b) {
                              return b.points.compareTo(a.points);
                            });

                            int counter = 1;

                            if (allShops[0].points == 0) {
                              allZeros = true;
                            }
                            if (!allZeros) {
                              t[allShops[0]] = counter;
                              //counter++;
                              //topShops.add(productItems[0]);
                              for (int i = 1; i < allShops.length; i++) {
                                //topShops.add(productItems[i]);
                                if (allShops[i].points == 0) break;
                                if (allShops[i].points !=
                                    allShops[i - 1].points) {
                                  counter++;
                                  t[allShops[i]] = counter;
                                } else if (allShops[i].points ==
                                    allShops[i - 1].points) {
                                  t[allShops[i]] = counter;
                                }
                                if (counter == 5) break;
                              }
                              t.forEach((k, v) => topShops.add(k));
                            }
                          }
                          if (data.isEmpty) {
                            return const Center(
                              child: Text(
                                'لا يوجد متاجر متاحة',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Tajawal",
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          } else if (allZeros) {
                            return const Center(
                              child: Text(
                                'كلهم صفر',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Tajawal",
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: topShops.length,
                              itemBuilder: (context, index) => shopCard(
                                itemIndex: index,
                                shop: topShops[index],
                                shopRanking: t[topShops[index]],
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => shopProduct(
                                        shopID: topShops[index].id,
                                        shopName: topShops[index].name,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          //..................................................................................
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                    //==================================================================================
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //AppBar
  AppBar topShopsAppBar(var context) {
    return AppBar(
      elevation: 0,
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
