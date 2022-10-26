import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herfaty/Points.dart/pointsModel.dart';

import '../ShopOwnerOrder/OrderModel.dart';
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
                                    children: [
                                      Row(
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
                                                      "  + ${cItems[index].shopOwnerId}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 17.0,
                                                          fontFamily:
                                                              "Tajawal")),
                                                  Text(
                                                    "تاريخ الطلب :${cItems[index].orderDate} ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17.0,
                                                        fontFamily: "Tajawal"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
      iconTheme: IconThemeData(color: kPrimaryColor),
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
