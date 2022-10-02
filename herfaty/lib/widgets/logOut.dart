import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herfaty/firestore/firestore.dart';
import 'package:herfaty/main.dart';
import 'package:herfaty/pages/login.dart';
import 'package:herfaty/pages/welcome.dart';
import 'package:herfaty/profile%20screens/CustomerEditProfile.dart';

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
//Define snapshot

class logOutButton extends StatelessWidget {
  PickedFile? _imageFile;

  final FirebaseAuth auth = FirebaseAuth.instance;

  String getUD() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    return uid;
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
      appBar: AppBar(
        title: Text("حسابي",
            style: TextStyle(
              color: Color.fromARGB(255, 81, 144, 142),
              fontFamily: "Tajawal",
            )),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Color.fromARGB(255, 39, 141, 134),
        elevation: 0,
        leading: IconButton(
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
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/login", (Route<dynamic> route) => false);
                          // Navigator.of(context, rootNavigator: true)
                          //     .pushReplacement(MaterialPageRoute(
                          //         builder: (context) => new login()));
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
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: kPrimaryColor),
      ),
      body: FutureBuilder(
          future: readUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('11111111111111111111111111111111111111');
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
                print('4444444444444444444444444444444444444444');

                final customer = snapshot.data;
                return customer == null
                    ? const Center(child: Text('!لا توجد معلومات المشتري '))
                    : buildCustomer(customer, context);
              }
            }
            if (!snapshot.hasData) {
              print('2222222222222222222222222222222222222222222222');
              return Center(child: Text('! خطأ في عرض البيانات '));
            } else {
              return Center(child: Text("! هناك مشكلة ما حاول مجددا"));
            }
          }),
    );
  }
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
  print("BBBBBBBBBBEGIningggggggggggggggggggggggg ");
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user!.uid;
  String DocId = uid;

  print(uid);

  final docCustomer =
      await FirebaseFirestore.instance.collection('customers').doc(uid).get();
  print('after the refrence');

  if (docCustomer.exists) {
    print("SSSSSSSSSSSSSSSSSSNNNNNNNNNNNNNNNNAAAAAAAAAAAAAAAAAAPPPPPPPPPPP");
    return Customer.fromJson(docCustomer.data()!);
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
    child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
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
          Text(
            "بيانات المشتري",
            style: TextStyle(
              color: Color.fromARGB(255, 26, 96, 91),
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: "Tajawal",
            ),
          ),
          Container(
            height: 230,
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
                itemCount: titles.length,
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
                            height: 20,
                          ),
                          if (titles[index] == 'اسم المشتري')
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

                          if (titles[index] == 'البريد الإلكتروني')
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

                          if (titles[index] == 'كلمة المرور')
                            Row(
                              children: [
                                Text(
                                  'كلمة المرور',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 26, 96, 91),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17,
                                    fontFamily: "Tajawal",
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    passwordStar,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontFamily: "Tajawal",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
              SizedBox(
                width: 26,
              ),
              Expanded(
                child: Row(children: [
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
                      " تعديل البيانات",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Tajawal",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
// Diolog to enter the password

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("تنبيه"),
                            content: Text('سيتم حذف الحساب نهائيا'),
                            actions: <Widget>[
                              TextButton(
                                child: Text("حذف",
                                    style: TextStyle(color: Colors.red)),
                                onPressed: () {
//The logic of deleting an account

                                  final docCus = FirebaseFirestore.instance
                                      .collection('customers')
                                      .doc(uid);
                                  docCus.delete();

                                  //Navigator.of(context).pop();
                                  FirebaseAuth.instance.signOut();
                                  Navigator.of(context, rootNavigator: true)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) => new Welcome()));
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
