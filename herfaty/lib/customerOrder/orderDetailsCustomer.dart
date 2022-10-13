import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/cart/cart.dart';

import '../constants/color.dart';
import '../models/Product1.dart';

class orderDetailsCustomer extends StatefulWidget {
  String date;
  num totalOrder;
  String docID;
  Map products;
  String status;

  orderDetailsCustomer(
      {Key? key,
      required date,
      required totalOrder,
      required docID,
      required products,
      required status})
      : this.date = date,
        this.totalOrder = totalOrder,
        this.docID = docID,
        this.products = products,
        this.status = status,
        super(key: key);

  @override
  _orderDetailsCustomerState createState() => _orderDetailsCustomerState();
}

class _orderDetailsCustomerState extends State<orderDetailsCustomer> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: DefaultAppBarO(title: "تفاصيل الطلب"),
        body: Container(
          height: 700,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/cartBack1.png'),
            fit: BoxFit.cover,
          )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppBarOD(
                    date: widget.date,
                    totalOrder: widget.totalOrder,
                    status: widget.status,
                    docID: widget.docID),
                Body(),
                ProductsD(products: widget.products),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppBarOD extends StatelessWidget {
  String date;
  num totalOrder;
  String status;
  String docID;

  AppBarOD({
    Key? key,
    required date,
    required totalOrder,
    required status,
    required docID,
  })  : this.date = date,
        this.totalOrder = totalOrder,
        this.status = status,
        this.docID = docID,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 15),
      //height: 100,
      width: double.infinity,
      decoration: const BoxDecoration(
        /*borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),*/
        color: kPrimaryColor,
      ),
      child: Center(
        child: Text(
          " تاريخ الطلب: $date \n مجموع الطلب: $totalOrder ريال \n حالة الطلب: $status",

          style: TextStyle(
              //color: Color.fromARGB(255, 81, 144, 142),
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
              fontFamily: "Tajawal"),
          //textDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class ProductsD extends StatelessWidget {
  Map products;
  ProductsD({Key? key, required products})
      : this.products = products,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product1> PItems = [];
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<List<Product1>>(
              stream: readProductD(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('somting wrong \n ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final PItem = snapshot.data!.toList();

                  if (PItems.length != 0) {
                    PItems = [];
                  }

                  for (int i = 0; i < PItem.length; i++) {
                    products.forEach((key, value) {
                      if (PItem[i].id == key) {
                        //if (!PItems.contains(PItem[i]))
                        PItems.add(PItem[i]);
                      }
                    });
                  }

                  print("shoshoshsosho ${PItems.length}");

                  return Container(
                    margin: EdgeInsets.only(top: 1.0, left: 8.0, right: 8.0),
                    padding: EdgeInsets.only(bottom: 5.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      border: Border.all(color: Color(0xff51908E), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(
                        "المُشتريات",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xff51908E),
                            fontFamily: "Tajawal"),
                      ),
                      children: <Widget>[
                        Center(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: PItems.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      top: 8.0, left: 8.0, right: 8.0),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xFFF1F1F1))),
                                  child: Row(
                                    children: [
                                      ProductImage(
                                        size: MediaQuery.of(context).size,
                                        image: PItems[index].image,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(PItems[index].name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 16.0)),
                                              Text(
                                                  " السعر: ${PItems[index].price.toString()}ريال "),
                                              Text(
                                                  "الكمية: ${getQuantity(PItems[index].id)}"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(child: Text("يتم التحميل"));
                }
              })
        ],
      ),
    );
  }

  num getQuantity(id) {
    num v = 0;
    products.forEach((key, value) {
      if (id == key) {
        v = value;
      }
    });
    return v;
  }
}

// Stream to reach collection

Stream<List<Product1>> readProductD() => FirebaseFirestore.instance
    .collection('Products')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Product1.fromJson(doc.data())).toList());

class DefaultAppBarO extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const DefaultAppBarO({
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
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ),
    );
  }
}
