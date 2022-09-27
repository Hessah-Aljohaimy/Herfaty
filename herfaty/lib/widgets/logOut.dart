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

    return Scaffold(
      appBar: AppBar(
        title: Text("حسابي",
            style: TextStyle(color: Color.fromARGB(255, 81, 144, 142))),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Color.fromARGB(255, 39, 141, 134),
        elevation: 2,
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

//////////////////////////////////SIZED BOX////////////////////////////

      // body: SizedBox(
      //   height: 600,
      //   child: SingleChildScrollView(
      //     reverse: true,
      //     child: Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               Text(
      //                 "معلومات المشتري",
      //                 style: TextStyle(
      //                     color: Color.fromARGB(255, 81, 144, 142),
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 22),
      //               ),
      //               Icon(
      //                 Icons.person,
      //                 color: Color.fromARGB(255, 81, 144, 142),
      //                 size: 28.0,
      //               )
      //             ],
      //           ),
      //           ListView.builder(
      //               scrollDirection: Axis.vertical,
      //               shrinkWrap: true,
      //               itemCount: titles.length,
      //               itemBuilder: (context, index) {
      //                 return Card(
      //                   child: ListTile(
      //                     title: SizedBox(
      //                       height: 60,
      //                       child: SingleChildScrollView(
      //                         reverse: true,
      //                         child: Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             Text(
      //                               titles[index],
      //                               style: TextStyle(
      //                                   fontWeight: FontWeight.w800,
      //                                   fontSize: 20,
      //                                   color: kPrimaryColor),
      //                             ),
      //                             const SizedBox(
      //                               height: 5,
      //                             ),
      //                             if (titles[index] == 'اسم المشتري')
      //                               Text('مها خالد'),
      //                             // Text('اختبار اسم المشتري' +
      //                             //     snapshot.data!.docs[index]['name']
      //                             //         .toString()),
      //                             if (titles[index] == 'البريد الإلكتروني')
      //                               Text('mahaKahlid1@gmail.com'),
      //                             // Text(index.toString()),
      //                             // Text('اختبار االبريد الالكتروني' +
      //                             //     snapshot.data!.docs[index]['email']
      //                             //         .toString()),
      //                             if (titles[index] == 'كلمة المرور')
      //                               Text('******'),
      //                             // int passwordlen =snapshot.data!.docs[index]['password'].lenght();
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                     leading: Icon(
      //                       icons[index],
      //                       color: Color.fromARGB(255, 79, 75, 75),
      //                     ),
      //                   ),
      //                 );
      //               }),
      //           Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //                 ElevatedButton(
      //                   onPressed: () async {
      //                     Navigator.pushReplacement(context, MaterialPageRoute(
      //                         builder: (BuildContext context) {
      //                       return CustomerEditProfile();
      //                     }));
      //                   },
      //                   style: ButtonStyle(
      //                     backgroundColor:
      //                         MaterialStateProperty.all(Color(0xff51908E)),
      //                     padding: MaterialStateProperty.all(
      //                         EdgeInsets.symmetric(
      //                             horizontal: 50, vertical: 13)),
      //                     shape: MaterialStateProperty.all(
      //                         RoundedRectangleBorder(
      //                             borderRadius: BorderRadius.circular(27))),
      //                   ),
      //                   child: const Text(
      //                     " تعديل البيانات",
      //                     style: TextStyle(
      //                         fontSize: 14,
      //                         fontFamily: "Tajawal",
      //                         fontWeight: FontWeight.bold),
      //                   ),
      //                 ),
      //                 // const SizedBox(
      //                 //   width: 10,
      //                 // ),
      //                 ElevatedButton(
      //                   onPressed: () async {
      //                     showDialog(
      //                         context: context,
      //                         builder: (BuildContext context) {
      //                           return AlertDialog(
      //                             title: Text("تنبيه"),
      //                             content: Text('سيتم حذف الحساب نهائيا'),
      //                             actions: <Widget>[
      //                               TextButton(
      //                                 child: Text("حذف",
      //                                     style: TextStyle(color: Colors.red)),
      //                                 onPressed: () {
      //                                   //The logic of deleting an account

      //                                   //Navigator.of(context).pop();
      //                                   FirebaseAuth.instance.signOut();
      //                                   Navigator.of(context,
      //                                           rootNavigator: true)
      //                                       .pushReplacement(MaterialPageRoute(
      //                                           builder: (context) =>
      //                                               new Welcome()));
      //                                 },
      //                               ),
      //                               TextButton(
      //                                 child: Text("تراجع"),
      //                                 onPressed: () {
      //                                   Navigator.of(context).pop();
      //                                 },
      //                               )
      //                             ],
      //                           );
      //                         });

      //                     /*Navigator.pushReplacement(context,
      //                                   MaterialPageRoute(builder: (BuildContext context) {
      //                                 return Welcome();
      //                               }));*/
      //                   },
      //                   style: ButtonStyle(
      //                     backgroundColor: MaterialStateProperty.all(
      //                         Color.fromARGB(255, 221, 112, 112)),
      //                     padding: MaterialStateProperty.all(
      //                         EdgeInsets.symmetric(
      //                             horizontal: 50, vertical: 13)),
      //                     shape: MaterialStateProperty.all(
      //                         RoundedRectangleBorder(
      //                             borderRadius: BorderRadius.circular(27))),
      //                   ),
      //                   child: Text(
      //                     "حذف الحساب",
      //                     style: TextStyle(
      //                         fontSize: 14,
      //                         fontFamily: "Tajawal",
      //                         fontWeight: FontWeight.bold),
      //                   ),
      //                 ),
      //               ]),
      //           Align(
      //             alignment: Alignment.bottomLeft,
      //             child: Image.asset(
      //               "assets/images/down.png",
      //               width: 200,
      //             ),
      //           ),
      //         ]),
      //   ),
      // ),

      // } else {
      //   return Center(
      //     child: const CircularProgressIndicator(),
      //   );
      // }
      //       }),
      // );

      // body: StreamBuilder(
      //   stream: FirebaseFirestore.instance
      //       .collection('customers')
      //       .where("uid", isEqualTo: currentUser.currentUser!.uid)
      //       .snapshots(),
      //   builder: ((context, snapshot) {
      //     if (snapshot.hasError) {
      //       return Center(child:Text('!هناك خطأ في استرجاع البيانات${snapshot.hasError}'),);
      //     }else if(!snapshot.hasData){
      //
      //    //            return Center(child: Text('!لا توجد معلومات الحرفي'));

      //
      //
      // }
      //
      //
      // else if (snapshot.hasData) {
      //       final customer = snapshot.data;

      //       return customer == null
      //           ? const Center(child: Text('!لا توجد معلومات الحرفي'))
      //           :
      // body: SizedBox(
      //   height: 600,
      //   child: SingleChildScrollView(
      //     reverse: true,
      //     child: Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               Text(
      //                 "معلومات المشتري",
      //                 style: TextStyle(
      //                     color: Color.fromARGB(255, 81, 144, 142),
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 22),
      //               ),
      //               Icon(
      //                 Icons.person,
      //                 color: Color.fromARGB(255, 81, 144, 142),
      //                 size: 28.0,
      //               )
      //             ],
      //           ),
      //           ListView.builder(
      //               scrollDirection: Axis.vertical,
      //               shrinkWrap: true,
      //               itemCount: titles.length,
      //               itemBuilder: (context, index) {
      //                 return Card(
      //                   child: ListTile(
      //                     title: SizedBox(
      //                       height: 60,
      //                       child: SingleChildScrollView(
      //                         reverse: true,
      //                         child: Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             Text(
      //                               titles[index],
      //                               style: TextStyle(
      //                                   fontWeight: FontWeight.w800,
      //                                   fontSize: 20,
      //                                   color: kPrimaryColor),
      //                             ),
      //                             const SizedBox(
      //                               height: 5,
      //                             ),
      //                             if (titles[index] == 'اسم المشتري')
      //                               Text('مشتري'),
      //                             // Text('اختبار اسم المشتري' +
      //                             //     snapshot.data!.docs[index]['name']
      //                             //         .toString()),
      //                             if (titles[index] == 'البريد الإلكتروني')
      //                               Text('بريد'),
      //                             // Text(index.toString()),
      //                             // Text('اختبار االبريد الالكتروني' +
      //                             //     snapshot.data!.docs[index]['email']
      //                             //         .toString()),
      //                             if (titles[index] == 'كلمة المرور')
      //                               Text('******'),
      //                             // int passwordlen =snapshot.data!.docs[index]['password'].lenght();
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                     leading: Icon(
      //                       icons[index],
      //                       color: Color.fromARGB(255, 79, 75, 75),
      //                     ),
      //                   ),
      //                 );
      //               }),
      //           Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //                 ElevatedButton(
      //                   onPressed: () async {
      //                     Navigator.pushReplacement(context, MaterialPageRoute(
      //                         builder: (BuildContext context) {
      //                       return CustomerEditProfile();
      //                     }));
      //                   },
      //                   style: ButtonStyle(
      //                     backgroundColor:
      //                         MaterialStateProperty.all(Color(0xff51908E)),
      //                     padding: MaterialStateProperty.all(
      //                         EdgeInsets.symmetric(
      //                             horizontal: 50, vertical: 13)),
      //                     shape: MaterialStateProperty.all(
      //                         RoundedRectangleBorder(
      //                             borderRadius: BorderRadius.circular(27))),
      //                   ),
      //                   child: const Text(
      //                     " تعديل البيانات",
      //                     style: TextStyle(
      //                         fontSize: 14,
      //                         fontFamily: "Tajawal",
      //                         fontWeight: FontWeight.bold),
      //                   ),
      //                 ),
      //                 // const SizedBox(
      //                 //   width: 10,
      //                 // ),
      //                 ElevatedButton(
      //                   onPressed: () async {
      //                     showDialog(
      //                         context: context,
      //                         builder: (BuildContext context) {
      //                           return AlertDialog(
      //                             title: Text("تنبيه"),
      //                             content: Text('سيتم حذف الحساب نهائيا'),
      //                             actions: <Widget>[
      //                               TextButton(
      //                                 child: Text("حذف",
      //                                     style: TextStyle(color: Colors.red)),
      //                                 onPressed: () {
      //                                   //The logic of deleting an account

      //                                   //Navigator.of(context).pop();
      //                                   FirebaseAuth.instance.signOut();
      //                                   Navigator.of(context,
      //                                           rootNavigator: true)
      //                                       .pushReplacement(MaterialPageRoute(
      //                                           builder: (context) =>
      //                                               new Welcome()));
      //                                 },
      //                               ),
      //                               TextButton(
      //                                 child: Text("تراجع"),
      //                                 onPressed: () {
      //                                   Navigator.of(context).pop();
      //                                 },
      //                               )
      //                             ],
      //                           );
      //                         });

      //                     /*Navigator.pushReplacement(context,
      //                                   MaterialPageRoute(builder: (BuildContext context) {
      //                                 return Welcome();
      //                               }));*/
      //                   },
      //                   style: ButtonStyle(
      //                     backgroundColor: MaterialStateProperty.all(
      //                         Color.fromARGB(255, 221, 112, 112)),
      //                     padding: MaterialStateProperty.all(
      //                         EdgeInsets.symmetric(
      //                             horizontal: 50, vertical: 13)),
      //                     shape: MaterialStateProperty.all(
      //                         RoundedRectangleBorder(
      //                             borderRadius: BorderRadius.circular(27))),
      //                   ),
      //                   child: Text(
      //                     "حذف الحساب",
      //                     style: TextStyle(
      //                         fontSize: 14,
      //                         fontFamily: "Tajawal",
      //                         fontWeight: FontWeight.bold),
      //                   ),
      //                 ),
      //               ]),
      //           Align(
      //             alignment: Alignment.bottomLeft,
      //             child: Image.asset(
      //               "assets/images/footbg.png",
      //               width: 200,
      //             ),
      //           ),
      //         ]),
      //   ),
      // ),
      // );
    );
  }

  //????????????????OLD CODE????????????????????????
  //),
  // )

