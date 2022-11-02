import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/pages/login.dart';
import 'package:herfaty/pages/reusable_widgets.dart';
import 'package:herfaty/pages/welcomeRegestration.dart';
import 'package:herfaty/screens/navOwner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:herfaty/cart/cart.dart';
import 'package:herfaty/cart/payForm.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/models/cartModal.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'ownerLocModel.dart';

import 'package:flutter/widgets.dart';

// import 'package:herfaty/firestore/firestore.dart';
// ignore_for_file: file_names, prefer_const_constructors
var uid;

class SignupHerafy extends StatefulWidget {
  const SignupHerafy({Key? key}) : super(key: key);

  @override
  State<SignupHerafy> createState() => _SignupHerafyState();
}

class _SignupHerafyState extends State<SignupHerafy> {
  DateTime todaysDate = DateTime.now();

  int currentStep = 0;
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  DateTime date = DateTime(2017, 12, 30);
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _nameTextEditingController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _BODController = TextEditingController();
  TextEditingController _PhoneNumberTextEditingController =
      TextEditingController();

  TextEditingController _shopnameTextEditingController =
      TextEditingController();
  TextEditingController _shoplogoEditingController = TextEditingController();

  TextEditingController _shopdescriptionTextEditingController =
      TextEditingController();
  final ImagePicker _pickerr = ImagePicker();
  var uploadImageUrl = ""; //image URL before choose pic
// Firebase storage + ref for pic place
  final storageRef = FirebaseStorage.instance.ref();
  PickedFile? _imageFile;
  File? pickedImage1;
  final ImagePicker _picker = ImagePicker();
  bool showLocalImage = false;

