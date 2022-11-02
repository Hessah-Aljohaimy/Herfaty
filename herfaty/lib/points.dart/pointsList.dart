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
                        // Size size = MediaQuery.of(context).size;

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
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, //takes the row to the top
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start, //used for aligning the children vertically

                                        //
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      //cItems[index].customerId,
                                                      "  +${cItems[index].points}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: kPrimaryColor,
                                                          fontSize: 35.0,
                                                          fontFamily:
                                                              "Tajawal")),

                                                  //Icon(Icons.numbers),
                                                  RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text:
                                                              "${cItems[index].orderDate}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontSize: 17.0,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              fontFamily:
                                                                  "Tajawal"),
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            pointsDetails(
                                                                              date: cItems[index].orderDate,
                                                                              totalOrder: cItems[index].total,
                                                                              docID: cItems[index].docId,
                                                                              products: cItems[index].products,
                                                                              status: cItems[index].status,
                                                                            )),
                                                                  );
                                                                }),
                                                    ]),
                                                  ),
                                                  // Text(
                                                  //     //cItems[index].customerId,
                                                  //     "  + ${cItems[index].points}",
                                                  //     overflow:
                                                  //         TextOverflow.ellipsis,
                                                  //     style: TextStyle(
                                                  //         color: kPrimaryColor,
                                                  //         fontSize: 27.0,
                                                  //         fontFamily:
                                                  //             "Tajawal")),
                                                  // //Icon(Icons.numbers),
                                                  // Text(
                                                  //   "  ${cItems[index].orderDate} ",
                                                  //   style: TextStyle(
                                                  //       color: Colors.black,
                                                  //       fontSize: 17.0,
                                                  //       fontFamily: "Tajawal"),
                                                  // ),

                                                  // Padding(
                                                  //   padding:
                                                  //       const EdgeInsets.only(
                                                  //           left: 10),
                                                  //   child: Row(
                                                  //     mainAxisAlignment:
                                                  //         MainAxisAlignment.end,
                                                  //     children: [
                                                  //       Image.asset(
                                                  //         "assets/images/points_trophies/icons8-coins-64.png",
                                                  //         width: 40,
                                                  //       ),
                                                  //     ],
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 10),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           children: [
//                                             Image.asset(
//                                               "assets/images/points_trophies/icons8-coins-64.png",
//                                               width: 40,
//                                             ),
// ],
//                                         ),
//                                       ),
                                      // ElevatedButton(
                                      //   style: ElevatedButton.styleFrom(
                                      //       primary: Color(
                                      //           0xff4C8F2F) // background
                                      //       ),
                                      //   onPressed: () {
                                      //     Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               orderDetails(
                                      //                 date: cItems[index]
                                      //                     .orderDate,
                                      //                 totalOrder:
                                      //                     cItems[index]
                                      //                         .total,
                                      //                 docID: cItems[index]
                                      //                     .docId,
                                      //                 products:
                                      //                     cItems[index]
                                      //                         .products,
                                      //                 status:
                                      //                     cItems[index]
                                      //                         .status,
                                      //               )),
                                      //     );
                                      //     //go to order deatils page
                                      //   },
                                      //   child: Text(
                                      //     "تفاصيل الطلب",
                                      //     style: TextStyle(
                                      //       fontFamily: "Tajawal",
                                      //     ),
                                      //   ),
                                      // ),

                                      // MaterialButton(
                                      //   padding: EdgeInsets.all(8.0),
                                      //   textColor: Colors.white,
                                      //   splashColor: Colors.greenAccent,
                                      //   elevation: 8.0,
                                      //   child: Container(
                                      //     decoration: BoxDecoration(
                                      //       image: DecorationImage(
                                      //           image: AssetImage(
                                      //               'assets/images/cartBack1.png'),
                                      //           fit: BoxFit.cover),
                                      //     ),
                                      //     child: Padding(
                                      //       padding: const EdgeInsets.all(8.0),
                                      //       child: Text("تفاصيل الطلب"),
                                      //     ),
                                      //   ),
                                      //   // ),
                                      //   onPressed: () {},
                                      // ),
                                    ],
                                  ),
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
      elevation: 0,
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
