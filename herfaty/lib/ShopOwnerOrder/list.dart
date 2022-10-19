import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:herfaty/ShopOwnerOrder/orderDetails.dart';

import '../constants/color.dart';
import 'OrderModel.dart';
//import 'package:flutterfiredemo/item_details.dart';
//import 'add_item.dart';

class list extends StatelessWidget {
  int selectedPage = 0;
  list({Key? key, required selectedPage})
      : this.selectedPage = selectedPage,
        super(key: key) {
    // _stream = _reference.snapshots();
  }

  /*
  Stream<List<orderModal>> readPrpducts() => FirebaseFirestore.instance
      // final uid = user.getIdToken();
      .collection('orders')
      //  .where("categoryName", isEqualTo: categoryName)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => orderModal.fromJson(doc.data())).toList());

  Widget buildUser(orderModal orderModel) => ListTile(
        //leading: CircleAvatar(child: Text('${orders.docId}')),
        title: Text(orderModel.docId),
        subtitle: Text('yes'),
      );*/
  //CollectionReference _reference =
  // FirebaseFirestore.instance.collection('ShopOwnerOrders');

  //late Stream<QuerySnapshot> _stream;

  // 1 METHOD....

  /*return FirebaseFirestore.instance
        .collection('orders')
        //  .where("categoryName", isEqualTo: categoryName)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => orderModel.fromJson(doc.data()))
            .toList());*/

  @override
  Widget build(BuildContext context) {
    const title = 'قائمة الطلبات';

    return DefaultTabController(
      initialIndex: selectedPage,
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: DefaultAppBar(title: "طلبات متجري"),

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
                          return DateTime.parse(a.orderDate)
                              .compareTo(DateTime.parse(b.orderDate));
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
                                                      "رقم الطلب : ${cItems[index].docId}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: kPrimaryColor,
                                                          fontSize: 17.0,
                                                          fontFamily:
                                                              "Tajawal")),
                                                  Text(
                                                    "تاريخ الطلب :${cItems[index].orderDate} ",
                                                    style: TextStyle(
                                                        color: kPrimaryColor,
                                                        fontSize: 17.0,
                                                        fontFamily: "Tajawal"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(255, 81,
                                                    144, 142), // background
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          orderDetails(
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
                          return DateTime.parse(a.orderDate)
                              .compareTo(DateTime.parse(b.orderDate));
                        });

                        if (cItems.isEmpty) {
                          return const Center(
                            child: Text(
                              'لا يوجد طلبات جاهزة للتوصيل',
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
                                                      "رقم الطلب : ${cItems[index].docId}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: kPrimaryColor,
                                                          fontSize: 17.0,
                                                          fontFamily:
                                                              "Tajawal")),
                                                  Text(
                                                    "تاريخ الطلب :${cItems[index].orderDate} ",
                                                    style: TextStyle(
                                                        color: kPrimaryColor,
                                                        fontSize: 17.0,
                                                        fontFamily: "Tajawal"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(255, 81,
                                                    144, 142), // background
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          orderDetails(
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
                    stream: readPrpducts4(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("somting wrong \n ${snapshot.error}");
                      } else if (!snapshot.hasData) {
                        return Text("");
                      } else if (snapshot.hasData) {
                        final cItems = snapshot.data!.toList();
                        Size size = MediaQuery.of(context).size;

                        cItems.sort((a, b) {
                          return DateTime.parse(b.orderDate)
                              .compareTo(DateTime.parse(a.orderDate));
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
                                                      "رقم الطلب : ${cItems[index].docId}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: kPrimaryColor,
                                                          fontSize: 17.0,
                                                          fontFamily:
                                                              "Tajawal")),
                                                  Text(
                                                    "تاريخ الطلب :${cItems[index].orderDate} ",
                                                    style: TextStyle(
                                                        color: kPrimaryColor,
                                                        fontSize: 17.0,
                                                        fontFamily: "Tajawal"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(255, 81,
                                                    144, 142), // background
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          orderDetails(
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
                          return DateTime.parse(b.orderDate)
                              .compareTo(DateTime.parse(a.orderDate));
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
                                                      "رقم الطلب : ${cItems[index].docId}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: kPrimaryColor,
                                                          fontSize: 17.0,
                                                          fontFamily:
                                                              "Tajawal")),
                                                  Text(
                                                    "تاريخ الطلب : ${cItems[index].orderDate} ",
                                                    style: TextStyle(
                                                        color: kPrimaryColor,
                                                        fontSize: 17.0,
                                                        fontFamily: "Tajawal"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(255, 81,
                                                    144, 142), // background
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          orderDetails(
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

        /*
        body: StreamBuilder<List<orderModal>>(
            stream: readPrpducts(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text('Some error occurred ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final orders = snapshot.data!; //.toList();
                return ListView(
                  children: orders.map(buildUser).toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      );
      }
    */
        //Check error
        /* if (snapshot.hasError) {
              return Center(child: Text('Some error occurred ${snapshot.error}'));
            
    
            //Check if data arrived
            if (snapshot.hasData) {
              //get the data
              QuerySnapshot querySnapshot = snapshot.data;
              final productItems = snapshot.data!.toList();
              List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    
              //Convert the documents to Maps
              List<Map> items = documents
                  .map((e) => {
                        'customerId': e['customerId'],
                        'docId': e['docId'],
                        'shopOwnerId': e['shopOwnerId'],
                        'location': e['location'],
                        'total': e['total'],
                        'shopName': e['shopName'],
                        'notification': e['notification'],
                        'productId': e['productId'],
                        'status': e['status'],
                        'cartDocId': e['cartDocId'],
                        'orderDate': e['orderDate'],
                      })
                  .toList();
    
              //Display the list
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    //Get the item at this index
                    Map thisItem = items[index];
                    //REturn the widget for the list items
                    return ListTile(
                      title: Text('${thisItem['orderDate']}'),
                      subtitle: Text('${thisItem['totalPrice']}'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => orderDetails(thisItem['id'])));
                      },
                    );
                  });
            }
    
            //Show loader
            return Center(child: CircularProgressIndicator());
          },
        ), //Display a list // Add a FutureBuilder
        /*floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddItem()));
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),*/
      );*/

        //
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
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ),
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: Color(0xff51908E)),
      bottom: const TabBar(
        labelPadding: EdgeInsets.only(left: 2),
        indicatorColor: Color(0xff51908E),
        labelColor: Color(0xff51908E),
        tabs: <Widget>[
          Tab(
            text: "طلب جديد",
          ),
          Tab(
            text: "جاهز للتوصيل",
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
        .where("shopOwnerId", isEqualTo: uid)
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
        .where("shopOwnerId", isEqualTo: uid)
        .where("status", isEqualTo: "جاهز للتوصيل")
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
        .where("shopOwnerId", isEqualTo: uid)
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

Stream<List<OrderModel>> readPrpducts4() {
  // final uid = user.getIdToken();
  final user;
  user = FirebaseAuth.instance.currentUser;
  try {
    final uid = user.uid;

    return FirebaseFirestore.instance
        .collection('orders')
        .where("shopOwnerId", isEqualTo: uid)
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
