// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:math';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/models/shopOwnerModel.dart';
import 'package:herfaty/pages/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:herfaty/pages/forget_password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herfaty/screens/owner_base_screen.dart';
import 'package:herfaty/models/shopOwnerModel.dart';
import 'package:herfaty/pages/driverPage.dart';



class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _login();
}

class _login extends State<login> {
  final _formKey = GlobalKey<FormState>();

  bool isShopOwner = false;
// final List<shopOwnerModel> shopOwners =[];
//  final FirebaseAuth auth="  ";
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  String OwnerId = '';

  var myList = [];
//get all data in shop owner collection
  Stream<List<shopOwnerModel>> readShopOwner() => FirebaseFirestore.instance
      .collection('shop_owner')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => shopOwnerModel.fromJson(doc.data()))
          .toList());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 90,
                          ),
                          Image.asset(
                            "assets/images/HerfatyLogoCroped.png",
                            width: 180,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "تسجيل الدخول",
                            style: TextStyle(
                                fontSize: 33,
                                fontFamily: "Tajawal",
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 26, 96, 91)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 60),
                            child: reusableTextField("البريد الإلكتروني",
                                Icons.email, false, _emailTextController),
                          ),
                          SizedBox(
                            height: 23,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 60),
                            child: reusableTextField("كلمة المرور", Icons.lock,
                                true, _passwordTextController),
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          StreamBuilder<List<shopOwnerModel>>(
                            stream: readShopOwner(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                return Text(
                                    'Something went wrong! ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                final AllshopOwners = snapshot.data!.toList();

                                for (int i = 0; i < AllshopOwners.length; i++) {
                                  myList.add(AllshopOwners[i].id);
                                }

                                //..................................................................................
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return Text('');
                            },
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  UserCredential userCredentia =
                                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                                              email: _emailTextController.text,
                                              password:
                                                  _passwordTextController.text);
                                  OwnerId = '';
                                  OwnerId = userCredentia.user!.uid;

                                  for (var i = 0; i < myList.length; i++) {
                                    if (myList[i] == OwnerId) {
                                      isShopOwner = true;
                                      break;
                                    }
                                  }



                                  if (isShopOwner) {
                                    isShopOwner = false;
                                    OwnerId = '';
                                    _emailTextController.clear();
                                    _passwordTextController.clear();
                                    Navigator.pushNamed(
                                        context, "/home_screen_owner");

                                    ///home_screen_owner
                                  } else {
                                    OwnerId = '';
                                    _emailTextController.clear();
                                    _passwordTextController.clear();
                                    Navigator.pushNamed(
                                        context, '/home_screen_customer');
                                  }
                                } catch (e, stack) {
                                  Fluttertoast.showToast(
                                    msg:
                                        "البريد الإلكتروني أو كلمة المرور غير صحيحه",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor:
                                        Color.fromARGB(255, 156, 30, 21),
                                    textColor: Colors.white,
                                    fontSize: 18.0,
                                  );
                                  // showDialog(
                                  //     context: context,
                                  //     builder: (BuildContext context) {
                                  //       return AlertDialog(
                                  //         title: Text("خطأ"),
                                  //         content: Text(
                                  //             'البريد الإلكتروني أو كلمة المرور غير صحيح، حاول مجددا'),
                                  //         actions: <Widget>[
                                  //           TextButton(
                                  //             child: Text("حسنا"),
                                  //             onPressed: () {
                                  //               Navigator.of(context).pop();
                                  //             },
                                  //           )
                                  //         ],
                                  //       );
                                  //     });
                                }
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff51908E)),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 90, vertical: 13)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(27))),
                            ),
                            child: Text(
                              "تسجيل الدخول",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Tajawal",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/forget_password");
                                  },
                                  child: Text(
                                    "نسيت كلمة المرور؟",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 53, 47, 244),
                                        fontFamily: "Tajawal",
                                        decoration: TextDecoration.underline),
                                  )),
                              Text(
                                "",
                                style: TextStyle(fontFamily: "Tajawal"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("ليس لديك حساب ؟",
                                  style: TextStyle(fontFamily: "Tajawal")),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/welcomeRegestration");
                                  },
                                  child: Text(
                                    " تسجيل جديد ",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 53, 47, 244),
                                        decoration: TextDecoration.underline,
                                        fontFamily: "Tajawal"),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      child: Image.asset(
                        "assets/images/login_toppp.png",
                        width: 150,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/main_botomm.png",
                        width: 200,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) return 'أدخل البريد الإلكتروني';

  return null;
}