//         body: SingleChildScrollView(
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Row(
//                   children: [
//                     Text(
//                       "معلومات المشتري",
//                       style: TextStyle(
//                           color: Color.fromARGB(255, 79, 75, 75),
//                           fontWeight: FontWeight.bold,
//                           fontSize: 22),
//                     ),
//                     Icon(
//                       Icons.person,
//                       color: Color.fromARGB(255, 79, 75, 75),
//                       size: 28.0,
//                     )
//                   ],
//                 ),
//                 ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     shrinkWrap: true,
//                     itemCount: titles.length,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         child: ListTile(
//                           title: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 titles[index],
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w800,
//                                     fontSize: 20,
//                                     color: kPrimaryColor),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Text('this is a test '),
//                             ],
//                           ),
//                           leading: Icon(
//                             icons[index],
//                             color: Color.fromARGB(248, 198, 149, 100),
//                           ),
//                         ),
//                       );
//                     }),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Row(
//                   children: [
//                     SizedBox(
//                       width: 50,
//                     ),
//                     FloatingActionButton.extended(
//                         heroTag: "btn1",
//                         label: Text(
//                           'تعديل البيانات',
//                         ),
//                         onPressed: () async {
//                           Navigator.pushReplacement(context, MaterialPageRoute(
//                               builder: (BuildContext context) {
//                             return CustomerEditProfile();
//                           }));
//                         },
//                         backgroundColor: kPrimaryColor),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     FloatingActionButton.extended(
//                         heroTag: "btn1",
//                         label: Text(
//                           'حذف الحساب',
//                         ),
//                         onPressed: () async {
//                           showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text("تنبيه"),
//                                   content: Text('سيتم حذف الحساب نهائيا'),
//                                   actions: <Widget>[
//                                     TextButton(
//                                       child: Text("حذف",
//                                           style: TextStyle(color: Colors.red)),
//                                       onPressed: () {
// //The logic of deleting an account

//                                         //Navigator.of(context).pop();
//                                         FirebaseAuth.instance.signOut();
//                                         Navigator.of(context,
//                                                 rootNavigator: true)
//                                             .pushReplacement(MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     new Welcome()));
//                                       },
//                                     ),
//                                     TextButton(
//                                       child: Text("تراجع"),
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                     )
//                                   ],
//                                 );
//                               });