  ////////////////////// List Of Steps ////////////////////////
  List<Step> steps() => [
        Step(
            isActive: currentStep >= 0,
            title: Text("معلومات الحرفي"),
            content: Form(
              key: formKeys[0],
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      "assets/images/login_toppp.png",
                      width: 150,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 70,
                        ),
                        Container(
                            child: Image.asset(
                          "assets/images/HerfatyLogoCroped.png",
                          height: 80,
                        )),
                        Text(
                          "تسجيل حساب جديد",
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: "Tajawal",
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 26, 96, 91),
                          ),
                        ),
                        Text(
                          "معلومات الحرفي",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Tajawal",
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(248, 228, 175, 122),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 290,
                          height: 80,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          //    padding: EdgeInsets.symmetric(horizontal: 60),
                          child: reusableTextFieldForName("اسم الحرفي",
                              Icons.person, _nameTextEditingController),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 290,
                          height: 80,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          //   padding: EdgeInsets.symmetric(horizontal: 60),
                          child: reusableTextField(
                              "البريد الإلكتروني",
                              Icons.email_rounded,
                              false,
                              _emailTextEditingController),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 290,
                          //height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          // padding: EdgeInsets.symmetric(horizontal: 60),
                          child: reusableTextField("كلمة المرور", Icons.lock,
                              true, _passwordTextController),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 80),
                          child: Text(
                            " كلمه المرور يجب ان لا تقل عن 6 خانات",
                            style: TextStyle(
                                color: Color.fromARGB(255, 84, 84, 84),
                                fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: 290,
                            height: 80,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Center(
                                child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _BODController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'أدخل تاريخ الميلاد';
                                } else {
                                  return null;
                                }
                              },

                              //editing controller of this TextField
                              decoration: InputDecoration(
                                suffix: Icon(
                                  Icons.calendar_today_rounded,
                                  color: Color.fromARGB(255, 26, 96, 91),
                                ),
                                labelText: "تاريخ الميلاد",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 23),
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(106, 26, 96, 91)),
                                fillColor: Colors.white.withOpacity(0.3),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 26, 96, 91)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(255, 26, 96, 91)),
                                ),
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 164, 46, 46)),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 164, 46, 46)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(255, 164, 46, 46)),
                                ),
                              ),

                              readOnly:
                                  true, //set it true, so that user will not able to edit text
                              onTap: () async {
                                var formatter = DateFormat('dd/MM/yyyy');

                                DateTime today = DateTime.now();
                                DateTime initYear =
                                    DateTime(today.year - 15, 1, 1);
                                DateTime lastYear =
                                    DateTime(today.year - 5, 12, 31);

                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: initYear,
                                  firstDate:
                                      initYear, //DateTime.now() - not to allow to choose before today.
                                  lastDate: lastYear,

                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary:
                                              Color(0xff51908E), // <-- SEE HERE
                                          onPrimary:
                                              Colors.white, // <-- SEE HERE
                                          onSurface:
                                              Colors.black, // <-- SEE HERE
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            primary: Color(
                                                0xff51908E), // button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );

                                if (pickedDate != null &&
                                    pickedDate != todaysDate) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  //you can implement different kind of Date Format here according to your requirement

                                  setState(() {
                                    _BODController.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {
                                  print("لم يتم اختيار تاريخ الميلاد");
                                  Fluttertoast.showToast(
                                    msg: "لم يتم اختيار تاريخ الميلاد  ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.red,
                                    fontSize: 18.0,
                                  );
                                }
                              },
                            ))),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 290,
                          //height: 80,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: reusableTextFieldForPhone(
                              "رقم الجوال",
                              Icons.phone_android,
                              _PhoneNumberTextEditingController),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 100),
                          child: Text(
                            "رقم الجوال يجب أن يبدأ بـ(05) لعشرة أرقام",
                            style: TextStyle(
                                color: Color.fromARGB(255, 86, 86, 86),
                                fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "الرجوع إلى صفحة ",
                              style: TextStyle(fontFamily: "Tajawal"),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/login");
                                },
                                child: Text(
                                  "تسجيل الدخول ",
                                  style: TextStyle(
                                      fontFamily: "Tajawal",
                                      decoration: TextDecoration.underline,
                                      color: Color.fromARGB(255, 53, 47, 244)),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
        Step(
            isActive: currentStep >= 1,
            title: Text("معلومات المتجر"),
            content: Form(
              key: formKeys[1],
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      "assets/images/login_toppp.png",
                      width: 150,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 70,
                        ),
                        Container(
                            child: Image.asset(
                          "assets/images/HerfatyLogoCroped.png",
                          height: 80,
                        )),
                        Text(
                          "تسجيل حساب جديد",
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: "Tajawal",
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 26, 96, 91),
                          ),
                        ),
                        Text(
                          "معلومات المتجر",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Tajawal",
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(248, 228, 175, 122),
                          ),
                        ),

                        SizedBox(
                          height: 8,
                        ),

                        Text(
                          "أرفق صورة الشعار الخاصة بك",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Tajawal",
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 26, 96, 91),
                          ),
                        ),
                        imageProfile(),

                        ////////////////////////////Importing Picture //////////////////////////////////
                        SizedBox(
                          height: 15,
                        ),

                        Container(
                          width: 290,
                          height: 80,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: reusableTextFieldForShopName(
                              "اسم المتجر", _shopnameTextEditingController),
                        ),

                        SizedBox(
                          height: 8,
                        ),

                        Container(
                          width: 290,
                          height: 80,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: reusableTextFieldDec("وصف المتجر",
                              _shopdescriptionTextEditingController),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        addOwner(),

                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "هيا لتبدأ رحلتك!",
                          style: TextStyle(fontFamily: 'Tajawal', fontSize: 18),
                        ),

                        ElevatedButton(
                          onPressed: () async {
                            if (uploadImageUrl == "") {
                              uploadImageUrl =
                                  'assets/images/Circular_Logo.png';
                            }
                            if (addOwner.msg == 'موقع المتجر') {
                              ShowDialogMethod(
                                  context, "من فضلك قم بتحديد موقع المتجر");
                            } else {
                              try {
                                //uploadImageUrl
                                if (formKeys[0].currentState!.validate() &&
                                    formKeys[1].currentState!.validate()) {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email:
                                              _emailTextEditingController.text,
                                          password:
                                              _passwordTextController.text)
                                      .then((value) {
                                    final shopowner = ShopOwner(
                                        name: _nameTextEditingController.text,
                                        email: _emailTextEditingController.text,
                                        password: _passwordTextController.text,
                                        DOB: _BODController.text,
                                        phone_number:
                                            _PhoneNumberTextEditingController
                                                .text,
                                        logo: uploadImageUrl,
                                        shopname:
                                            _shopnameTextEditingController.text,
                                        shopdescription:
                                            _shopdescriptionTextEditingController
                                                .text,
                                        points: 0);

                                    ownerLocModel shopLocation = ownerLocModel(
                                        shopName:
                                            _shopnameTextEditingController.text,
                                        location: addOwner.msg);

                                    Fluttertoast.showToast(
                                      msg: "تم تسجيل حسابك  بنجاح",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor:
                                          Color.fromARGB(255, 26, 96, 91),
                                      textColor: Colors.white,
                                      fontSize: 18.0,
                                    );
                                    createShopOwner(shopowner);
                                    creatOwnerLoc(shopLocation);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const navOwner()),
                                    );
                                  });
                                }
                              } on FirebaseAuthException catch (error) {
                                Fluttertoast.showToast(
                                  msg: "البريد الإلكتروني موجود مسبقا",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor:
                                      Color.fromARGB(255, 156, 30, 21),
                                  textColor: Colors.white,
                                  fontSize: 18.0,
                                );
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
                            "تسجيل الحساب",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Tajawal",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "هل لديك حساب بالفعل؟ ",
                              style: TextStyle(fontFamily: "Tajawal"),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/login");
                                },
                                child: Text(
                                  "تسجيل الدخول ",
                                  style: TextStyle(
                                      fontFamily: "Tajawal",
                                      decoration: TextDecoration.underline,
                                      color: Color.fromARGB(255, 53, 47, 244)),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))
      ];

  @override
  Widget build(BuildContext context) {
    print('jjjjjjjjjjjj');
    addOwner.msg = 'موقع المتجر';
    _addOwnerState._changeFormat();
    return Scaffold(
      body: Theme(
        data: ThemeData(
            colorScheme: ColorScheme.light(primary: Color(0xff51908E))),
        child: Container(
          padding: EdgeInsets.only(top: 10),
          child: Stepper(
            type: StepperType.horizontal,
            currentStep: currentStep,
            steps: steps(),
            onStepContinue: () {
              if (!formKeys[currentStep].currentState!.validate()) {
                return;
              }

              if (currentStep < (steps().length - 1)) {
                setState(() {
                  currentStep += 1;
                });
              }
            },
            onStepCancel: () {
              if (currentStep == 0) {
                return;
              }
              setState(() {
                currentStep -= 1;
              });
            },
            controlsBuilder: (BuildContext context, ControlsDetails controls) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                decoration: BoxDecoration(),
                child: Row(
                  children: [
                    if (currentStep == 0)
                      Expanded(
                        child: ElevatedButton(
                          child: Text('التالي'),
                          onPressed: controls.onStepContinue,
                        ),
                      ),
                    if (currentStep == 1)
                      Expanded(
                        child: ElevatedButton(
                          child: Text('السابق'),
                          onPressed: controls.onStepCancel,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(248, 228, 175, 122)),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );

    // return Form(
    //   //autovalidateMode: AutovalidateMode.onUserInteraction,
    //   key: _formKey,
    //   child: Scaffold(
    //     resizeToAvoidBottomInset: true,
    //     body: SafeArea(
    //       child: Scaffold(
    //         resizeToAvoidBottomInset: true,
    //         body: SizedBox(
    //           height: double.infinity,
    //           width: double.infinity,
    //           child: Stack(children: [
    //             Positioned(
    //               left: 0,
    //               top: 0,
    //               child: Image.asset(
    //                 "assets/images/login_toppp.png",
    //                 width: 150,
    //               ),
    //             ),
    //             // Positioned(
    //             //   bottom: 0,
    //             //   right: 0,

    //             //   child: Image.asset(
    //             //     "assets/images/main_botomm.png",
    //             //     width: 200,
    //             //   ),
    //             // ),
    //             SizedBox(
    //               width: double.infinity,
    //               child: Scrollbar(
    //                 child: SingleChildScrollView(
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       SizedBox(
    //                         height: 70,
    //                       ),

    //                       Container(
    //                           child: Image.asset(
    //                         "assets/images/HerfatyLogoCroped.png",
    //                         height: 100,
    //                       )),

    //                       SizedBox(
    //                         height: 30,
    //                       ),
    //                       Text(
    //                         "تسجيل حساب جديد",
    //                         style: TextStyle(
    //                           fontSize: 35,
    //                           fontFamily: "Tajawal",
    //                           fontWeight: FontWeight.bold,
    //                           color: Color.fromARGB(255, 26, 96, 91),
    //                         ),
    //                       ),

    //                       SizedBox(
    //                         height: 15,
    //                       ),
    //                       Container(
    //                           child: Image.asset(
    //                         "assets/images/number1.png",
    //                         height: 50,
    //                       )),
    //                       SizedBox(
    //                         height: 15,
    //                       ),

    //                       Text(
    //                         "معلومات الحرفي",
    //                         style: TextStyle(
    //                           fontSize: 20,
    //                           fontFamily: "Tajawal",
    //                           fontWeight: FontWeight.bold,
    //                           color: Color.fromARGB(248, 228, 175, 122),
    //                         ),
    //                       ),

    //                       SizedBox(
    //                         height: 27,
    //                       ),
    //                       Container(
    //                         // width: 290,
    //                         // height: 53,
    //                         // padding: EdgeInsets.symmetric(horizontal: 16),
    //                         padding: EdgeInsets.symmetric(horizontal: 60),
    //                         child: reusableTextFieldForName("اسم الحرفي",
    //                             Icons.person, _nameTextEditingController),
    //                       ),

    //                       SizedBox(
    //                         height: 20,
    //                       ),

    //                       Container(
    //                         // width: 290,
    //                         // height: 53,
    //                         // padding: EdgeInsets.symmetric(horizontal: 16),
    //                         padding: EdgeInsets.symmetric(horizontal: 60),
    //                         child: reusableTextField(
    //                             "البريد الإلكتروني",
    //                             Icons.email_rounded,
    //                             false,
    //                             _emailTextEditingController),
    //                       ),

    //                       SizedBox(
    //                         height: 23,
    //                       ),

    //                       Container(
    //                         // width: 290,
    //                         // height: 53,
    //                         // padding: EdgeInsets.symmetric(horizontal: 16),
    //                         padding: EdgeInsets.symmetric(horizontal: 60),
    //                         child: reusableTextField("كلمة المرور", Icons.lock,
    //                             true, _passwordTextController),
    //                       ),
    //                       Container(
    //                         padding: const EdgeInsets.only(left: 110),
    //                         child: Text(
    //                           " كلمه المرور يجب ان لا تقل عن 6 خانات",
    //                           style: TextStyle(
    //                               color: Color.fromARGB(255, 84, 84, 84),
    //                               fontSize: 13),
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         height: 17,
    //                       ),
    //                       Container(
    //                           padding: EdgeInsets.symmetric(horizontal: 60),
    //                           child: Center(
    //                               child: TextFormField(
    //                             autovalidateMode:
    //                                 AutovalidateMode.onUserInteraction,
    //                             controller: _BODController,
    //                             validator: (value) {
    //                               if (value!.isEmpty) {
    //                                 return 'أدخل تاريخ الميلاد';
    //                               } else {
    //                                 return null;
    //                               }
    //                             },

    //                             //editing controller of this TextField
    //                             decoration: InputDecoration(
    //                               suffix: Icon(
    //                                 Icons.calendar_today_rounded,
    //                                 color: Color.fromARGB(255, 26, 96, 91),
    //                               ),
    //                               labelText: "تاريخ الميلاد",
    //                               contentPadding: const EdgeInsets.symmetric(
    //                                   vertical: 1.0, horizontal: 23),
    //                               labelStyle: TextStyle(
    //                                   color: Color.fromARGB(106, 26, 96, 91)),
    //                               fillColor: Colors.white.withOpacity(0.3),
    //                               enabledBorder: OutlineInputBorder(
    //                                 borderSide: BorderSide(
    //                                     color: Color.fromARGB(255, 26, 96, 91)),
    //                               ),
    //                               focusedBorder: OutlineInputBorder(
    //                                 borderSide: BorderSide(
    //                                     width: 2,
    //                                     color: Color.fromARGB(255, 26, 96, 91)),
    //                               ),
    //                               errorStyle: TextStyle(
    //                                   color: Color.fromARGB(255, 164, 46, 46)),
    //                               errorBorder: OutlineInputBorder(
    //                                 borderSide: BorderSide(
    //                                     color:
    //                                         Color.fromARGB(255, 164, 46, 46)),
    //                               ),
    //                               focusedErrorBorder: OutlineInputBorder(
    //                                 borderSide: BorderSide(
    //                                     width: 2,
    //                                     color:
    //                                         Color.fromARGB(255, 164, 46, 46)),
    //                               ),
    //                             ),

    //                             readOnly:
    //                                 true, //set it true, so that user will not able to edit text
    //                             onTap: () async {
    //                               DateTime? pickedDate = await showDatePicker(
    //                                 context: context,
    //                                 initialDate: DateTime.now(),
    //                                 firstDate: DateTime(
    //                                     2000), //DateTime.now() - not to allow to choose before today.
    //                                 lastDate: DateTime(2101),

    //                                 builder: (context, child) {
    //                                   return Theme(
    //                                     data: Theme.of(context).copyWith(
    //                                       colorScheme: ColorScheme.light(
    //                                         primary: Color(
    //                                             0xff51908E), // <-- SEE HERE
    //                                         onPrimary:
    //                                             Colors.white, // <-- SEE HERE
    //                                         onSurface:
    //                                             Colors.black, // <-- SEE HERE
    //                                       ),
    //                                       textButtonTheme: TextButtonThemeData(
    //                                         style: TextButton.styleFrom(
    //                                           primary: Color(
    //                                               0xff51908E), // button text color
    //                                         ),
    //                                       ),
    //                                     ),
    //                                     child: child!,
    //                                   );
    //                                 },
    //                               );

    //                               if (pickedDate != null) {
    //                                 print(
    //                                     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
    //                                 String formattedDate =
    //                                     DateFormat('yyyy-MM-dd')
    //                                         .format(pickedDate);
    //                                 print(
    //                                     formattedDate); //formatted date output using intl package =>  2021-03-16
    //                                 //you can implement different kind of Date Format here according to your requirement

    //                                 setState(() {
    //                                   _BODController.text =
    //                                       formattedDate; //set output date to TextField value.
    //                                 });
    //                               } else {
    //                                 print("لم يتم اختيار تاريخ الميلاد");
    //                                 // Fluttertoast.showToast(
    //                                 //   msg: "لم يتم اختيار تاريخ الميلاد  ",
    //                                 //   toastLength: Toast.LENGTH_SHORT,
    //                                 //   gravity: ToastGravity.CENTER,
    //                                 //   timeInSecForIosWeb: 3,
    //                                 //   backgroundColor: Colors.white,
    //                                 //   textColor: Colors.red,
    //                                 //   fontSize: 18.0,
    //                                 // );
    //                               }
    //                             },
    //                           ))),
    //                       SizedBox(
    //                         height: 17,
    //                       ),
    //                       Container(
    //                         // width: 290,
    //                         // height: 53,
    //                         // padding: EdgeInsets.symmetric(horizontal: 16),
    //                         padding: EdgeInsets.symmetric(horizontal: 60),
    //                         child: reusableTextFieldForPhone(
    //                             "رقم الجوال",
    //                             Icons.phone_android,
    //                             _PhoneNumberTextEditingController),
    //                       ),
    //                       Container(
    //                         padding: const EdgeInsets.only(left: 100),
    //                         child: Text(
    //                           "رقم الجوال يجب أن يبدأ بـ(05) لعشرة أرقام",
    //                           style: TextStyle(
    //                               color: Color.fromARGB(255, 86, 86, 86),
    //                               fontSize: 13),
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         height: 17,
    //                       ),
    //                       SizedBox(
    //                         width: 299,
    //                         child: Row(
    //                           children: [
    //                             Expanded(
    //                                 child: Divider(
    //                               thickness: 2,
    //                               color: Color.fromARGB(255, 26, 96, 91),
    //                             )),
    //                           ],
    //                         ),
    //                       ),

    //                       SizedBox(
    //                         height: 15,
    //                       ),
    //                       Container(
    //                           child: Image.asset(
    //                         "assets/images/number2.png",
    //                         height: 50,
    //                       )),
    //                       SizedBox(
    //                         height: 15,
    //                       ),

    //                       Text(
    //                         "معلومات المتجر",
    //                         style: TextStyle(
    //                           fontSize: 20,
    //                           fontFamily: "Tajawal",
    //                           fontWeight: FontWeight.bold,
    //                           color: Color.fromARGB(248, 228, 175, 122),
    //                         ),
    //                       ),

    //                       SizedBox(
    //                         height: 27,
    //                       ),

    //                       Text(
    //                         "أرفق صورة الشعار الخاصة بك",
    //                         style: TextStyle(
    //                           fontSize: 15,
    //                           fontFamily: "Tajawal",
    //                           fontWeight: FontWeight.bold,
    //                           color: Color.fromARGB(255, 26, 96, 91),
    //                         ),
    //                       ),
    //                       imageProfile(),

    //                       ////////////////////////////Importing Picture //////////////////////////////////
    //                       SizedBox(
    //                         height: 27,
    //                       ),

    //                       Container(
    //                         // width: 290,
    //                         // height: 53,
    //                         padding: EdgeInsets.symmetric(horizontal: 60),
    //                         child: reusableTextFieldForShopName(
    //                             "اسم المتجر", _shopnameTextEditingController),
    //                       ),

    //                       SizedBox(
    //                         height: 20,
    //                       ),

    //                       Container(
    //                         // width: 290,
    //                         // height: 53,
    //                         padding: EdgeInsets.symmetric(horizontal: 60),
    //                         child: reusableTextFieldDec("وصف المتجر",
    //                             _shopdescriptionTextEditingController),
    //                       ),

    //                       SizedBox(
    //                         height: 17,
    //                       ),

    //                       SizedBox(
    //                         height: 17,
    //                       ),
    //                       Text(
    //                         "هيا لتبدأ رحلتك!",
    //                         style:
    //                             TextStyle(fontFamily: 'Tajawal', fontSize: 18),
    //                       ),
    //                       SizedBox(
    //                         height: 6,
    //                       ),
    //                       ElevatedButton(
    //                         onPressed: () async {
    //                           try {
    //                             if (_formKey.currentState!.validate()) {
    //                               await FirebaseAuth.instance
    //                                   .createUserWithEmailAndPassword(
    //                                       email:
    //                                           _emailTextEditingController.text,
    //                                       password:
    //                                           _passwordTextController.text)
    //                                   .then((value) {
    //                                 final shopowner = ShopOwner(
    //                                     name: _nameTextEditingController.text,
    //                                     email: _emailTextEditingController.text,
    //                                     password: _passwordTextController.text,
    //                                     DOB: _BODController.text,
    //                                     phone_number:
    //                                         _PhoneNumberTextEditingController
    //                                             .text,
    //                                     logo: _shoplogoEditingController.text,
    //                                     shopname:
    //                                         _shopnameTextEditingController.text,
    //                                     shopdescription:
    //                                         _shopdescriptionTextEditingController
    //                                             .text);
    //                                 Fluttertoast.showToast(
    //                                   msg: "تم تسجيل حسابك  بنجاح",
    //                                   toastLength: Toast.LENGTH_SHORT,
    //                                   gravity: ToastGravity.CENTER,
    //                                   timeInSecForIosWeb: 3,
    //                                   backgroundColor:
    //                                       Color.fromARGB(255, 26, 96, 91),
    //                                   textColor: Colors.white,
    //                                   fontSize: 18.0,
    //                                 );
    //                                 createShopOwner(shopowner);
    //                                 Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                       builder: (context) =>
    //                                           const navOwner()),
    //                                 );
    //                               });
    //                             }
    //                           } on FirebaseAuthException catch (error) {
    //                             showDialog(
    //                                 context: context,
    //                                 builder: (BuildContext context) {
    //                                   return AlertDialog(
    //                                     title: Text("خطأ"),
    //                                     content: Text(
    //                                         'البريد الإلكتروني موجود مسبقا'),
    //                                     actions: <Widget>[
    //                                       TextButton(
    //                                         child: Text("حسنا"),
    //                                         onPressed: () {
    //                                           Navigator.of(context).pop();
    //                                         },
    //                                       )
    //                                     ],
    //                                   );
    //                                 });
    //                           }
    //                         },
    //                         style: ButtonStyle(
    //                           backgroundColor:
    //                               MaterialStateProperty.all(Color(0xff51908E)),
    //                           padding: MaterialStateProperty.all(
    //                               EdgeInsets.symmetric(
    //                                   horizontal: 90, vertical: 13)),
    //                           shape: MaterialStateProperty.all(
    //                               RoundedRectangleBorder(
    //                                   borderRadius: BorderRadius.circular(27))),
    //                         ),
    //                         child: Text(
    //                           "تسجيل الحساب",
    //                           style: TextStyle(
    //                               fontSize: 14,
    //                               fontFamily: "Tajawal",
    //                               fontWeight: FontWeight.bold),
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         height: 33,
    //                       ),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: [
    //                           Text(
    //                             "هل لديك حساب بالفعل؟ ",
    //                             style: TextStyle(fontFamily: "Tajawal"),
    //                           ),
    //                           GestureDetector(
    //                               onTap: () {
    //                                 Navigator.pushNamed(context, "/login");
    //                               },
    //                               child: Text(
    //                                 "تسجيل الدخول ",
    //                                 style: TextStyle(
    //                                     fontFamily: "Tajawal",
    //                                     decoration: TextDecoration.underline,
    //                                     color:
    //                                         Color.fromARGB(255, 53, 47, 244)),
    //                               )),
    //                         ],
    //                       ),
    //                       SizedBox(
    //                         height: 17,
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ]),
    //         ),
    //       ),
    //     ),
    //   ),
    // ); //form
  }

// initilazie Image Picker library

  void uploadImageToFirebaseStorage(File file) async {
    // Create a reference to 'images/mountains.jpg'
    final imagesRef = storageRef
        .child("shopOwnerLogos/${DateTime.now().millisecondsSinceEpoch}.png");
    await imagesRef.putFile(file);

    uploadImageUrl = await imagesRef.getDownloadURL();
    //setState(() {});
    print("uploaded:" + uploadImageUrl);
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: showLocalImage == false
              ? AssetImage("assets/images/Circular_Logo.png") as ImageProvider
              : FileImage(pickedImage1!) as ImageProvider,

          // _imageFile.path
          //
          // ?  as ImageProvider
          // :
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "اختر صورة",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () async {
                // Capture a photo
                takePhoto(ImageSource.camera);

                Navigator.of(context).pop();
              },
              label: Text("الكاميرا"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () async {
                takePhoto(ImageSource.gallery);

                Navigator.of(context).pop();
              },
              label: Text("الصور"),
            ),
          ])
        ],
      ),
    );
  }

