// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/AddProduct.dart';
import 'package:herfaty/constants/color.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/ExpandedWidget.dart';
import 'OrderModel.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _order();
}

class _order extends State<Details> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  var uid;

  _order() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
    print(uid);
  }

  final CollectionReference order =
      FirebaseFirestore.instance.collection('orders');
  // late ShopOwner shopOwner;
  PickedFile? _imageFile;

  final ImagePicker _picker = ImagePicker();

  String customerId = "";
  String shopOwnerId = "";
  String docId = "";
  String location = "";
  num total = 0.0;
  String shopName = "";
  String notification = "notPushed";
  String status = "New order";
  String orderDate = "";
  //Map<String, dynamic> products;

  get kPrimaryColor => null;

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          customerId = snapshot.data()!["customerId"];
          shopOwnerId = snapshot.data()!["shopOwnerId"];
          docId = snapshot.data()!["docId"];
          location = snapshot.data()!["location"];
          total = snapshot.data()!["name"];
          total = snapshot.data()!["password"];
          shopName = snapshot.data()!["shopName"];
          notification = snapshot.data()!["notification"];
          status = snapshot.data()!["status"];
          orderDate = snapshot.data()!["orderDate"];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const title = 'قائمة الطلبات';

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: DefaultAppBar(title: "طلبات متجري"),

        body: SingleChildScrollView(
          child: Container(
            height: 900,
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

                    if (cItems.isEmpty) {
                      return const Center(
                        child: Text(
                          'لا يوجد طلبات',
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
                                  border: Border.all(color: Color(0xFFF1F1F1))),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              //cItems[index].customerId,
                                              "طلب رقم ${index + 1}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontFamily: "Tajawal")),
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
                                  /*ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Color.fromARGB(
                                          255, 81, 144, 142), // background
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OrderList()),
                                      );
                                      //go to order deatils page
                                    },
                                    child: Text(
                                      "تفاصيل الطلب",
                                      style: TextStyle(
                                        fontFamily: "Tajawal",
                                      ),
                                    ),
                                  ),*/
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
  Size get preferredSize => Size.fromHeight(56.0);
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("طلباتي",
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
