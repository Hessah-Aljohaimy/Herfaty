import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herfaty/main.dart';
import 'package:herfaty/pages/welcome.dart';

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

  final ImagePicker _picker = ImagePicker();

  String? DOB = '';
  String? email = '';
  String? id = '';
  String? logo = '';
  String? name = '';
  String? password = '';
  String? phone_number = '';
  String? shopdescription = '';
  String? shopname = '';

  // Future _getDataFromDatabase() async {
  //   await FirebaseFirestore.instance
  //       .collection("useres")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then((snapshot) async {
  //     if (snapshot.exists) {
  //       setState(() {
  //         DOB = snapshot.data()!["DOB"];
  //         email = snapshot.data()!["email"];
  //         id = snapshot.data()!["id"];

  //         logo = snapshot.data()!["logo"];
  //         name = snapshot.data()!["name"];
  //         password = snapshot.data()!["password"];
  //         phone_number = snapshot.data()!["phone_number"];
  //         shopdescription = snapshot.data()!["shopdescription"];
  //         shopname = snapshot.data()!["shopname"];
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: DefaultAppBar(title: "إعدادات الحساب"),
      body: Text("معلوماتي "),
      floatingActionButton: FloatingActionButton.extended(
          heroTag: "btn1",
          label: Text(
            'تسجيل خروج',
          ),
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
          backgroundColor: kPrimaryColor),
    );
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