//logo
  void takePhoto(ImageSource source) async {
    XFile? file1 = await ImagePicker().pickImage(source: source);
    if (file1 == null) return;

    setState(() {
      try {
        pickedImage1 = File(file1.path);
        showLocalImage = true;

        uploadImageToFirebaseStorage(pickedImage1!);
        uploadImageUrl = pickedImage1!.uri.toString();
        print(uploadImageUrl);
        Fluttertoast.showToast(
          msg: 'تمت إضافة الصورة بنجاح',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Color.fromARGB(255, 26, 96, 91),
          textColor: Colors.white,
          fontSize: 18.0,
        );
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'هناك مشكلة أعد ادخال الصوره مجددا',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.white,
          textColor: Colors.red,
          fontSize: 18.0,
        );
      }
    });
  }

  Future creatOwnerLoc(ownerLocModel shopLocation) async {
    final docCartItem =
        FirebaseFirestore.instance.collection('owner_loc').doc();
    final json = shopLocation.toJson();
    await docCartItem.set(
      json,
      // SetOptions(merge: true)
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
      title: Text(title,
          style: TextStyle(color: kPrimaryColor, fontFamily: "Tajawal")),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: kPrimaryColor),
      leading: IconButton(
        padding: EdgeInsets.only(right: 20),
        icon: const Icon(
          Icons.arrow_back, //سهم العودة
          color: Color.fromARGB(255, 26, 96, 91),
          size: 22.0,
        ),
        onPressed: () {
          addOwner.msg = 'موقع المتجر';
          Navigator.pop(context);
        },
      ),
    );
  }
}