//                           /*Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (BuildContext context) {
//               return Welcome();
//             }));*/
//                         },
//                         backgroundColor: Color.fromARGB(255, 221, 112, 112)),
//                   ],
//                 ),
//               ]),
//         ));
  //   );
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
    // name = documentSnapshot['quantity'];
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

  // DocumentSnapshot documentSnapshot;
  // await FirebaseFirestore.instance
  //     .collection('customers')
  //     .doc(DocId)
  //     .get();
  // we get the document here
  // name = documentSnapshot['quantity'];

  // readDocument(uid);
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
  return SingleChildScrollView(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 600,
            height: 100,
            child: Image.asset(
              'assets/images/customerBG.png',
              fit: BoxFit.cover,
            ),
          ),
          Text(
            "معلومات المشتري",
            style: TextStyle(
                color: Color.fromARGB(255, 26, 96, 91),
                fontWeight: FontWeight.bold,
                fontSize: 22),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return Card(
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
                            height: 5,
                          ),
                          if (titles[index] == 'اسم المشتري')
                            Text('${customer.name}'),

                          if (titles[index] == 'البريد الإلكتروني')
                            Text('${customer.email}'),

                          if (titles[index] == 'كلمة المرور')
                            Text(passwordStar),
                        ],
                      ),
                      leading: Icon(
                        icons[index],
                        color: Color.fromARGB(255, 39, 141, 134),
                      ),
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
                width: 50,
              ),
              FloatingActionButton.extended(
                  heroTag: "btn1",
                  label: Text(
                    'تعديل البيانات',
                  ),
                  onPressed: () async {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return CustomerEditProfile();
                    }));
                  },
                  backgroundColor: kPrimaryColor),
              SizedBox(
                width: 10,
              ),
              FloatingActionButton.extended(
                  heroTag: "btn1",
                  label: Text(
                    'حذف الحساب',
                  ),
                  onPressed: () async {
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
                        });

                    /*Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return Welcome();
            }));*/
                  },
                  backgroundColor: Color.fromARGB(255, 221, 112, 112)),
            ],
          ),
        ]),
  );
}

