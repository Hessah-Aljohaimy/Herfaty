import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:herfaty/cart/cart.dart';
import 'package:herfaty/firestore/firestore.dart';
import 'package:herfaty/main.dart';
import 'package:herfaty/models/cartModal.dart';
import 'package:herfaty/pages/login.dart';
import 'package:herfaty/pages/welcome.dart';
import 'package:herfaty/profile%20screens/CustomerEditProfile.dart';
import 'package:herfaty/widgets/customerSettings.dart';

import '../constants/color.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/AddProduct.dart';
import 'package:herfaty/pages/signupHerafy.dart';
import 'package:image_picker/image_picker.dart';

import '../pages/signupCustomer.dart';
import 'ownerSettings.dart';
//Define snapshot

class logOutButton extends StatefulWidget {
  @override
  State<logOutButton> createState() => _logOutButtonState();
}

class _logOutButtonState extends State<logOutButton> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String getUD() {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final uid = user!.uid;

      return uid;
    } catch (e) {
      return 'null';
    }
  }

  get kPrimaryColor => null;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    String uid = getUD();

    DocumentReference customersRef =
        FirebaseFirestore.instance.collection('customeres').doc(uid);
/*  actions: [
        IconButton(
          icon: Icon(Icons.logout, color: Color.fromARGB(255, 81, 144, 142)),
          onPressed: () async {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("تنبيه"),
                    content: Text('سيتم تسجيل خروجك من الحساب'),
                    actions: <Widget>[
                      TextButton(
                        child: Text("تسجيل خروج",
                            style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          //Navigator.of(context).pop();
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => new login()));
                        },
                      ),
                      TextButton(
                        child: Text("تراجع"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });

            /*Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
              return Welcome();
            }));*/
          },
        ),
        ],*/
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("حسابي",
            style: TextStyle(
              color: Color.fromARGB(255, 81, 144, 142),
              fontFamily: "Tajawal",
            )),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Color.fromARGB(255, 39, 141, 134),
        elevation: 3,
        // leading: IconButton(
        //   icon: Icon(Icons.logout, color: Color.fromARGB(255, 81, 144, 142)),
        //   onPressed: () async {
        //     showDialog(
        //         context: context,
        //         builder: (BuildContext context) {
        //           return AlertDialog(
        //             title: Text("تنبيه"),
        //             content: Text('سيتم تسجيل خروجك من الحساب'),
        //             actions: <Widget>[
        //               TextButton(
        //                 child: Text("تسجيل خروج",
        //                     style: TextStyle(color: Colors.red)),
        //                 onPressed: () {
        //                   // FirebaseAuth.instance.signOut();
        //                   // Navigator.of(context).pushNamedAndRemoveUntil(
        //                   //     "/", (Route<dynamic> route) => false);
        //                   Navigator.of(context, rootNavigator: true)
        //                       .pushReplacement(MaterialPageRoute(
        //                           builder: (context) => new login()));
        //                 },
        //               ),
        //               TextButton(
        //                 child: Text("تراجع"),
        //                 onPressed: () {
        //                   Navigator.of(context).pop();
        //                 },
        //               )
        //             ],
        //           );
        //         });

        //     /*Navigator.pushReplacement(context,
        //             MaterialPageRoute(builder: (BuildContext context) {
        //       return Welcome();
        //     }));*/
        //   },
        // ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => CustomerSettings()));
            }, // Image tapped
            child: Image.asset(
              'assets/images/points_trophies/icons8-settings-64.png',
              fit: BoxFit.contain, // Fixes border issues
              width: 35.0,
              height: 35.0,
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) => CustomerSettings()));
          //   },
          //   icon: Icon(CupertinoIcons.settings,
          //       color: Color.fromARGB(255, 81, 144, 142)),
          // ),
        ],
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: kPrimaryColor),
      ),
      body: FutureBuilder(
          future: readUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              //print('11111111111111111111111111111111111111');
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              print('333333333333333333333333333333333333333333333');
              return Center(
                  child: Text(
                      '!هناك خطأ في استرجاع البيانات${snapshot.hasError}'));
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                //print('4444444444444444444444444444444444444444');

                final customer = snapshot.data;
                return customer == null
                    ? const Center(child: Text('!لا توجد معلومات المشتري '))
                    : buildCustomer(customer, context);
              }
            }
            if (!snapshot.hasData) {
              //print('2222222222222222222222222222222222222222222222');
              return Center(child: Text('! خطأ في عرض البيانات '));
            } else {
              return Center(child: Text("! هناك مشكلة ما حاول مجددا"));
            }
          }),
    );
  }