//Datebase
Future createShopOwner(ShopOwner shopowner) async {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final User? user = auth.currentUser;
  uid = user!.uid;
  shopowner.id = uid;

  final json = shopowner.toJson();
  final docShopOWner =
      FirebaseFirestore.instance.collection('shop_owner').doc(uid);
  await docShopOWner.set(json);
}

//Database
class ShopOwner {
  String id;
  final String name;
  final String email;
  final String password;
  final String DOB;
  final String phone_number;
  final String logo;
  final String shopname;
  final String shopdescription;
  final int points;

  ShopOwner({
    this.id = '',
    required this.name,
    required this.email,
    required this.password,
    required this.DOB,
    required this.phone_number,
    required this.logo,
    required this.shopname,
    required this.shopdescription,
    required this.points,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'DOB': DOB,
        'logo': logo,
        'phone_number': phone_number,
        'shopdescription': shopdescription,
        'shopname': shopname,
        'points': points,
      };
  static ShopOwner fromJson(Map<String, dynamic> json) => ShopOwner(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        DOB: json['DOB'],
        logo: json['logo'],
        phone_number: json['phone_number'],
        shopdescription: json['shopdescription'],
        shopname: json['shopname'],
        points: json['points'],
      );
}

class addOwner extends StatefulWidget {
  static String msg = 'موقع المتجر';
  addOwner({Key? key}) : super(key: key);
  @override
  _addOwnerState createState() => _addOwnerState();
}

class _addOwnerState extends State<addOwner> {
  static String msgButton = "اضغط هنا لتحديدالموقع";
  static Color color = new Color(0xff51908E);
  static Color Tcolor = new Color.fromARGB(255, 255, 255, 255);
  static TextDecoration t = TextDecoration.none;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      margin: EdgeInsets.only(top: 1.0, left: 40.0, right: 40.0, bottom: 5.0),
      //padding: EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 26, 96, 91), width: 1),
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 19.0),
              child: Text(
                addOwner.msg,
                style: TextStyle(
                  //fontSize: 15,
                  color: Color.fromARGB(106, 26, 96, 91),
                  //fontWeight: FontWeight.bold,
                  fontFamily: "Tajawal",
                ),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 5,
              ),
            ),
          ),
          Container(
            height: 52,
            width: 120,
            //margin: EdgeInsets.only(left: 8.0, top: 2.0, bottom: 2.0),
            child: ElevatedButton(
              child: Text(
                msgButton,
                style: TextStyle(
                  fontSize: 13,
                  color: Tcolor,
                  decoration: t,
                  //fontFamily: "Tajawal"
                ),
              ),
              onPressed: _changeText,
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.white,
                  elevation: 0,
                  primary: color,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  fixedSize: Size(165, 35)),
            ),
          )
        ],
      ),
    );
  }

  _changeText() {
    final kInitialPosition = LatLng(24.575714, 46.830308);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey:
              "AIzaSyA39qkpPUBK63CO4RGlDAacBIUlDl4RPgY", // Put YOUR OWN KEY here.
          onPlacePicked: (result) {
            //print(result.formattedAddress);
            Navigator.of(context).pop();
            if (mounted)
              setState(() {
                if (result.formattedAddress is Null) {
                  addOwner.msg = 'ادخل الموقع';
                } else {
                  addOwner.msg = result.formattedAddress!;
                  //msgButton = "تم تحديد الموقع";
                  color = new Color.fromARGB(255, 255, 255, 255);
                  Tcolor = Color.fromARGB(255, 8, 24, 246);
                  t = TextDecoration.underline;
                  msgButton = "اضغط لتغيير الموقع";
                }
              });
          },
          initialPosition: kInitialPosition,
          useCurrentLocation: true,
        ),
      ),
    );
  }

  static _changeFormat() {
    msgButton = "اضغط هنا لتحديد الموقع";
    color = new Color(0xff51908E);
    Tcolor = new Color.fromARGB(255, 255, 255, 255);
    t = TextDecoration.none;
  }
}

