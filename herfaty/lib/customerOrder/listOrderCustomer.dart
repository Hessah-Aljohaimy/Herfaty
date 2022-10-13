import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ShopOwnerOrder/OrderModel.dart';
import '../constants/color.dart';
import 'orderDetailsCustomer.dart';

//import 'package:flutterfiredemo/item_details.dart';
//import 'add_item.dart';

class listOrderCustomer extends StatelessWidget {
  listOrderCustomer({Key? key}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: DefaultAppBar(title: " الطلبات"),
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
                    stream: readPrpducts(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("somting wrong \n ${snapshot.error}");
                      } else if (!snapshot.hasData) {
                        return Text("");
                      } else if (snapshot.hasData) {
                        final cItems = snapshot.data!.toList();
                        Size size = MediaQuery.of(context).size;

                        cItems.sort((a, b) {
                          return b.orderDate.compareTo(a.orderDate);
                        });

                        if (cItems.isEmpty) {
                          return const Center(
                            child: Text(
                              'لا يوجد طلبات جديدة',
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
                                  margin: EdgeInsets.only(
                                      top: 8.0, left: 8.0, right: 8.0),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Color(0xFFF1F1F1))),
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
                                                      "طلب رقم ${cItems[index].docId}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 17.0,
                                                          fontFamily:
                                                              "Tajawal")),
                                                  Text(
                                                    "تاريح الطلب :${cItems[index].orderDate} ",
                                                    style: TextStyle(
                                                        fontSize: 17.0,
                                                        fontFamily: "Tajawal"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Color.fromARGB(
                                              255, 81, 144, 142), // background
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    orderDetailsCustomer(
                                                      date: cItems[index]
                                                          .orderDate,
                                                      totalOrder:
                                                          cItems[index].total,
                                                      docID:
                                                          cItems[index].docId,
                                                      products: cItems[index]
                                                          .products,
                                                      status:
                                                          cItems[index].status,
                                                    )),
                                          );
                                          //go to order deatils page
                                        },
                                        child: Text(
                                          "تفاصيل الطلب",
                                          style: TextStyle(
                                            fontFamily: "Tajawal",
                                          ),
                                        ),
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
            ),
            SingleChildScrollView(
              child: Container(
                height: 630,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/cartBack1.png'),
                        fit: BoxFit.cover)),
                child: StreamBuilder<List<OrderModel>>(
                    stream: readPrpducts2(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("somting wrong \n ${snapshot.error}");
                      } else if (!snapshot.hasData) {
                        return Text("");
                      } else if (snapshot.hasData) {
                        final cItems = snapshot.data!.toList();
                        Size size = MediaQuery.of(context).size;

                        cItems.sort((a, b) {
                          return b.orderDate.compareTo(a.orderDate);
                        });

                        if (cItems.isEmpty) {
                          return const Center(
                            child: Text(
                              'لا يوجد طلبات خارجة للتوصيل',
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
                                  margin: EdgeInsets.only(
                                      top: 8.0, left: 8.0, right: 8.0),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Color(0xFFF1F1F1))),
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
                                                      "طلب رقم ${cItems[index].docId}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 17.0,
                                                          fontFamily:
                                                              "Tajawal")),
                                                  Text(
                                                    "تاريح الطلب :${cItems[index].orderDate} ",
                                                    style: TextStyle(
                                                        fontSize: 17.0,
                                                        fontFamily: "Tajawal"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Color.fromARGB(
                                              255, 81, 144, 142), // background
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    orderDetailsCustomer(
                                                      date: cItems[index]
                                                          .orderDate,
                                                      totalOrder:
                                                          cItems[index].total,
                                                      docID:
                                                          cItems[index].docId,
                                                      products: cItems[index]
                                                          .products,
                                                      status:
                                                          cItems[index].status,
                                                    )),
                                          );
                                          //go to order deatils page
                                        },
                                        child: Text(
                                          "تفاصيل الطلب",
                                          style: TextStyle(
                                            fontFamily: "Tajawal",
                                          ),
                                        ),
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
            ),
            SingleChildScrollView(
              child: Container(
                height: 630,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/cartBack1.png'),
                        fit: BoxFit.cover)),
                child: StreamBuilder<List<OrderModel>>(
                    stream: readPrpducts3(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("somting wrong \n ${snapshot.error}");
                      } else if (!snapshot.hasData) {
                        return Text("");
                      } else if (snapshot.hasData) {
                        final cItems = snapshot.data!.toList();
                        Size size = MediaQuery.of(context).size;

                        cItems.sort((a, b) {
                          return b.orderDate.compareTo(a.orderDate);
                        });

                        if (cItems.isEmpty) {
                          return const Center(
                            child: Text(
                              'لا يوجد طلبات تم توصيلها',
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
                                  margin: EdgeInsets.only(
                                      top: 8.0, left: 8.0, right: 8.0),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Color(0xFFF1F1F1))),
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
                                                      "طلب رقم ${cItems[index].docId}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 17.0,
                                                          fontFamily:
                                                              "Tajawal")),
                                                  Text(
                                                    "تاريح الطلب :${cItems[index].orderDate} ",
                                                    style: TextStyle(
                                                        fontSize: 17.0,
                                                        fontFamily: "Tajawal"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Color.fromARGB(
                                              255, 81, 144, 142), // background
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    orderDetailsCustomer(
                                                      date: cItems[index]
                                                          .orderDate,
                                                      totalOrder:
                                                          cItems[index].total,
                                                      docID:
                                                          cItems[index].docId,
                                                      products: cItems[index]
                                                          .products,
                                                      status:
                                                          cItems[index].status,
                                                    )),
                                          );
                                          //go to order deatils page
                                        },
                                        child: Text(
                                          "تفاصيل الطلب",
                                          style: TextStyle(
                                            fontFamily: "Tajawal",
                                          ),
                                        ),
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
            ),
          ],
        ),
      ),
    );
  }
}

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const DefaultAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(100.0);
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,
          style: TextStyle(
            color: Color(0xff51908E),
            fontFamily: "Tajawal",
          )),
      centerTitle: true,
      backgroundColor: Colors.white,
      shadowColor: Color.fromARGB(255, 39, 141, 134),
      elevation: 0,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: Color(0xff51908E)),
      bottom: const TabBar(
        indicatorColor: Color(0xff51908E),
        labelColor: Color(0xff51908E),
        tabs: <Widget>[
          Tab(
            text: "طلب جديد",
          ),
          Tab(
            text: "خارج للتوصيل",
          ),
          Tab(
            text: "تم التوصيل",
          ),
        ],
      ),
    );
  }
}

Stream<List<OrderModel>> readPrpducts() {
  // final uid = user.getIdToken();
  final user;
  user = FirebaseAuth.instance.currentUser;
  try {
    final uid = user.uid;

    return FirebaseFirestore.instance
        .collection('orders')
        .where("customerId", isEqualTo: uid)
        .where("status", isEqualTo: "طلب جديد")
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

Stream<List<OrderModel>> readPrpducts2() {
  // final uid = user.getIdToken();
  final user;
  user = FirebaseAuth.instance.currentUser;
  try {
    final uid = user.uid;

    return FirebaseFirestore.instance
        .collection('orders')
        .where("customerId", isEqualTo: uid)
        .where("status", isEqualTo: "خارج للتوصيل")
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

Stream<List<OrderModel>> readPrpducts3() {
  // final uid = user.getIdToken();
  final user;
  user = FirebaseAuth.instance.currentUser;
  try {
    final uid = user.uid;

    return FirebaseFirestore.instance
        .collection('orders')
        .where("customerId", isEqualTo: uid)
        .where("status", isEqualTo: "تم التوصيل")
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
