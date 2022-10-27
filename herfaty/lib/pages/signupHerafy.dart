import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/pages/login.dart';
import 'package:herfaty/pages/reusable_widgets.dart';
import 'package:herfaty/pages/welcomeRegestration.dart';
import 'package:herfaty/screens/navOwner.dart';

import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:herfaty/firestore/firestore.dart';
// ignore_for_file: file_names, prefer_const_constructors

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
              child: Column(
                children: [
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
                    // width: 290,
                    // height: 53,
                    // padding: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: reusableTextFieldForName(
                        "اسم الحرفي", Icons.person, _nameTextEditingController),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // width: 290,
                    // height: 53,
                    // padding: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.symmetric(horizontal: 60),
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
                    // width: 290,
                    // height: 53,
                    // padding: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: reusableTextField("كلمة المرور", Icons.lock, true,
                        _passwordTextController),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 110),
                    child: Text(
                      " كلمه المرور يجب ان لا تقل عن 6 خانات",
                      style: TextStyle(
                          color: Color.fromARGB(255, 84, 84, 84), fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 60),
                      child: Center(
                          child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          labelStyle:
                              TextStyle(color: Color.fromARGB(106, 26, 96, 91)),
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
                          DateTime initYear = DateTime(today.year - 15, 1, 1);
                          DateTime lastYear = DateTime(today.year - 5, 12, 31);

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
                                    primary: Color(0xff51908E), // <-- SEE HERE
                                    onPrimary: Colors.white, // <-- SEE HERE
                                    onSurface: Colors.black, // <-- SEE HERE
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

                          if (pickedDate != null && pickedDate != todaysDate) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
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
                    // width: 290,
                    // height: 53,
                    // padding: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: reusableTextFieldForPhone("رقم الجوال",
                        Icons.phone_android, _PhoneNumberTextEditingController),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 100),
                    child: Text(
                      "رقم الجوال يجب أن يبدأ بـ(05) لعشرة أرقام",
                      style: TextStyle(
                          color: Color.fromARGB(255, 86, 86, 86), fontSize: 13),
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
              child: Column(
                children: [
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
                    // width: 290,
                    // height: 53,
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: reusableTextFieldForShopName(
                        "اسم المتجر", _shopnameTextEditingController),
                  ),

                  SizedBox(
                    height: 8,
                  ),

                  Container(
                    // width: 290,
                    // height: 53,
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: reusableTextFieldDec(
                        "وصف المتجر", _shopdescriptionTextEditingController),
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  Text(
                    "هيا لتبدأ رحلتك!",
                    style: TextStyle(fontFamily: 'Tajawal', fontSize: 18),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      try {
                        //uploadImageUrl
                        if (formKeys[0].currentState!.validate() &&
                            formKeys[1].currentState!.validate()) {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _emailTextEditingController.text,
                                  password: _passwordTextController.text)
                              .then((value) {
                            final shopowner = ShopOwner(
                                name: _nameTextEditingController.text,
                                email: _emailTextEditingController.text,
                                password: _passwordTextController.text,
                                DOB: _BODController.text,
                                phone_number:
                                    _PhoneNumberTextEditingController.text,
                                logo: uploadImageUrl,
                                shopname: _shopnameTextEditingController.text,
                                shopdescription:
                                    _shopdescriptionTextEditingController.text,
                                points: 0);
                            Fluttertoast.showToast(
                              msg: "تم تسجيل حسابك  بنجاح",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Color.fromARGB(255, 26, 96, 91),
                              textColor: Colors.white,
                              fontSize: 18.0,
                            );
                            createShopOwner(shopowner);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const navOwner()),
                            );
                          });
                        }
                      } on FirebaseAuthException catch (error) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("خطأ"),
                                content: Text('البريد الإلكتروني موجود مسبقا'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("حسنا"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff51908E)),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 90, vertical: 13)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
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
            ))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: ThemeData(
            colorScheme:
                ColorScheme.light(primary: Color.fromARGB(255, 26, 96, 91))),
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
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  if (currentStep == 0)
                    Expanded(
                      child: ElevatedButton(
                        child: Text('التالي'),
                        onPressed: controls.onStepContinue,
                      ),
                    ),
                  const SizedBox(
                    width: 12,
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
}

//Datebase
Future createShopOwner(ShopOwner shopowner) async {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final User? user = auth.currentUser;
  final uid = user!.uid;
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