enum StepState {
  /// A step that displays its index in its circle.
  indexed,

  /// A step that displays a pencil icon in its circle.
  editing,

  /// A step that displays a tick icon in its circle.
  complete,

  /// A step that is disabled and does not to react to taps.
  disabled,

  /// A step that is currently having an error. e.g. the user has submitted wrong
  /// input.
  error,
}

/// Defines the [Stepper]'s main axis.
enum StepperType {
  /// A vertical layout of the steps with their content in-between the titles.
  vertical,

  /// A horizontal layout of the steps with their content below the titles.
  horizontal,
}

/// Container for all the information necessary to build a Stepper widget's
/// forward and backward controls for any given step.
///
/// Used by [Stepper.controlsBuilder].
@immutable
class ControlsDetails {
  /// Creates a set of details describing the Stepper.
  const ControlsDetails({
    required this.currentStep,
    required this.stepIndex,
    this.onStepCancel,
    this.onStepContinue,
  });

  /// Index that is active for the surrounding [Stepper] widget. This may be
  /// different from [stepIndex] if the user has just changed steps and we are
  /// currently animating toward that step.
  final int currentStep;

  /// Index of the step for which these controls are being built. This is
  /// not necessarily the active index, if the user has just changed steps and
  /// this step is animating away. To determine whether a given builder is building
  /// the active step or the step being navigated away from, see [isActive].
  final int stepIndex;

