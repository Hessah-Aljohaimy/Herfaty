import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:herfaty/Points.dart/pointsDetails.dart';

//import 'package:herfaty/screens/ownerHome.dart';

import '../ShopOwnerOrder/OrderModel.dart';
import '../ShopOwnerOrder/orderDetails.dart';
import '../constants/color.dart';

class PointsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: DefaultAppBar(title: "قائمة نقاطي"),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: 630,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/cartBack1.png'),
                        fit: BoxFit.cover)),
                child: StreamBuilder<List<OrderModel>>(
                    stream: readPoints(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("somting wrong \n ${snapshot.error}");
                      } else if (!snapshot.hasData) {
                        return Text("");
                      } else if (snapshot.hasData) {
                        final cItems = snapshot.data!.toList();
                        Size size = MediaQuery.of(context).size;

                        cItems.sort((a, b) {
                          return DateTime.parse(a.orderDate)
                              .compareTo(DateTime.parse(b.orderDate));
                        });

                        if (cItems.isEmpty) {
                          return const Center(
                            child: Text(
                              'لا يوجد نقاط ',
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
                              itemCount: cItems.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(top: 8.0, bottom: 10),
                                  padding: EdgeInsets.only(
                                      top: 8.0, bottom: 8.0, right: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // border: Border.all(color: kPrimaryColor)
                                    border: Border(
                                      top: BorderSide(color: Color(0xFFF1F1F1)),
                                      bottom:
                                          BorderSide(color: Color(0xFFF1F1F1)),
                                    ),
                                  ),
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment
                                    //     .start, //takes the row to the top
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "  +${cItems[index].points}",
                                            style: TextStyle(
                                                color: Color(0xffF19B1A),
                                                fontSize: 35,
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
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text:
                                                    "   ${cItems[index].orderDate}",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 39, 141, 134),
                                                    fontSize: 20.0,
                                                    // decoration: TextDecoration
                                                    //     .underline,
                                                    fontFamily: "Tajawal"),
                                                // recognizer:
                                                //     TapGestureRecognizer()
                                                //       ..onTap = () {
                                                //         Navigator.push(
                                                //           context,
                                                // MaterialPageRoute(
                                                //     builder:
                                                //         (context) =>
                                                //               pointsDetails(
                                                //                 date:
                                                //                     cItems[index].orderDate,
                                                //                 totalOrder:
                                                //                     cItems[index].total,
                                                //                 docID:
                                                //                     cItems[index].docId,
                                                //                 products:
                                                //                     cItems[index].products,
                                                //                 status:
                                                //                     cItems[index].status,
                                                //               )),
                                                // );
                                                //  }
                                              ),
                                            ]),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: TextButton(
                                              child: Text(
                                                " تفاصيل الطلب",
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
                                                      builder: (context) =>
                                                          pointsDetails(
                                                            date: cItems[index]
                                                                .orderDate,
                                                            totalOrder:
                                                                cItems[index]
                                                                    .total,
                                                            docID: cItems[index]
                                                                .docId,
                                                            products:
                                                                cItems[index]
                                                                    .products,
                                                            status:
                                                                cItems[index]
                                                                    .status,
                                                          )),
                                                );
                                              },
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
                                    ],
                                  ),

//
                                );
                              });
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ), //single
          ],
        ), //tab
      ), //safold
    );
  } //widget
}

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const DefaultAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(56.0);
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,
          style: TextStyle(color: kPrimaryColor, fontFamily: "Tajawal")),
      centerTitle: true,
      backgroundColor: Colors.white,
      shadowColor: Color.fromARGB(255, 39, 141, 134),
      elevation: 3,
      automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(color: kPrimaryColor),
      leading: IconButton(
        padding: EdgeInsets.only(right: 20),
        icon: const Icon(
          Icons.arrow_back, //سهم العودة
          color: Color.fromARGB(255, 26, 96, 91),
          size: 22.0,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

Stream<List<OrderModel>> readPoints() {
  // final uid = user.getIdToken();
  final user;
  user = FirebaseAuth.instance.currentUser;
  try {
    final uid = user.uid;

    return FirebaseFirestore.instance
        .collection('orders')
        .where("shopOwnerId", isEqualTo: uid)
        // .where("status", isEqualTo: "طلب جديد")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => OrderModel.fromJson(doc.data()))
            .toList());
  } catch (e) {
    return FirebaseFirestore.instance.collection('orders').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => OrderModel.fromJson(doc.data()))
            .toList());
  }
}
