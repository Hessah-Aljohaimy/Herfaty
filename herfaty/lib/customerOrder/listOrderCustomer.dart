// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/customerOrder/scroll_indicator.dart';
import 'package:herfaty/models/ratingModel.dart';
import 'package:rating_dialog/rating_dialog.dart';
import '../ShopOwnerOrder/OrderModel.dart';
import '../constants/color.dart';
import 'orderDetailsCustomer.dart';
import '../models/Product1.dart';
import 'package:intl/intl.dart';

//import 'package:flutterfiredemo/item_details.dart';
//import 'add_item.dart';

class listOrderCustomer extends StatefulWidget {
  listOrderCustomer({Key? key}) : super(key: key) {}

  @override
  State<listOrderCustomer> createState() => _listOrderCustomerState();
}

class _listOrderCustomerState extends State<listOrderCustomer> {
  List<ScrollController> arr = List.empty(growable: true);
  List<ScrollController> arr1 = List.empty(growable: true);
  List<ScrollController> arr2 = List.empty(growable: true);

  @override
  void initState() {
    arr = List.empty(growable: true);
    arr1 = List.empty(growable: true);
    arr2 = List.empty(growable: true);
    super.initState();
  }

  @override
  void dispose() {
    for (int i = 0; i < arr.length; i++) {
      arr[i].dispose();
    }
    for (int i = 0; i < arr1.length; i++) {
      arr1[i].dispose();
    }
    for (int i = 0; i < arr2.length; i++) {
      arr2[i].dispose();
    }

    //scrollController.dispose();

    super.dispose();
  }

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
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        final cItems = snapshot.data!.toList();
                        Size size = MediaQuery.of(context).size;

                        cItems.sort((a, b) {
                          return DateTime.parse(b.orderDate)
                              .compareTo(DateTime.parse(a.orderDate));
                        });

                        /*arr = List.filled(cItems.length, ScrollController(),
                            growable: false);*/