  /// The callback called when the 'continue' button is tapped.
  ///
  /// If null, the 'continue' button will be disabled.
  final VoidCallback? onStepContinue;

  /// The callback called when the 'cancel' button is tapped.
  ///
  /// If null, the 'cancel' button will be disabled.
  final VoidCallback? onStepCancel;

  /// True if the indicated step is also the current active step. If the user has
  /// just activated the transition to a new step, some [Stepper.type] values will
  /// lead to both steps being rendered for the duration of the animation shifting
  /// between steps.
  bool get isActive => currentStep == stepIndex;
}

/// A builder that creates a widget given the two callbacks `onStepContinue` and
/// `onStepCancel`.
///
/// Used by [Stepper.controlsBuilder].
///
/// See also:
///
///  * [WidgetBuilder], which is similar but only takes a [BuildContext].
typedef ControlsWidgetBuilder = Widget Function(
    BuildContext context, ControlsDetails details);

const TextStyle _kStepStyle = TextStyle(
  fontSize: 12.0,
  color: Colors.white,
);
const Color _kErrorLight = Colors.red;
final Color _kErrorDark = Colors.red.shade400;
const Color _kCircleActiveLight = Colors.white;
const Color _kCircleActiveDark = Colors.black87;
const Color _kDisabledLight = Colors.black38;
const Color _kDisabledDark = Colors.white38;
const double _kStepSize = 24.0;
const double _kTriangleHeight =
    _kStepSize * 0.866025; // Triangle height. sqrt(3.0) / 2.0

/// A material step used in [Stepper]. The step can have a title and subtitle,
/// an icon within its circle, some content and a state that governs its
/// styling.
///
/// See also:
///
///  * [Stepper]
///  * <https://material.io/archive/guidelines/components/steppers.html>
@immutable
class Step {
  /// Creates a step for a [Stepper].
  ///
  /// The [title], [content], and [state] arguments must not be null.
  const Step({
    required this.title,
    this.subtitle,
    required this.content,
    this.state = StepState.indexed,
    this.isActive = false,
    this.label,
  })  : assert(title != null),
        assert(content != null),
        assert(state != null);

  /// The title of the step that typically describes it.
  final Widget title;

  /// The subtitle of the step that appears below the title and has a smaller
  /// font size. It typically gives more details that complement the title.
  ///
  /// If null, the subtitle is not shown.
  final Widget? subtitle;

  /// The content of the step that appears below the [title] and [subtitle].
  ///
  /// Below the content, every step has a 'continue' and 'cancel' button.
  final Widget content;

  /// The state of the step which determines the styling of its components
  /// and whether steps are interactive.
  final StepState state;

  /// Whether or not the step is active. The flag only influences styling.
  final bool isActive;

  /// Only [StepperType.horizontal], Optional widget that appears under the [title].
  /// By default, uses the `bodyText1` theme.
  final Widget? label;
}

/// A material stepper widget that displays progress through a sequence of
/// steps. Steppers are particularly useful in the case of forms where one step
/// requires the completion of another one, or where multiple steps need to be
/// completed in order to submit the whole form.
///
/// The widget is a flexible wrapper. A parent class should pass [currentStep]
/// to this widget based on some logic triggered by the three callbacks that it
/// provides.
///
/// {@tool dartpad}
/// An example the shows how to use the [Stepper], and the [Stepper] UI
/// appearance.
///
/// ** See code in examples/api/lib/material/stepper/stepper.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [Step]
///  * <https://material.io/archive/guidelines/components/steppers.html>
class Stepper extends StatefulWidget {
  /// Creates a stepper from a list of steps.
  ///
  /// This widget is not meant to be rebuilt with a different list of steps
  /// unless a key is provided in order to distinguish the old stepper from the
  /// new one.
  ///
  /// The [steps], [type], and [currentStep] arguments must not be null.
  const Stepper({
    super.key,
    required this.steps,
    this.physics,
    this.type = StepperType.vertical,
    this.currentStep = 0,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.controlsBuilder,
    this.elevation,
    this.margin,
  })  : assert(steps != null),
        assert(type != null),
        assert(currentStep != null),
        assert(0 <= currentStep && currentStep < steps.length);

  /// The steps of the stepper whose titles, subtitles, icons always get shown.
  ///
  /// The length of [steps] must not change.
  final List<Step> steps;

  /// How the stepper's scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to
  /// animate after the user stops dragging the scroll view.
  ///
  /// If the stepper is contained within another scrollable it
  /// can be helpful to set this property to [ClampingScrollPhysics].
  final ScrollPhysics? physics;

  /// The type of stepper that determines the layout. In the case of
  /// [StepperType.horizontal], the content of the current step is displayed
  /// underneath as opposed to the [StepperType.vertical] case where it is
  /// displayed in-between.
  final StepperType type;

  /// The index into [steps] of the current step whose content is displayed.
  final int currentStep;

  /// The callback called when a step is tapped, with its index passed as
  /// an argument.
  final ValueChanged<int>? onStepTapped;

  /// The callback called when the 'continue' button is tapped.
  ///
  /// If null, the 'continue' button will be disabled.
  final VoidCallback? onStepContinue;

  /// The callback called when the 'cancel' button is tapped.
  ///
  /// If null, the 'cancel' button will be disabled.
  final VoidCallback? onStepCancel;

  /// The callback for creating custom controls.
  ///
  /// If null, the default controls from the current theme will be used.
  ///
  /// This callback which takes in a context and a [ControlsDetails] object, which
  /// contains step information and two functions: [onStepContinue] and [onStepCancel].
  /// These can be used to control the stepper. For example, reading the
  /// [ControlsDetails.currentStep] value within the callback can change the text
  /// of the continue or cancel button depending on which step users are at.
  ///
  /// {@tool dartpad}
  /// Creates a stepper control with custom buttons.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return Stepper(
  ///     controlsBuilder:
  ///       (BuildContext context, ControlsDetails details) {
  ///          return Row(
  ///            children: <Widget>[
  ///              TextButton(
  ///                onPressed: details.onStepContinue,
  ///                child: Text('Continue to Step ${details.stepIndex + 1}'),
  ///              ),
  ///              TextButton(
  ///                onPressed: details.onStepCancel,
  ///                child: Text('Back to Step ${details.stepIndex - 1}'),
  ///              ),
  ///            ],
  ///          );
  ///       },
  ///     steps: const <Step>[
  ///       Step(
  ///         title: Text('A'),
  ///         content: SizedBox(
  ///           width: 100.0,
  ///           height: 100.0,
  ///         ),
  ///       ),
  ///       Step(
  ///         title: Text('B'),
  ///         content: SizedBox(
  ///           width: 100.0,
  ///           height: 100.0,
  ///         ),
  ///       ),
  ///     ],
  ///   );
  /// }
  /// ```
  /// ** See code in examples/api/lib/material/stepper/stepper.controls_builder.0.dart **
  /// {@end-tool}
  final ControlsWidgetBuilder? controlsBuilder;

