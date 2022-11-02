// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/AddProduct.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/main.dart';
import 'package:herfaty/models/Product1.dart';
import 'package:herfaty/pages/login.dart';
import 'package:herfaty/pages/signupHerafy.dart';
import 'package:herfaty/profile%20screens/ShopOwnerEditProfile.dart';
import 'package:herfaty/profile%20screens/show_alert_dialog.dart';
import 'package:herfaty/widgets/ownerSettings.dart';
import 'package:image_picker/image_picker.dart';

import '../pages/welcome.dart';
import '../widgets/ExpandedWidget.dart';
import '../widgets/ExpanededWidgetShop.dart';

class ShopOwnerProfile extends StatefulWidget {
  const ShopOwnerProfile({super.key});

  @override
  State<ShopOwnerProfile> createState() => _ShopOwnerProfileState();
}

class _ShopOwnerProfileState extends State<ShopOwnerProfile> {
  bool ishiddenpasswordedit = true;
  bool ishiddenpassworddelete = true;

  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  var uid;

  _ShopOwnerProfileState() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
    print(uid);
  }

  final CollectionReference shopOwners =
      FirebaseFirestore.instance.collection('shop_owner');
  late ShopOwner shopOwner;
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

  get kPrimaryColor => null;

  TextEditingController passwordController = TextEditingController();
//    fontFamily: "Tajawal",
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("حسابي",
            style: TextStyle(
              color: Color.fromARGB(255, 39, 141, 134),
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
        //                   //Navigator.of(context).pop();
        //                   // FirebaseAuth.instance.signOut();
        //                   // Navigator.of(context).pushNamedAndRemoveUntil(
        //                   //     "/login", (Route<dynamic> route) => false);
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
        
           actions: <Widget>[
             
          GestureDetector(
            onTap: () {
              showAlertDialogSettengs(context);
            }, // Image tapped
        
            child:
             Image.asset(
              'assets/images/points_trophies/icons8-settings-64.png',
              fit: BoxFit.contain, // Fixes border issues
              width: 35.0,
              height: 35.0,
              
            ),
          ),
           SizedBox(width: 10,),
          // IconButton(
          //   onPressed: () {
          //     showAlertDialogSettengs(context);
          //     // Navigator.of(context).push(MaterialPageRoute(
          //     //     builder: (BuildContext context) => OwnerSettings()));
          //   },
          //   icon: Icon(CupertinoIcons.settings,
          //       color: Color.fromARGB(255, 81, 144, 142)),
          // ),
        ],
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 39, 141, 134)),
      ),

      ////////////////////////FUTURE BUILDER///////////////////////////////
      body: FutureBuilder<ShopOwner?>(
          future: readUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('11111111111111111111111111111111111111');
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              print('2222222222222222222222222222222222222222222222');
              return Text('!هناك خطأ في استرجاع البيانات${snapshot.hasError}');
            }
            if (!snapshot.hasData) {
              print('2222222222222222222222222222222222222222222222');
              return Center(child: Text('! خطأ في عرض البيانات '));
            }
            if (snapshot.hasData) {
              print('4444444444444444444444444444444444444444');
              final shopowner = snapshot.data;
              return shopowner == null
                  ? const Center(child: Text('!لا توجد معلومات الحرفي'))
                  : buildOwner(shopowner, context);
            } else {
              return Text("! هناك مشكلة ما حاول مجددا");
            }
          }),
    );
  }

  Widget imageProfile(String logo) {
    print(logo);
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          backgroundColor: Color.fromARGB(126, 39, 141, 134),
          radius: 60.0,
          child: CircleAvatar(
            radius: 58.0,
            backgroundImage: logo == null
                ? AssetImage("assets/images/Circular_Logo.png") as ImageProvider
                : NetworkImage(logo),
            //  _imageFile == null
            //     ? AssetImage("assets/images/Circular_Logo.png") as ImageProvider
            //     : FileImage(File(_imageFile!.path)),
          ),
        ),
      ]),
    );
  }