                        for (int i = 0; i < cItems.length; i++) {
                          //if (cItems[i].products.length > 3)
                          arr.insert(i, ScrollController());
                        }

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
                                var x;
                                if (cItems[index].products.length > 3) {
                                  x = arr[index];
                                } else
                                  x = null;
                                print("111111111111111${x}");

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
                                                      if (PItem[i].productId ==
                                                          key) {
                                                        //if (!PItems.contains(PItem[i]))
                                                        PItems.add(PItem[i]);
                                                      }
                                                    }
                                                  });
                                                  dynamic c = arr[index];

                                                  if (cItems[index]
                                                          .products
                                                          .length <
                                                      4) c = null;

                                                  print(
                                                      "erooorrr11111 ${index}");

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
                                                          color: Color(
                                                              0xff4C8F2F)),
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
                                                        controller: x,
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
                                                          CircularProgressIndicator());
                                                }
                                              }),
                                        ],
                                      ),
                                      if (cItems[index].products.length > 3)
                                        ScrollIndicator(
                                          scrollController: arr[index],
                                          width: 50,
                                          height: 5,
                                          indicatorWidth: 35,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey[300]),
                                          indicatorDecoration: BoxDecoration(
                                              color: Color(0xff4C8F2F),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
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
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        final cItems = snapshot.data!.toList();
                        Size size = MediaQuery.of(context).size;

                        cItems.sort((a, b) {
                          return DateTime.parse(a.orderDate)
                              .compareTo(DateTime.parse(b.orderDate));
                        });

                        /* arr1 = List.filled(cItems.length, ScrollController(),
                            growable: false);*/

                        for (int i = 0; i < cItems.length; i++) {
                          //if (cItems[i].products.length > 3)
                          arr1.insert(i, ScrollController());
                        }

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
                                var x;
                                if (cItems[index].products.length > 3) {
                                  x = arr1[index];
                                } else
                                  x = null;
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
                                                      if (PItem[i].productId ==
                                                          key) {
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
                                                          color: Color(
                                                              0xffF06676)),
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
                                                        controller: x,
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
                                                          CircularProgressIndicator());
                                                }
                                              }),
                                        ],
                                      ),
                                      if (cItems[index].products.length > 3)
                                        ScrollIndicator(
                                          scrollController: arr1[index],
                                          width: 50,
                                          height: 5,
                                          indicatorWidth: 35,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey[300]),
                                          indicatorDecoration: BoxDecoration(
                                              color: Color(0xffF06676),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
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
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        final cItems = snapshot.data!.toList();
                        Size size = MediaQuery.of(context).size;

                        cItems.sort((a, b) {
                          return DateTime.parse(b.orderDate)
                              .compareTo(DateTime.parse(a.orderDate));
                        });

                        /*arr2 = List.filled(cItems.length, ScrollController(),
                            growable: false);*/

                        for (int i = 0; i < cItems.length; i++) {
                          //if (cItems[i].products.length > 3)
                          arr2.insert(i, ScrollController());
                        }

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
                                var x;
                                if (cItems[index].products.length > 3) {
                                  x = arr2[index];
                                } else
                                  x = null;
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
                                                          color: Color.fromARGB(
                                                              255,
                                                              48,
                                                              137,
                                                              162),
                                                          fontSize: 17.0,
                                                          fontFamily:
                                                              "Tajawal")),
                                                  Text(
                                                    "تاريخ الطلب : ${cItems[index].orderDate} ",
                                                    style: TextStyle(
                                                        fontSize: 17.0,
                                                        color: Color.fromARGB(
                                                            255, 48, 137, 162),
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
                                                      if (PItem[i].productId ==
                                                          key) {
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
                                                          color: Color.fromARGB(
                                                              255,
                                                              48,
                                                              137,
                                                              162)),
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
                                                        controller: x,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        //shrinkWrap: true,
                                                        itemCount:
                                                            PItems.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          print("erooorrr");
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
                                                          CircularProgressIndicator());
                                                }
                                              }),
                                        ],
                                      ),
                                      if (cItems[index].products.length > 3)
                                        ScrollIndicator(
                                          scrollController: arr2[index],
                                          width: 50,
                                          height: 5,
                                          indicatorWidth: 35,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey[300]),
                                          indicatorDecoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 48, 137, 162),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
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
                                            //----------------------------------------
                                            // زر تقييم المتجر
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .amber, // background
                                                ),
                                                onPressed: () async {
                                                  String shopLogo =
                                                      await getShopLogo(
                                                          cItems[index]
                                                              .shopOwnerId);
                                                  //show rating dialog
                                                  showRatingDialog(
                                                      cItems[index].docId,
                                                      cItems[index].shopName,
                                                      cItems[index].shopOwnerId,
                                                      shopLogo);
                                                },
                                                child: Text(
                                                  "تقييم المتجر",
                                                  style: TextStyle(
                                                    fontFamily: "Tajawal",
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //-------------------------------------
                                            //--------------------------------------------------
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Color.fromARGB(
                                                      255,
                                                      48,
                                                      137,
                                                      162) // background
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

  //Rating=============================================================================================
  ///////////////////////////////////////////////////////////////////////////////////////////////
  void showRatingDialog(
      String orderId, String shopName, String shopOwneerId, String shopLogo) {
    bool hasLogo = true;
    if (shopLogo == "") {
      hasLogo = false;
    }
    final _dialog = RatingDialog(
      initialRating: 0.0,
      // your app's name?
      title: Text(
        'قيّم متجري',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          color: Colors.amber,
        ),
      ),
      // encourage your user to leave a high rating?
      message: Text(
        "في هذا الطلب كيف كانت تجربتك مع ${shopName}؟ يمكنك إضافة ملاحظاتك لتصل لصاحب المتجر ",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: Color.fromARGB(157, 20, 129, 137),
        ),
      ),
      // logo
      image: hasLogo
          ? Image.network(
              shopLogo,
              height: 150,
              width: 150,
              fit: BoxFit.contain,
            )
          : Image.asset(
              "assets/images/herfatyLogo.png",
              height: 150,
              width: 150,
              fit: BoxFit.contain,
            ),
      submitButtonText: 'إرسال',
      commentHint: 'اكتب ملاحظاتك هنا',
      onCancelled: () => print('cancelled'),
      //................................................add rating to the database
      onSubmitted: (response) async {
        //get current date and time firstly
        String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
        String cdateTime =
            DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());

        String commentToBeStored;
        if (response.comment == "") {
          commentToBeStored = "بدون تعليق";
        } else {
          commentToBeStored = response.comment;
        }
        ratingModel item = ratingModel(
            starsNumber: response.rating,
            shopOwnerId: shopOwneerId,
            orderId: orderId,
            comment: commentToBeStored,
            date: cdate,
            dateTime: cdateTime);
        createRatingItem(item);
        await showToastMethod(context, "شكرًا، تم إرسال تقييمك");
        //..........................................................................
        print('rating: ${response.rating}, comment: ${response.comment}');
      },
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }
}

//--------------------------------------------------------------------
Future<String> getShopLogo(String shopOwnerId) async {
  String shopLogo = "";
  final shopDoc = await FirebaseFirestore.instance
      .collection('shop_owner')
      .where("id", isEqualTo: shopOwnerId)
      .get();
  if (shopDoc.size > 0) {
    var data = shopDoc.docs.elementAt(0).data() as Map;
    if (data["logo"] != "") {
      shopLogo = data["logo"];
    }
  }
  return shopLogo;
}

//----------------------------------------------------------------------
Future createRatingItem(ratingModel ratingItem) async {
  final ratingDoc = FirebaseFirestore.instance
      .collection('rating')
      .doc("${ratingItem.orderId}");
  final json = ratingItem.toJson();
  await ratingDoc.set(
    json,
  );
}

//------------------------------------------------------------------------
Future<void> showToastMethod(BuildContext context, String textToBeShown) async {
  Fluttertoast.showToast(
    msg: textToBeShown,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 3,
    backgroundColor: Color.fromARGB(255, 26, 96, 91),
    textColor: Colors.white,
    fontSize: 18.0,
  );
}

//=============================================================================================
///////////////////////////////////////////////////////////////////////////////////////////////
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