  /// The elevation of this stepper's [Material] when [type] is [StepperType.horizontal].
  final double? elevation;

  /// custom margin on vertical stepper.
  final EdgeInsetsGeometry? margin;

  @override
  State<Stepper> createState() => _StepperState();
}

class _StepperState extends State<Stepper> with TickerProviderStateMixin {
  late List<GlobalKey> _keys;
  final Map<int, StepState> _oldStates = <int, StepState>{};

  @override
  void initState() {
    super.initState();
    _keys = List<GlobalKey>.generate(
      widget.steps.length,
      (int i) => GlobalKey(),
    );

    for (int i = 0; i < widget.steps.length; i += 1) {
      _oldStates[i] = widget.steps[i].state;
    }
  }

  @override
  void didUpdateWidget(Stepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.steps.length == oldWidget.steps.length);

    for (int i = 0; i < oldWidget.steps.length; i += 1) {
      _oldStates[i] = oldWidget.steps[i].state;
    }
  }

  bool _isFirst(int index) {
    return index == 0;
  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  bool _isCurrent(int index) {
    return widget.currentStep == index;
  }

  bool _isDark() {
    return Theme.of(context).brightness == Brightness.dark;
  }

  bool _isLabel() {
    for (final Step step in widget.steps) {
      if (step.label != null) {
        return true;
      }
    }
    return false;
  }

  Widget _buildLine(bool visible) {
    return Container(
      width: visible ? 1.0 : 0.0,
      height: 16.0,
      color: Colors.grey.shade400,
    );
  }

  Widget _buildCircleChild(int index, bool oldState) {
    final StepState state =
        oldState ? _oldStates[index]! : widget.steps[index].state;
    final bool isDarkActive = _isDark() && widget.steps[index].isActive;
    assert(state != null);
    switch (state) {
      case StepState.indexed:
      case StepState.disabled:
        return Text(
          '${index + 1}',
          style: isDarkActive
              ? _kStepStyle.copyWith(color: Colors.black87)
              : _kStepStyle,
        );
      case StepState.editing:
        return Icon(
          Icons.edit,
          color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
          size: 18.0,
        );
      case StepState.complete:
        return Icon(
          Icons.check,
          color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
          size: 18.0,
        );
      case StepState.error:
        return const Text('!', style: _kStepStyle);
    }
  }

  Color _circleColor(int index) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    if (!_isDark()) {
      return widget.steps[index].isActive
          ? colorScheme.primary
          : colorScheme.onSurface.withOpacity(0.38);
    } else {
      return widget.steps[index].isActive
          ? colorScheme.secondary
          : colorScheme.background;
    }
  }

  Widget _buildCircle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: _kStepSize,
      height: _kStepSize,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: _circleColor(index),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: _buildCircleChild(
              index, oldState && widget.steps[index].state == StepState.error),
        ),
      ),
    );
  }

  Widget _buildTriangle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: _kStepSize,
      height: _kStepSize,
      child: Center(
        child: SizedBox(
          width: _kStepSize,
          height:
              _kTriangleHeight, // Height of 24dp-long-sided equilateral triangle.
          child: CustomPaint(
            painter: _TrianglePainter(
              color: _isDark() ? _kErrorDark : _kErrorLight,
            ),
            child: Align(
              alignment: const Alignment(
                  0.0, 0.8), // 0.8 looks better than the geometrical 0.33.
              child: _buildCircleChild(index,
                  oldState && widget.steps[index].state != StepState.error),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(int index) {
    if (widget.steps[index].state != _oldStates[index]) {
      return AnimatedCrossFade(
        firstChild: _buildCircle(index, true),
        secondChild: _buildTriangle(index, true),
        firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.fastOutSlowIn,
        crossFadeState: widget.steps[index].state == StepState.error
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: kThemeAnimationDuration,
      );
    } else {
      if (widget.steps[index].state != StepState.error) {
        return _buildCircle(index, false);
      } else {
        return _buildTriangle(index, false);
      }
    }
  }

  Widget _buildVerticalControls(int stepIndex) {
    if (widget.controlsBuilder != null) {
      return widget.controlsBuilder!(
        context,
        ControlsDetails(
          currentStep: widget.currentStep,
          onStepContinue: widget.onStepContinue,
          onStepCancel: widget.onStepCancel,
          stepIndex: stepIndex,
        ),
      );
    }

    final Color cancelColor;
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        cancelColor = Colors.black54;
        break;
      case Brightness.dark:
        cancelColor = Colors.white70;
        break;
    }

    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    const OutlinedBorder buttonShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)));
    const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 16.0);

    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 48.0),
        child: Row(
          // The Material spec no longer includes a Stepper widget. The continue
          // and cancel button styles have been configured to match the original
          // version of this widget.
          children: <Widget>[
            TextButton(
              onPressed: widget.onStepContinue,
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled)
                      ? null
                      : (_isDark()
                          ? colorScheme.onSurface
                          : colorScheme.onPrimary);
                }),
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return _isDark() || states.contains(MaterialState.disabled)
                      ? null
                      : colorScheme.primary;
                }),
                padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
                    buttonPadding),
                shape:
                    const MaterialStatePropertyAll<OutlinedBorder>(buttonShape),
              ),
              child: Text(localizations.continueButtonLabel),
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(start: 8.0),
              child: TextButton(
                onPressed: widget.onStepCancel,
                style: TextButton.styleFrom(
                  primary: cancelColor,
                  padding: buttonPadding,
                  shape: buttonShape,
                ),
                child: Text(localizations.cancelButtonLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _titleStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    assert(widget.steps[index].state != null);
    switch (widget.steps[index].state) {
      case StepState.indexed:
      case StepState.editing:
      case StepState.complete:
        return textTheme.bodyText1!;
      case StepState.disabled:
        return textTheme.bodyText1!.copyWith(
          color: _isDark() ? _kDisabledDark : _kDisabledLight,
        );
      case StepState.error:
        return textTheme.bodyText1!.copyWith(
          color: _isDark() ? _kErrorDark : _kErrorLight,
        );
    }
  }

  TextStyle _subtitleStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    assert(widget.steps[index].state != null);
    switch (widget.steps[index].state) {
      case StepState.indexed:
      case StepState.editing:
      case StepState.complete:
        return textTheme.caption!;
      case StepState.disabled:
        return textTheme.caption!.copyWith(
          color: _isDark() ? _kDisabledDark : _kDisabledLight,
        );
      case StepState.error:
        return textTheme.caption!.copyWith(
          color: _isDark() ? _kErrorDark : _kErrorLight,
        );
    }
  }

  TextStyle _labelStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    assert(widget.steps[index].state != null);
    switch (widget.steps[index].state) {
      case StepState.indexed:
      case StepState.editing:
      case StepState.complete:
        return textTheme.bodyText1!;
      case StepState.disabled:
        return textTheme.bodyText1!.copyWith(
          color: _isDark() ? _kDisabledDark : _kDisabledLight,
        );
      case StepState.error:
        return textTheme.bodyText1!.copyWith(
          color: _isDark() ? _kErrorDark : _kErrorLight,
        );
    }
  }

  Widget _buildHeaderText(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedDefaultTextStyle(
          style: _titleStyle(index),
          duration: kThemeAnimationDuration,
          curve: Curves.fastOutSlowIn,
          child: widget.steps[index].title,
        ),
        if (widget.steps[index].subtitle != null)
          Container(
            margin: const EdgeInsets.only(top: 2.0),
            child: AnimatedDefaultTextStyle(
              style: _subtitleStyle(index),
              duration: kThemeAnimationDuration,
              curve: Curves.fastOutSlowIn,
              child: widget.steps[index].subtitle!,
            ),
          ),
      ],
    );
  }

  Widget _buildLabelText(int index) {
    if (widget.steps[index].label != null) {
      return AnimatedDefaultTextStyle(
        style: _labelStyle(index),
        duration: kThemeAnimationDuration,
        child: widget.steps[index].label!,
      );
    }
    return const SizedBox();
  }

  Widget _buildVerticalHeader(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              // Line parts are always added in order for the ink splash to
              // flood the tips of the connector lines.
              _buildLine(!_isFirst(index)),
              _buildIcon(index),
              _buildLine(!_isLast(index)),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsetsDirectional.only(start: 12.0),
              child: _buildHeaderText(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalBody(int index) {
    return Stack(
      children: <Widget>[
        PositionedDirectional(
          start: 24.0,
          top: 0.0,
          bottom: 0.0,
          child: SizedBox(
            width: 24.0,
            child: Center(
              child: SizedBox(
                width: _isLast(index) ? 0.0 : 1.0,
                child: Container(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: Container(height: 0.0),
          secondChild: Container(
            margin: widget.margin ??
                const EdgeInsetsDirectional.only(
                  start: 60.0,
                  end: 24.0,
                  bottom: 24.0,
                ),
            child: Column(
              children: <Widget>[
                widget.steps[index].content,
                _buildVerticalControls(index),
              ],
            ),
          ),
          firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
          secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
          sizeCurve: Curves.fastOutSlowIn,
          crossFadeState: _isCurrent(index)
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: kThemeAnimationDuration,
        ),
      ],
    );
  }

  Widget _buildVertical() {
    return ListView(
      shrinkWrap: true,
      physics: widget.physics,
      children: <Widget>[
        for (int i = 0; i < widget.steps.length; i += 1)
          Column(
            key: _keys[i],
            children: <Widget>[
              InkWell(
                onTap: widget.steps[i].state != StepState.disabled
                    ? () {
                        // In the vertical case we need to scroll to the newly tapped
                        // step.
                        Scrollable.ensureVisible(
                          _keys[i].currentContext!,
                          curve: Curves.fastOutSlowIn,
                          duration: kThemeAnimationDuration,
                        );

                        widget.onStepTapped?.call(i);
                      }
                    : null,
                canRequestFocus: widget.steps[i].state != StepState.disabled,
                child: _buildVerticalHeader(i),
              ),
              _buildVerticalBody(i),
            ],
          ),
      ],
    );
  }

  Widget _buildHorizontal() {
    final List<Widget> children = <Widget>[
      for (int i = 0; i < widget.steps.length; i += 1) ...<Widget>[
        InkResponse(
          onTap: widget.steps[i].state != StepState.disabled
              ? () {
                  widget.onStepTapped?.call(i);
                }
              : null,
          canRequestFocus: widget.steps[i].state != StepState.disabled,
          child: Row(
            children: <Widget>[
              SizedBox(
                height: _isLabel() ? 104.0 : 72.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (widget.steps[i].label != null)
                      const SizedBox(
                        height: 24.0,
                      ),
                    Center(child: _buildIcon(i)),
                    if (widget.steps[i].label != null)
                      SizedBox(
                        height: 24.0,
                        child: _buildLabelText(i),
                      ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(start: 12.0),
                child: _buildHeaderText(i),
              ),
            ],
          ),
        ),
        if (!_isLast(i))
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              height: 1.0,
              color: Colors.grey.shade400,
            ),
          ),
      ],
    ];

    final List<Widget> stepPanels = <Widget>[];
    for (int i = 0; i < widget.steps.length; i += 1) {
      stepPanels.add(
        Visibility(
          maintainState: true,
          visible: i == widget.currentStep,
          child: widget.steps[i].content,
        ),
      );
    }

    return Column(
      children: <Widget>[
        Material(
          elevation: widget.elevation ?? 2,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: children,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            physics: widget.physics,
            padding: EdgeInsets.only(top: 0),
            //padding: const EdgeInsets.all(24.0),
            children: <Widget>[
              AnimatedSize(
                curve: Curves.fastOutSlowIn,
                duration: kThemeAnimationDuration,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: stepPanels),
              ),
              _buildVerticalControls(widget.currentStep),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(() {
      if (context.findAncestorWidgetOfExactType<Stepper>() != null) {
        throw FlutterError(
          'Steppers must not be nested.\n'
          'The material specification advises that one should avoid embedding '
          'steppers within steppers. '
          'https://material.io/archive/guidelines/components/steppers.html#steppers-usage',
        );
      }
      return true;
    }());
    assert(widget.type != null);
    switch (widget.type) {
      case StepperType.vertical:
        return _buildVertical();
      case StepperType.horizontal:
        return _buildHorizontal();
    }
  }
}

// Paints a triangle whose base is the bottom of the bounding rectangle and its
// top vertex the middle of its top.
class _TrianglePainter extends CustomPainter {
  _TrianglePainter({
    required this.color,
  });

  final Color color;

  @override
  bool hitTest(Offset point) => true; // Hitting the rectangle is fine enough.

  @override
  bool shouldRepaint(_TrianglePainter oldPainter) {
    return oldPainter.color != color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double base = size.width;
    final double halfBase = size.width / 2.0;
    final double height = size.height;
    final List<Offset> points = <Offset>[
      Offset(0.0, height),
      Offset(base, height),
      Offset(halfBase, 0.0),
    ];

    canvas.drawPath(
      Path()..addPolygon(points, true),
      Paint()..color = color,
    );
  }
}