//////////////////////////////////SARAHS////////////////
  Future readDocument(String id) async {
    String DocId = id;
    DocumentSnapshot documentSnapshot;
    await FirebaseFirestore.instance
        .collection('customers')
        .doc(DocId)
        .get()
        .then((value) {
      documentSnapshot = value; // we get the document here
    });

    //now you can access the document field value
  }

/////////////////////////////

  Future<Customer?> readUser() async {
    try {
      //print("BBBBBBBBBBEGIningggggggggggggggggggggggg ");
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final uid = user!.uid;
      String DocId = uid;

      print(uid);

      final docCustomer = await FirebaseFirestore.instance
          .collection('customers')
          .doc(uid)
          .get();
      print('after the refrence');

      if (docCustomer.exists) {
        //print("SSSSSSSSSSSSSSSSSSNNNNNNNNNNNNNNNNAAAAAAAAAAAAAAAAAAPPPPPPPPPPP");
        return Customer.fromJson(docCustomer.data()!);
      }
    } catch (e) {
      return null;
    }
  }

  Widget buildCustomer(Customer customer, BuildContext context) {
    //Lists
    final titles = [
      'اسم المشتري',
      'البريد الإلكتروني',
      'كلمة المرور',
    ];
    final icons = [Icons.person, Icons.email_rounded, Icons.lock];
    int passlength = customer.password.length;
    String passwordStar = '';

    for (int i = 0; i < passlength; i++) {
      passwordStar = passwordStar + '*';
    }
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return SingleChildScrollView(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
              Widget>[
        SizedBox(
          width: 630,
          height: 100,
          child: Image.asset(
            'assets/images/customerBG.png',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 60,
        ),
        // Text(
        //   "بيانات المشتري",
        //   style: TextStyle(
        //     color: Color.fromARGB(255, 26, 96, 91),
        //     fontWeight: FontWeight.bold,
        //     fontSize: 24,
        //     fontFamily: "Tajawal",
        //   ),
        // ),
        Container(
          height: 260,
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(15),
          // decoration: BoxDecoration(
          //   color: Color.fromARGB(255, 255, 255, 255),
          //   borderRadius: BorderRadius.all(Radius.circular(20)),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.grey.withOpacity(0.5),
          //       spreadRadius: 2,
          //       blurRadius: 7,
          //       offset: Offset(0, 3), // changes position of shadow
          //     ),
          //   ],
          // ),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.6),
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   titles[index],
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.w800,
                        //       fontSize: 20,
                        //       color: kPrimaryColor),
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "معلومات المشتري",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 26, 96, 91),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  fontFamily: "Tajawal",
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 50,
                              top: 50,
                              child: Image.asset(
                                "assets/images/points_trophies/icons8-customer-64.png",
                                width: 35,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),

                        Row(
                          children: [
                            Text(
                              'اسم المشتري ',
                              style: TextStyle(
                                color: Color.fromARGB(255, 26, 96, 91),
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                                fontFamily: "Tajawal",
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${customer.name}',
                              style: TextStyle(
                                fontSize: 19,
                                fontFamily: "Tajawal",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Row(
                          children: [
                            Text(
                              'البريد الإلكتروني ',
                              style: TextStyle(
                                color: Color.fromARGB(255, 26, 96, 91),
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                                fontFamily: "Tajawal",
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${customer.email}',
                              style: TextStyle(
                                fontSize: 19,
                                fontFamily: "Tajawal",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'كلمة المرور',
                        //       style: TextStyle(
                        //         color: Color.fromARGB(255, 26, 96, 91),
                        //         fontWeight: FontWeight.w800,
                        //         fontSize: 17,
                        //         fontFamily: "Tajawal",
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.only(top: 10),
                        //       child: Text(
                        //         passwordStar,
                        //         style: TextStyle(
                        //           fontSize: 19,
                        //           fontFamily: "Tajawal",
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    // leading: Icon(
                    //   icons[index],
                    //   color: Color.fromARGB(255, 39, 141, 134),
                    // ),
                  ),
                );
              }),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            // SizedBox(
            //   width: 26,
            // ),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // openPasswordDialog(context);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomerEditProfile(
                                    customer.name,
                                    customer.email,
                                    customer.password,
                                    customer.id,
                                  )),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff51908E)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 35, vertical: 13)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27))),
                      ),
                      child: Text(
                        " تعديل الحساب",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Tajawal",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    ElevatedButton(
                      onPressed: () async {
// Diolog to enter the password

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              title: Center(
                                child: Text(
                                  "تنبيه",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 221, 112, 112),
                                    fontFamily: "Tajawal",
                                  ),
                                ),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(
                                    child: Container(
                                      width: 280,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        fit: BoxFit.scaleDown,
                                        image: AssetImage(
                                            'assets/images/delete.png'),
                                      )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                      child: Text(
                                    'سيتم حذف الحساب نهائيا',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromARGB(255, 26, 96, 91),
                                      fontFamily: "Tajawal",
                                    ),
                                  )),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("حذف",
                                      style: TextStyle(color: Colors.red)),
                                  onPressed: () async {
                                    final FirebaseAuth auth =
                                        FirebaseAuth.instance;
                                    final User? u = auth.currentUser;
                                    final uid = u!.uid;

                                    String email = customer.email;
                                    String password = customer.password;

// Create a credential
                                    AuthCredential credential =
                                        EmailAuthProvider.credential(
                                            email: email, password: password);

// Reauthenticate
                                    await FirebaseAuth.instance.currentUser!
                                        .reauthenticateWithCredential(
                                            credential);
//The logic of delet
//
//
//
                                    FirebaseFirestore.instance
                                        .collection('cart')
                                        .get()
                                        .then((snapshot) {
                                      List<DocumentSnapshot> allDocs =
                                          snapshot.docs;

                                      List<DocumentSnapshot> filteredDocs =
                                          allDocs
                                              .where((document) =>
                                                  document['customerId'] == uid)
                                              .toList();

                                      for (DocumentSnapshot ds
                                          in filteredDocs) {
                                        FirebaseFirestore.instance
                                            .collection('cart')
                                            .doc(ds.id)
                                            .delete();
                                      }
                                    });

                                    FirebaseFirestore.instance
                                        .collection('wishList')
                                        .get()
                                        .then((snapshot) {
                                      List<DocumentSnapshot> allDocs =
                                          snapshot.docs;

                                      List<DocumentSnapshot> filteredDocs =
                                          allDocs
                                              .where((document) =>
                                                  document['customerId'] == uid)
                                              .toList();

                                      for (DocumentSnapshot ds
                                          in filteredDocs) {
                                        FirebaseFirestore.instance
                                            .collection('wishList')
                                            .doc(ds.id)
                                            .delete();
                                      }
                                    });

                                    // for (var doc in )
//ing an account

                                    //   List<DocumentSnapshot> filteredDocs =
                                    //       allDocs
                                    //           .where((document) =>
                                    //               document['customerId'] == uid)
                                    //           .toList();
                                    //   for (DocumentSnapshot ds
                                    //       in filteredDocs) {
                                    //     ds.reference.delete();
                                    //   }
                                    // });

                                    // await user?.delete();
                                    // FirebaseAuth.instance.currentUser
                                    //     ?.delete();

//All the logics for deleting a profile for shop owner

                                    var user = await _getFirebaseUser();

                                    await user?.delete();

                                    final docCus = FirebaseFirestore.instance
                                        .collection('customers')
                                        .doc(uid);
                                    docCus.delete();

                                    // final CustomerCart = FirebaseFirestore
                                    //     .instance
                                    //     .collection('orders')
                                    //     .where("customerId", isEqualTo: uid)
                                    //     .snapshots().map((snapshot) => snapshot.docs.map((doc) => CartModal.fromJson(doc.data()))).toList();

                                    //Navigator.of(context).pop();
                                    // readCarts();

//1 strem builder
// StreamBuilder<List<CartModal>>(stream: ,builder: ,);

                                    FirebaseAuth.instance.signOut();
                                    Navigator.of(context, rootNavigator: true)
                                        .pushReplacement(MaterialPageRoute(
                                            builder: (context) => new login()));
                                  },
                                ),
                                TextButton(
                                  child: Text("تراجع"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 221, 112, 112)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 35, vertical: 13)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27))),
                      ),
                      child: Text(
                        "حذف الحساب",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Tajawal",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ]),
    );
  }

  // Stream<List<Iterable<CartModal>>> readCarts() {
  Future<User?> _getFirebaseUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}
