import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ShopOwnerOrder/OrderModel.dart';
import '../constants/color.dart';
import 'orderDetailsCustomer.dart';
import '../models/Product1.dart';

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
                          return DateTime.parse(b.orderDate)
                              .compareTo(DateTime.parse(a.orderDate));
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
                                                          color:
                                                              Color(0xff4C8F2F),
                                                          fontSize: 17.0,
                                                          fontFamily:
                                                              "Tajawal")),
                                                  Text(
                                                    "تاريخ الطلب : ${cItems[index].orderDate} ",
                                                    style: TextStyle(
                                                        fontSize: 17.0,
                                                        color:
                                                            Color(0xff4C8F2F),
                                                        fontFamily: "Tajawal"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          StreamBuilder<List<Product1>>(
                                              stream: readProductD(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasError) {
                                                  return Text(
                                                      'somting wrong \n ${snapshot.error}');
                                                } else if (snapshot.hasData) {
                                                  List<Product1> PItems = [];
                                                  Map products;
                                                  products =
                                                      cItems[index].products;

                                                  final PItem =
                                                      snapshot.data!.toList();

                                                  if (PItems.length != 0) {
                                                    PItems = [];
                                                  }

                                                  products
                                                      .forEach((key, value) {
                                                    for (int i = 0;
                                                        i < PItem.length;
                                                        i++) {
                                                      if (PItem[i].id == key) {
                                                        //if (!PItems.contains(PItem[i]))
                                                        PItems.add(PItem[i]);
                                                      }
                                                    }
                                                  });

                                                  return Container(
                                                    width: 366,
                                                    height: 150,
                                                    margin: EdgeInsets.only(
                                                        top: 5.0,
                                                        right: 5.0,
                                                        left: 5.0),
                                                    padding: EdgeInsets.only(
                                                        bottom: 5.0),
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                      top: BorderSide(
                                                          width: 1.0,
                                                          color: kPrimaryColor),
                                                      /*bottom: BorderSide(
                                                          width: 1.0,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0)),
                                                      right: BorderSide(
                                                          width: 1.0,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0)),*/
                                                    )),
                                                    /*decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      border: Border.all(
                                                          color: Color(
                                                              0xff51908E),
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.5),
                                                          spreadRadius: 2,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),*/
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        //shrinkWrap: true,
                                                        itemCount:
                                                            PItems.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10.0,
                                                                    left: 10.0),
                                                            decoration:
                                                                BoxDecoration(
                                                                    border:
                                                                        Border(
                                                              bottom: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .grey),
                                                              top: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .grey),
                                                              left: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .grey),
                                                              right: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .grey),
                                                            )),
                                                            child: Row(
                                                              children: [
                                                                ProductImage(
                                                                  size: MediaQuery.of(
                                                                          context)
                                                                      .size,
                                                                  image: PItems[
                                                                          index]
                                                                      .image,
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                  );
                                                } else {
                                                  return Center(
                                                      child:
                                                          Text("يتم التحميل"));
                                                }
                                              }),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              "  عدد المنتجات ${cItems[index].products.length}",
                                              style: TextStyle(
                                                  fontFamily: "Tajawal",
                                                  color: Colors.grey)),
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
                                                  primary: Color(
                                                      0xff4C8F2F) // background
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
                                                          color:
                                                              Color(0xffF06676),
                                                          fontSize: 17.0,
                                                          fontFamily:
                                                              "Tajawal")),
                                                  Text(
                                                    "تاريخ الطلب : ${cItems[index].orderDate} ",
                                                    style: TextStyle(
                                                        fontSize: 17.0,
                                                        color:
                                                            Color(0xffF06676),
                                                        fontFamily: "Tajawal"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          StreamBuilder<List<Product1>>(
                                              stream: readProductD(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasError) {
                                                  return Text(
                                                      'somting wrong \n ${snapshot.error}');
                                                } else if (snapshot.hasData) {
                                                  List<Product1> PItems = [];
                                                  Map products;
                                                  products =
                                                      cItems[index].products;

                                                  final PItem =
                                                      snapshot.data!.toList();

                                                  if (PItems.length != 0) {
                                                    PItems = [];
                                                  }

                                                  products
                                                      .forEach((key, value) {
                                                    for (int i = 0;
                                                        i < PItem.length;
                                                        i++) {
                                                      if (PItem[i].id == key) {
                                                        //if (!PItems.contains(PItem[i]))
                                                        PItems.add(PItem[i]);
                                                      }
                                                    }
                                                  });

                                                  return Container(
                                                    width: 366,
                                                    height: 150,
                                                    margin: EdgeInsets.only(
                                                        top: 5.0,
                                                        right: 5.0,
                                                        left: 5.0),
                                                    padding: EdgeInsets.only(
                                                        bottom: 5.0),
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                      top: BorderSide(
                                                          width: 1.0,
                                                          color: kPrimaryColor),
                                                      /*bottom: BorderSide(
                                                          width: 1.0,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0)),
                                                      right: BorderSide(
                                                          width: 1.0,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0)),*/
                                                    )),
                                                    /*decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      border: Border.all(
                                                          color: Color(
                                                              0xff51908E),
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.5),
                                                          spreadRadius: 2,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),*/
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        //shrinkWrap: true,
                                                        itemCount:
                                                            PItems.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10.0,
                                                                    left: 10.0),
                                                            decoration:
                                                                BoxDecoration(
                                                                    border:
                                                                        Border(
                                                              bottom: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .grey),
                                                              top: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .grey),
                                                              left: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .grey),
                                                              right: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .grey),
                                                            )),
                                                            child: Row(
                                                              children: [
                                                                ProductImage(
                                                                  size: MediaQuery.of(
                                                                          context)
                                                                      .size,
                                                                  image: PItems[
                                                                          index]
                                                                      .image,
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                  );
                                                } else {
                                                  return Center(
                                                      child:
                                                          Text("يتم التحميل"));
                                                }
                                              }),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              "  عدد المنتجات ${cItems[index].products.length}",
                                              style: TextStyle(
                                                  fontFamily: "Tajawal",
                                                  color: Colors.grey)),
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
                                                  primary: Color(
                                                      0xffF06676) // background
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
                                                          color:
                                                              Color(0xfFF3CB4B),
                                                          fontSize: 17.0,
                                                          fontFamily:
                                                              "Tajawal")),
                                                  Text(
                                                    "تاريخ الطلب : ${cItems[index].orderDate} ",
                                                    style: TextStyle(
                                                        fontSize: 17.0,
                                                        color:
                                                            Color(0xfFF3CB4B),
                                                        fontFamily: "Tajawal"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          StreamBuilder<List<Product1>>(
                                              stream: readProductD(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasError) {
                                                  return Text(
                                                      'somting wrong \n ${snapshot.error}');
                                                } else if (snapshot.hasData) {
                                                  List<Product1> PItems = [];
                                                  Map products;
                                                  products =
                                                      cItems[index].products;

                                                  final PItem =
                                                      snapshot.data!.toList();

                                                  if (PItems.length != 0) {
                                                    PItems = [];
                                                  }

                                                  products
                                                      .forEach((key, value) {
                                                    for (int i = 0;
                                                        i < PItem.length;
                                                        i++) {
                                                      if (PItem[i].id == key) {
                                                        //if (!PItems.contains(PItem[i]))
                                                        PItems.add(PItem[i]);
                                                      }
                                                    }
                                                  });

                                                  return Container(
                                                    width: 366,
                                                    height: 150,
                                                    margin: EdgeInsets.only(
                                                        top: 5.0,
                                                        right: 5.0,
                                                        left: 5.0),
                                                    padding: EdgeInsets.only(
                                                        bottom: 5.0),
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                      top: BorderSide(
                                                          width: 1.0,
                                                          color: kPrimaryColor),
                                                      /*bottom: BorderSide(
                                                          width: 1.0,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0)),
                                                      right: BorderSide(
                                                          width: 1.0,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0)),*/
                                                    )),
                                                    /*decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      border: Border.all(
                                                          color: Color(
                                                              0xff51908E),
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.5),
                                                          spreadRadius: 2,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),*/
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        //shrinkWrap: true,
                                                        itemCount:
                                                            PItems.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10.0,
                                                                    left: 10.0),
                                                            decoration:
                                                                BoxDecoration(
                                                                    border:
                                                                        Border(
                                                              bottom: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .grey),
                                                              top: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .grey),
                                                              left: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .grey),
                                                              right: BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .grey),
                                                            )),
                                                            child: Row(
                                                              children: [
                                                                ProductImage(
                                                                  size: MediaQuery.of(
                                                                          context)
                                                                      .size,
                                                                  image: PItems[
                                                                          index]
                                                                      .image,
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                  );
                                                } else {
                                                  return Center(
                                                      child:
                                                          Text("يتم التحميل"));
                                                }
                                              }),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              "  عدد المنتجات ${cItems[index].products.length}",
                                              style: TextStyle(
                                                  fontFamily: "Tajawal",
                                                  color: Colors.grey)),
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
                                                  primary: Color(
                                                      0xfFF3CB4B) // background
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

Stream<List<Product1>> readProductD() => FirebaseFirestore.instance
    .collection('OrdersProducts')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Product1.fromJson(doc.data())).toList());

class ProductImage extends StatelessWidget {
  const ProductImage({
    Key? key,
    required this.size,
    required this.image,
  }) : super(key: key);

  final Size size;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(bottom: 10),
      height: size.width,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Image.network(
        image,
        height: size.width,
        width: size.width * 0.25,
        fit: BoxFit.cover,
      ),
    );
  }
}