Widget imageProfile() {
  return Center(
    child: Stack(children: <Widget>[
      CircleAvatar(
        radius: 80.0,
        // backgroundImage: _imageFile == null
        //     ? AssetImage("assets/images/Circular_Logo.png") as ImageProvider
        //     : FileImage(File(_imageFile!.path)),

        // _imageFile.path
        //
        // ?  as ImageProvider
        // :
      ),
      // Positioned(
      //   bottom: 20.0,
      //   right: 20.0,
      //   child: InkWell(
      //     onTap: () {
      //       showModalBottomSheet(
      //         context: context,
      //         builder: ((builder) => bottomSheet()),
      //       );
      //     },
      //     child: Icon(
      //       Icons.camera_alt,
      //       color: Colors.teal,
      //       size: 28.0,
      //     ),
      //   ),
      // ),
    ]),
  );
}

Widget bottomSheet() {
  return Container(
      // height: 100.0,
      // width: MediaQuery.of(context).size.width,
      // margin: EdgeInsets.symmetric(
      //   horizontal: 20,
      //   vertical: 20,
      // ),
      // child: Column(
      //   children: <Widget>[
      //     Text(
      //       "اختر صورة",
      //       style: TextStyle(
      //         fontSize: 20.0,
      //       ),
      //     ),
      //     Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      //       TextButton.icon(
      //         icon: Icon(Icons.camera),
      //         onPressed: () async {
      //           // Capture a photo
      //           takePhoto(ImageSource.camera);
      //           // final XFile? photo =
      //           //     await _picker.pickImage(source: ImageSource.camera);
      //           // try {
      //           //   final file = File(photo!.path);
      //           //   uploadImageToFirebaseStorage(file);
      //           // } catch (e) {
      //           //   print('error');
      //           // }

      //           Navigator.of(context).pop();
      //         },
      //         label: Text("الكاميرا"),
      //       ),
      //       TextButton.icon(
      //         icon: Icon(Icons.image),
      //         onPressed: () async {
      //           takePhoto(ImageSource.gallery);
      //           // Pick an image
      //           // final XFile? photo =
      //           //     await _picker.pickImage(source: ImageSource.gallery);
      //           // try {
      //           //   final file = File(photo!.path);
      //           //   uploadImageToFirebaseStorage(file);
      //           // } catch (e) {
      //           //   print('error');
      //           // }

      //           Navigator.of(context).pop();
      //         },
      //         label: Text("الصور"),
      //       ),
      //     ])
      //   ],
      // ),
      );
}

