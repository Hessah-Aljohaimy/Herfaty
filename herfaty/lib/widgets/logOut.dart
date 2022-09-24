import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

class logOutButton extends StatelessWidget {
  PickedFile? _imageFile;

  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  var uid;

  String? id = '';
  String? email = '';
  String? name = '';
  String? password = '';

  final CollectionReference customers =
      FirebaseFirestore.instance.collection('customeres');

  get kPrimaryColor => null;

  //Lists
  final titles = [
    'اسم المشتري',
    'البريد الإلكتروني',
    'كلمة المرور',
  ];
  final icons = [Icons.person, Icons.email_rounded, Icons.lock];

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("الإعدادات", style: TextStyle(color: kPrimaryColor)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.logout, color: kPrimaryColor),
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
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      "معلومات المشتري",
                      style: TextStyle(
                          color: Color.fromARGB(255, 79, 75, 75),
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 79, 75, 75),
                      size: 28.0,
                    )
                  ],
                ),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: titles.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                titles[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: kPrimaryColor),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('this is a test '),
                            ],
                          ),
                          leading: Icon(
                            icons[index],
                            color: Color.fromARGB(248, 198, 149, 100),
                          ),
                        ),
                      );
                    }),
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
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) {
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
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pushReplacement(MaterialPageRoute(
                                                builder: (context) =>
                                                    new Welcome()));
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
        ));
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage("assets/images/Circular_Logo.png") as ImageProvider
              : FileImage(File(_imageFile!.path)),

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
}

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