//////////////////////////////////Building User Profile////////////////////////////////////////
  Widget buildOwner(ShopOwner shopowner, BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    return Container(
      // color: Colors.purple,
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              // color: Colors.green,
              height: 670,
              width: double.infinity,
              child: SizedBox(
                height: 500,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/images/BG2.png'),
                        )),
                        child: Center(
                          child: Column(
                            children: [
                              imageProfile(shopowner.logo),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      width: 250,
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
                      child: SizedBox(
                        height: 180,
                        width: 250,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    flex: 5,
                                    child: Text(
                                      "معلومات الحرفي",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromARGB(255, 26, 96, 91),
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
                            ),
                            Expanded(
                                child: Row(
                              children: <Widget>[
                                Icon(Icons.person,
                                    color: Color.fromARGB(255, 39, 141, 134)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  " ${shopowner.name}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontFamily: "Tajawal",
                                  ),
                                )
                              ],
                            )),
                            Expanded(
                                child: Row(
                              children: <Widget>[
                                Icon(Icons.email_rounded,
                                    color: Color.fromARGB(255, 39, 141, 134)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${shopowner.email}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontFamily: "Tajawal",
                                  ),
                                )
                              ],
                            )),
                            Expanded(
                                child: Row(
                              children: <Widget>[
                                Icon(Icons.date_range,
                                    color: Color.fromARGB(255, 39, 141, 134)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  " ${shopowner.DOB}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontFamily: "Tajawal",
                                  ),
                                )
                              ],
                            )),
                            Expanded(
                                child: Row(
                              children: <Widget>[
                                Icon(Icons.phone_android,
                                    color: Color.fromARGB(255, 39, 141, 134)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${shopowner.phone_number}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontFamily: "Tajawal",
                                  ),
                                )
                              ],
                            )),
                          ],
                        ),
                      ),
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
                      child: SizedBox(
                        height: 220,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    flex: 5,
                                    child: Text(
                                      "معلومات المتجر",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Tajawal",
                                          color:
                                              Color.fromARGB(255, 26, 96, 91)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Positioned(
                                    bottom: 50,
                                    top: 50,
                                    child: Image.asset(
                                      "assets/images/points_trophies/icons8-shop-94.png",
                                      width: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    " اسم المتجر ",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: "Tajawal",
                                        color:
                                            Color.fromARGB(255, 39, 141, 134)),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  /**hhhhhhhhhhhhhhhhhhhhhhhhhhhhhh */
                                  //
                                  Text(
                                    "${shopowner.shopname}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 6,
                            // ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 0, left: 247),
                                child: Text(
                                  "وصف المتجر",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Tajawal",
                                      color: Color.fromARGB(255, 39, 141, 134)),
                                ),
                              ),
                            ),
                            Container(
                              height: 130,
                              // color: Colors.red,
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 2),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      '${shopowner.shopdescription}',
                                      maxLines: 5,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              // child: Expanded(
                              //   child: SingleChildScrollView(
                              //       scrollDirection: Axis.vertical,
                              //       /*hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh*/
                              //       //${shopowner.sho
                              //       //pdescription}
                              //       child: Align(
                              //         alignment: Alignment.topRight,
                              //         child: ExpandedWidgetShop(
                              //             text: '${shopowner.shopdescription}'),
                              //       )),
                              //   //
                              // ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Center(
                        child: Row(children: [
                          SizedBox(
                            width: 9,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showAlertDialog(context, shopowner);
                              // openPasswordDialog(context);

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => ShopOwnerEditProfile(
                              //           shopowner.name,
                              //           shopowner.email,
                              //           shopowner.password,
                              //           shopowner.DOB,
                              //           shopowner.phone_number,
                              //           shopowner.shopname,
                              //           shopowner.shopdescription,
                              //           shopowner.id,
                              //           shopowner.logo)),
                              // );
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff51908E)),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 45, vertical: 10)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
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
                          SizedBox(
                            width: 8,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // Diolog to enter the password

                              showAlertDialogDelete(context, shopowner);

                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) {
                              //     return AlertDialog(
                              //       title: Text("تنبيه"),
                              //       content: Text('سيتم حذف الحساب نهائيا'),
                              //       actions: <Widget>[
                              //         TextButton(
                              //           child: Text("حذف",
                              //               style:
                              //                   TextStyle(color: Colors.red)),
                              //           onPressed: () {
                              //             //The logic of deleting an account
                              //             final docSO = FirebaseFirestore
                              //                 .instance
                              //                 .collection('shop_owner')
                              //                 .doc(uid);
                              //             //Navigator.of(context).pop();

                              //             docSO.delete();

                              //             FirebaseAuth.instance.signOut();
                              //             Navigator.of(context,
                              //                     rootNavigator: true)
                              //                 .pushReplacement(
                              //                     MaterialPageRoute(
                              //                         builder: (context) =>
                              //                             new Welcome()));
                              //           },
                              //         ),
                              //         TextButton(
                              //           child: Text("تراجع"),
                              //           onPressed: () {
                              //             Navigator.of(context).pop();
                              //           },
                              //         )
                              //       ],
                              //     );
                              //   },
                              // );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 221, 112, 112)),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 45, vertical: 10)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
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
                          SizedBox(
                            width: 2,
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future<ShopOwner?> readUser() async {
    print("BBBBBBBBBBEGIningggggggggggggggggggggggg ");
    //get a singal document
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? userSO = auth.currentUser;
    final uid = userSO!.uid;
    // userID = FirebaseAuth.instance.currentUser;
    print(uid);

    final docShopOwner = await FirebaseFirestore.instance
        .collection('shop_owner')
        .doc(uid)
        .get();
    print('after the refrence');
    if (docShopOwner.exists) {
      return ShopOwner.fromJson(docShopOwner.data()!);
    }
  }

  void showAlertDialog(BuildContext context1, ShopOwner shopowner) {
    TextEditingController _checkPasslController = new TextEditingController();
    showDialog(
      context: context1,
      builder: (BuildContext context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // final checkPasslField = TextFormField(
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                        "إمكانية الوصول",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 26, 96, 91),
                          fontFamily: "Tajawal",
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 180,
                        height: 110,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: AssetImage('assets/images/parents1.png'),
                        )),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextFormField(
                        controller: _checkPasslController,
                        obscureText: ishiddenpasswordedit,
                        keyboardType: TextInputType.visiblePassword,
                        enableSuggestions: false,
                        autocorrect: false,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          // suffixIcon: InkWell(
                          //   onTap: _togglePasswordViewedit,
                          //   child: Icon(
                          //     ishiddenpasswordedit
                          //         ? Icons.visibility
                          //         : Icons.visibility_off,
                          //   ),
                          // ),
                          labelText: 'أدخل كلمة المرور لتعديل الحساب',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 90, 90, 90),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text("تحقق", style: TextStyle(fontSize: 16)),
                          onPressed: () {
//check if it was correct
                            if (shopowner.password ==
                                _checkPasslController.text) {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context1,
                                MaterialPageRoute(
                                    builder: (context) => ShopOwnerEditProfile(
                                        shopowner.name,
                                        shopowner.email,
                                        shopowner.password,
                                        shopowner.DOB,
                                        shopowner.phone_number,
                                        shopowner.shopname,
                                        shopowner.shopdescription,
                                        shopowner.id,
                                        shopowner.logo)),
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: "كلمة المرور غير صحيحة",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                                backgroundColor:
                                    Color.fromARGB(255, 156, 30, 21),
                                textColor: Colors.white,
                                fontSize: 18.0,
                              );
                              // Navigator.of(context).pop();
                            }
                          },
                        ),
                        TextButton(
                          child: Text("إلغاء",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 16)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )
                  ],
                )));
      },

      // return CustomAlertDialog(
      //       content: Container(
      //         width: MediaQuery.of(context).size.width / 1.3,
      //         height: MediaQuery.of(context).size.height / 2.5,
      //         decoration: new BoxDecoration(
      //           shape: BoxShape.rectangle,
      //           color: const Color(0xFFFFFF),
      //           borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
      //         ),
      //         child: //Contents here
      //       ),
      //     );
    );
  }

  void showAlertDialogDelete(BuildContext context, ShopOwner shopowner) {
    TextEditingController _checkPasslController = new TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // final checkPasslField = TextFormField(

                    Center(
                      child: Text(
                        "إمكانية الوصول",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 26, 96, 91),
                          fontFamily: "Tajawal",
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        // width: 180,
                        height: 110,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/images/parents1.png'),
                        )),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextFormField(
                        controller: _checkPasslController,
                        obscureText: ishiddenpassworddelete,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          // suffixIcon: InkWell(
                          //   onTap: _togglePasswordViewdelete,
                          //   child: Icon(
                          //     ishiddenpassworddelete
                          //         ? Icons.visibility
                          //         : Icons.visibility_off,
                          //   ),
                          // ),
                          labelText: 'أدخل كلمة المرور لحذف الحساب',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 90, 90, 90),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text("تحقق", style: TextStyle(fontSize: 16)),
                          onPressed: () {
//check if it was correct
                            if (shopowner.password ==
                                _checkPasslController.text) {
                              Navigator.of(context).pop();

                              ///=======================Delete Dialog================

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    title: Center(
                                      child: Text(
                                        "تنبيه",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromARGB(
                                              255, 221, 112, 112),
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
                                              color: Color.fromARGB(
                                                  255, 26, 96, 91),
                                              fontFamily: "Tajawal",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("تراجع"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          "حذف",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () async {
//All the logics for deleting a profile for shop owner

// StreamBuilder<List<Product1>>(
//           stream: readProducts(uid),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Text('somting wrong \n ${snapshot.error}');
//             } else if (snapshot.hasData) {
//               final products = snapshot.data!.toList();

//               for (int i = 0; i < products.length; i++) {

//                   if (products[i].shopOwnerId == uid) {
//                    FirebaseFirestore.instance
//                    .collection('Products')
//                    .doc(products[i].id)
//                    .delete();

//                   }

//               }
//     return Center();

//             } else {
//               return Center();

//            } });

                                          final FirebaseAuth auth =
                                              FirebaseAuth.instance;
                                          final User? u = auth.currentUser;
                                          final uid = u!.uid;
                                          FirebaseFirestore.instance
                                              .collection('orders')
                                              .get()
                                              .then((snapshot) {
                                            List<DocumentSnapshot> allDocs =
                                                snapshot.docs;

                                            List<DocumentSnapshot>
                                                filteredDocs = allDocs
                                                    .where((document) =>
                                                        document[
                                                            'shopOwnerId'] ==
                                                        uid)
                                                    .where((document) =>
                                                        document['status'] ==
                                                        "طلب جديد")
                                                    .toList();

                                            // if(allDoc==null) {
                                            //   return Text('لا يوجد')
                                            // }

                                            // for (DocumentSnapshot ds
                                            //     in filteredDocs) {

                                            // }
                                          });

                                          String email = shopowner.email;
                                          String password = shopowner.password;

// Create a credential
                                          AuthCredential credential =
                                              EmailAuthProvider.credential(
                                                  email: email,
                                                  password: password);

// Reauthenticate
                                          await FirebaseAuth
                                              .instance.currentUser!
                                              .reauthenticateWithCredential(
                                                  credential);

                                          FirebaseFirestore.instance
                                              .collection('Products')
                                              .get()
                                              .then((snapshot) {
                                            List<DocumentSnapshot> allDocs =
                                                snapshot.docs;

                                            List<DocumentSnapshot>
                                                filteredDocs = allDocs
                                                    .where((document) =>
                                                        document[
                                                            'shopOwnerId'] ==
                                                        uid)
                                                    .toList();

                                            for (DocumentSnapshot ds
                                                in filteredDocs) {
                                              FirebaseFirestore.instance
                                                  .collection('Products')
                                                  .doc(ds.id)
                                                  .delete();
                                            }
                                          });

                                          FirebaseFirestore.instance
                                              .collection('cart')
                                              .get()
                                              .then((snapshot) {
                                            List<DocumentSnapshot> allDocs =
                                                snapshot.docs;

                                            List<DocumentSnapshot>
                                                filteredDocs = allDocs
                                                    .where((document) =>
                                                        document[
                                                            'shopOwnerId'] ==
                                                        uid)
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

                                            List<DocumentSnapshot>
                                                filteredDocs = allDocs
                                                    .where((document) =>
                                                        document[
                                                            'shopOwnerId'] ==
                                                        uid)
                                                    .toList();

                                            for (DocumentSnapshot ds
                                                in filteredDocs) {
                                              FirebaseFirestore.instance
                                                  .collection('wishList')
                                                  .doc(ds.id)
                                                  .delete();
                                            }
                                          });

                                          var user = await _getFirebaseUser();

                                          await user?.delete();

                                          //The logic of deleting an account
                                          final docSO = FirebaseFirestore
                                              .instance
                                              .collection('shop_owner')
                                              .doc(uid);
                                          //Navigator.of(context).pop();

                                          docSO.delete();

                                          FirebaseAuth.instance.signOut();
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          new login()));
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );

                              ///=======================Delete Dialog================
                            } else {
                              //error try again
                              Fluttertoast.showToast(
                                msg: "كلمة المرور غير صحيحة",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                                backgroundColor:
                                    Color.fromARGB(255, 156, 30, 21),
                                textColor: Colors.white,
                                fontSize: 18.0,
                              );
                              // Navigator.of(context).pop();
                            }
                          },
                        ),
                        TextButton(
                          child: Text("إلغاء",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 16)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )
                  ],
                )));
      },

      // return CustomAlertDialog(
      //       content: Container(
      //         width: MediaQuery.of(context).size.width / 1.3,
      //         height: MediaQuery.of(context).size.height / 2.5,
      //         decoration: new BoxDecoration(
      //           shape: BoxShape.rectangle,
      //           color: const Color(0xFFFFFF),
      //           borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
      //         ),
      //         child: //Contents here
      //       ),
      //     );
    );
  }

  void showAlertDialogSettengs(BuildContext context1) {
    TextEditingController _checkPasslController = new TextEditingController();

    showDialog(
      context: context1,
      builder: (BuildContext context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // final checkPasslField = TextFormField(

                    Center(
                      child: Text(
                        "إمكانية الوصول",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 26, 96, 91),
                          fontFamily: "Tajawal",
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 180,
                        height: 110,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/images/parents1.png'),
                        )),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextFormField(
                        controller: _checkPasslController,
                        obscureText: ishiddenpasswordedit,
                        keyboardType: TextInputType.visiblePassword,
                        enableSuggestions: false,
                        autocorrect: false,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          // suffixIcon: InkWell(
                          //   onTap: _togglePasswordViewedit,
                          //   child: Icon(
                          //     ishiddenpasswordedit
                          //         ? Icons.visibility
                          //         : Icons.visibility_off,
                          //   ),
                          // ),
                          labelText: 'أدخل كلمة المرور للدخول للإعدادات',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 90, 90, 90),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            child: Text("تحقق", style: TextStyle(fontSize: 16)),
                            onPressed: () async {
                              ShopOwner? sh;
                              final FirebaseAuth auth = FirebaseAuth.instance;
                              final User? userSO = auth.currentUser;
                              final uid = userSO!.uid;
                              // userID = FirebaseAuth.instance.currentUser;
                              print(uid);

                              final docShopOwner = await FirebaseFirestore
                                  .instance
                                  .collection('shop_owner')
                                  .doc(uid)
                                  .get();
                              if (docShopOwner.exists) {
                                sh = ShopOwner.fromJson(docShopOwner.data()!);
                              }
                              if (sh!.password == _checkPasslController.text) {
                                Navigator.of(context).pop();
                                Navigator.of(context1).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        OwnerSettings()));
                              } else {
                                Fluttertoast.showToast(
                                  msg: "كلمة المرور غير صحيحة",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor:
                                      Color.fromARGB(255, 156, 30, 21),
                                  textColor: Colors.white,
                                  fontSize: 18.0,
                                );
                              }

//check if it was correct
                            }),
                        TextButton(
                          child: Text("إلغاء",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 16)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )
                  ],
                )));
      },

      // return CustomAlertDialog(
      //       content: Container(
      //         width: MediaQuery.of(context).size.width / 1.3,
      //         height: MediaQuery.of(context).size.height / 2.5,
      //         decoration: new BoxDecoration(
      //           shape: BoxShape.rectangle,
      //           color: const Color(0xFFFFFF),
      //           borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
      //         ),
      //         child: //Contents here
      //       ),
      //     );
    );
  }

  void _togglePasswordViewedit() {
    setState(() {
      ishiddenpasswordedit = !ishiddenpasswordedit;
    });
  }

  void _togglePasswordViewdelete() {
    setState(() {
      ishiddenpassworddelete = !ishiddenpassworddelete;
    });
  }

  Future<User?> _getFirebaseUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}
// void uploadImageToFirebaseStorage(File file) async {
//   // Create a reference to 'images/mountains.jpg'
//   final imagesRef = storageRef
//       .child("shopOwnerLogos/${DateTime.now().millisecondsSinceEpoch}.png");
//   await imagesRef.putFile(file);

//   uploadImageUrl = await imagesRef.getDownloadURL();
//   //setState(() {});
//   print("uploaded:" + uploadImageUrl);
// }

// void openPasswordDialog(BuildContext context) {
//   showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//             title: Text("التحقق من الوصول"),
//             content: TextField(
//                 decoration: InputDecoration(hintText: 'ادخل كلمة المرور')),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     submit(context);
//                   },
//                   child: Text('تحقق'))
//             ],
//           ));
// }

// void submit(BuildContext context) {
//   Navigator.of(context).pop();
// }
// void readPrpducts(String thisOwnerId) {
//   List<DocumentSnapshot> allDocs =
//       FirebaseFirestore.instance.collection('Products');
//   FirebaseFirestore.instance
//       .collection('Products')
//       .where("shopOwnerId", isEqualTo: thisOwnerId)
//       .snapshots()
//       .map((snapshot) =>
//           snapshot.docs.map((doc) => Product1.fromJson(doc.data())).toList());
// }