//logo
// void takePhoto(ImageSource source) async {
//   final pickedFile = await _picker.getImage(
//     source: source,
//   );
//   try {
//     final file = File(_imageFile!.path);
//     uploadImageToFirebaseStorage(file);
//   } catch (e) {
//     print('error');
//   }
//   // setState(() {
//   try {
//     _imageFile = pickedFile!;
//     Fluttertoast.showToast(
//       msg: 'تمت تعديل الصورة بنجاح',
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       timeInSecForIosWeb: 3,
//       backgroundColor: Color.fromARGB(255, 26, 96, 91),
//       textColor: Colors.white,
//       fontSize: 18.0,
//     );
//     imageProfile();
//   } catch (e) {
//     Fluttertoast.showToast(
//       msg: 'هناك مشكلة أعد ادخال الصوره مجددا',
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       timeInSecForIosWeb: 3,
//       backgroundColor: Colors.white,
//       textColor: Colors.red,
//       fontSize: 18.0,
//     );
//   }
// });
//}

//   void uploadImageToFirebaseStorage(File file) async {
//     // Create a reference to 'images/mountains.jpg'
//     final imagesRef = storageRef
//         .child("shopOwnerLogos/${DateTime.now().millisecondsSinceEpoch}.png");
//     await imagesRef.putFile(file);

//     uploadImageUrl = await imagesRef.getDownloadURL();
//     //setState(() {});
//     print("uploaded:" + uploadImageUrl);
//   }
// }

// class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   const DefaultAppBar({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   @override
//   Size get preferredSize => Size.fromHeight(56.0);
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(title, style: TextStyle(color: kPrimaryColor)),
//       centerTitle: true,
//       backgroundColor: Colors.white,
//       elevation: 0,
//       automaticallyImplyLeading: false,
//       iconTheme: IconThemeData(color: kPrimaryColor),
//     );
//   }
