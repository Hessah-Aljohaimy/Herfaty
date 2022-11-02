import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:herfaty/screens/navOwner.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/pages/login.dart';
import 'package:herfaty/profile%20screens/ShopOwnerProfile.dart';
import 'package:image_picker/image_picker.dart';

class ShopOwnerEditProfile extends StatefulWidget {
  const ShopOwnerEditProfile(
      this.name,
      this.email,
      this.password,
      this.DOB,
      this.phone_number,
      this.shopname,
      this.shopdescription,
      this.uid,
      this.logo,
      this.location);
  final String name;
  final String email;
  final String password;
  final String DOB;
  final String phone_number;
  final String shopname;
  final String shopdescription;
  final String uid;
  final String logo;
  final String location;
  static String newLocation = "";

  @override
  State<ShopOwnerEditProfile> createState() => _ShopOwnerEditProfileState();
}

class _ShopOwnerEditProfileState extends State<ShopOwnerEditProfile> {
  bool isEditied = false;

  get kPrimaryColor => null;
  final ImagePicker _picker = ImagePicker();
  bool showLocalImage = false;
  var uploadImageUrl = ""; //image URL before choose pic
// Firebase storage + ref for pic place
  final storageRef = FirebaseStorage.instance.ref();
  PickedFile? _imageFile;
  File? pickedImage1;
  String loc = "";

  final _formKey = GlobalKey<FormState>();

  TextEditingController _passwordTextController = TextEditingController();

  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _nameTextEditingController = TextEditingController();

  TextEditingController _BODController = TextEditingController();

  TextEditingController _PhoneNumberTextEditingController =
      TextEditingController();

  TextEditingController _shopnameTextEditingController =
      TextEditingController();
  TextEditingController _shoplogoEditingController = TextEditingController();

  TextEditingController _shopdescriptionTextEditingController =
      TextEditingController();
  @override
  void initState() {
    loc = widget.location;
    _passwordTextController.text = widget.password;

    _emailTextEditingController.text = widget.email;
    _nameTextEditingController.text = widget.name;

    _BODController.text = widget.DOB;

    _PhoneNumberTextEditingController.text = widget.phone_number;

    _shopnameTextEditingController.text = widget.shopname;
    _shoplogoEditingController.text = widget.logo;

    _shopdescriptionTextEditingController.text = widget.shopdescription;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime _selectedDate;

    int passlength = widget.password.length;
    String passwordStar = '';

    for (int i = 0; i < passlength; i++) {
      passwordStar = passwordStar + '*';
    }

/** IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ShopOwnerProfile()));
            },
            icon: Icon(Icons.arrow_forward),
          ), */

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("تعديل الحساب",
            style: TextStyle(
              color: Color(0xff51908E),
              fontFamily: "Tajawal",
            )),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Color.fromARGB(255, 39, 141, 134),
        elevation: 3,
        leading: IconButton(
          onPressed: () {
            ShopOwnerEditProfile.newLocation = "";
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ShopOwnerProfile()));
            });
          },
          icon: Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Color(0xff51908E)),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            width: 430,
            // height: 700,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 2,
                ),
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    // decoration: BoxDecoration(
                    //     color: Colors.black,
                    //     image: DecorationImage(
                    //       image: AssetImage('assets/images/BG2.png'),
                    //     )),
                    child: Center(
                      child: imageProfile(widget.logo),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 15,
                // ),
                // Center(
                //   child: Text(
                //     "تعديل بيانات الحرفي",
                //     style: TextStyle(
                //       color: Color.fromARGB(255, 26, 96, 91),
                //       fontWeight: FontWeight.bold,
                //       fontSize: 20,
                //       fontFamily: "Tajawal",
                //     ),
                //   ),
                // ),

                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  width: 350,
                  child: reusableTextFieldShopOwnerName(
                      'اسم الحرفي', false, _nameTextEditingController),
                ),

                // SizedBox(
                //   height: 5,
                // ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  width: 350,
                  child: reusableTextFieldCustomer(
                      "البريد الإلكتروني", false, _emailTextEditingController),
                ),

                SizedBox(
                  height: 12,
                ),
                // Container(
                //   padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                //   width: 350,
                //   child: reusableTextFieldShopOwner(
                //       "تاريخ الميلاد", false, _passwordTextController),
                // ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 33),
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
                          color: Color.fromARGB(188, 26, 96, 91),
                        ),
                        labelText: "تاريخ الميلاد",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 23),
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 26, 96, 91),
                            fontFamily: "Tajawal",
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        fillColor: Colors.white.withOpacity(0.3),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(188, 26, 96, 91),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2, color: Color.fromARGB(255, 26, 96, 91)),
                        ),
                        errorStyle:
                            TextStyle(color: Color.fromARGB(255, 164, 46, 46)),
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
                          false, //set it true, so that user will not able to edit text
                      onTap: () async {
                        // var formatter = DateFormat('dd/MM/yyyy');

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
                                    primary:
                                        Color(0xff51908E), // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate!);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement
                        _BODController.text = formattedDate;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  width: 350,
                  child: reusableTextFieldShopOwner(
                      "رقم الجوال", false, _PhoneNumberTextEditingController),
                ),

                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  width: 350,
                  child: reusableTextFieldShopOwnerName(
                      "اسم المتجر", false, _shopnameTextEditingController),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  width: 350,
                  child: reusableTextFieldDec(
                      "وصف المتجر", _shopdescriptionTextEditingController),
                ),
                Container(
                  margin: EdgeInsets.only(right: 45, bottom: 0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "موقع المتجر",
                      style: TextStyle(
                        //fontSize: 15,
                        color: Color.fromARGB(255, 26, 96, 91),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Tajawal",
                      ),
                    ),
                  ),
                ),
                editOwner(msg: loc),

                SizedBox(
                  height: 20,
                ),

                // Container(
                //   height: 48,
                //   width: 360,
                //   decoration: BoxDecoration(
                //     color: Color.fromARGB(255, 255, 255, 255),
                //     borderRadius: BorderRadius.all(Radius.circular(10)),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.5),
                //         spreadRadius: 2,
                //         blurRadius: 7,
                //         offset: Offset(0, 3), // changes position of shadow
                //       ),
                //     ],
                //   ),
                //   child: Center(
                //       child: Form(
                //     key: _formKey,
                //     child: Column(
                //       children: [
                //         // Text(
                //         //   'اسم المشتري ',
                //         //   style: TextStyle(
                //         //     color: Color.fromARGB(255, 26, 96, 91),
                //         //     fontWeight: FontWeight.w800,
                //         //     fontSize: 17,
                //         //     fontFamily: "Tajawal",
                //         //   ),
                //         // ),
                //         // Container(
                //         //   child: TextFormField(),
                //         // )
                //       ],
                //     ),
                //   )),
                // ),
                // ListView.builder(
                //                 scrollDirection: Axis.vertical,
                //                 shrinkWrap: true,
                //                 itemCount: titles.length,
                //                 itemBuilder: (context, index) {} ,

                //             ),

                Row(
                  children: [
                    // Expanded(
                    //   child: Row(children: [

                    SizedBox(
                      width: 34,
                    ),

                    ElevatedButton(
                      onPressed: () {
                        if (_nameTextEditingController.text != widget.name ||
                            _BODController.text != widget.DOB ||
                            _PhoneNumberTextEditingController.text !=
                                widget.phone_number ||
                            _shopnameTextEditingController.text !=
                                widget.shopname ||
                            _shopdescriptionTextEditingController.text !=
                                widget.shopdescription) {
                          final docShopOwner = FirebaseFirestore.instance
                              .collection('shop_owner')
                              .doc(widget.uid);
                          if (uploadImageUrl == "") {
                            uploadImageUrl = widget.logo;
                          }

                          if (ShopOwnerEditProfile.newLocation == "") {
                            ShopOwnerEditProfile.newLocation = widget.location;
                          }

                          print(widget.uid);
                          //update this spesific feild
                          docShopOwner.update({
                            'DOB': _BODController.text,
                            'email': widget.email,
                            'id': widget.uid,
                            'logo': uploadImageUrl,
                            'name': _nameTextEditingController.text,
                            'password': widget.password,
                            'phone_number':
                                _PhoneNumberTextEditingController.text,
                            'shopdescription':
                                _shopdescriptionTextEditingController.text,
                            'shopname': _shopnameTextEditingController.text,
                            'location': ShopOwnerEditProfile.newLocation,
                          });

                          ShopOwnerEditProfile.newLocation = "";

                          Fluttertoast.showToast(
                            msg: "تم تحديث حسابك بنجاح",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Color.fromARGB(255, 26, 96, 91),
                            textColor: Colors.white,
                            fontSize: 18.0,
                          );
                          // openPasswordDialog(context);

                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShopOwnerProfile()));
                          });
                        } else {
                          //ShopOwnerEditProfile.newLocation = "";
                          Fluttertoast.showToast(
                            msg: "لم يتم تعديل بيانات الحساب",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Color.fromARGB(255, 156, 30, 21),
                            textColor: Colors.white,
                            fontSize: 18.0,
                          );
                        }
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ShopOwnerProfile()));
                        //Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff51908E)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 55, vertical: 13)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27))),
                      ),
                      child: Text(
                        " حفظ ",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Tajawal",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    checkingButton(),
                    ElevatedButton(
                      onPressed: () async {
                        // Diolog to enter the password
                        if (_nameTextEditingController.text != widget.name ||
                            _BODController.text != widget.DOB ||
                            _PhoneNumberTextEditingController.text !=
                                widget.phone_number ||
                            _shopnameTextEditingController.text !=
                                widget.shopname ||
                            _shopdescriptionTextEditingController.text !=
                                widget.shopdescription) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context1) {
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
                                        width: 250,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          fit: BoxFit.scaleDown,
                                          image: AssetImage(
                                              'assets/images/erase.png'),
                                        )),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                        child: Text(
                                      'سيتم إلغاء التعديلات',
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
                                    child: Text("تراجع"),
                                    onPressed: () {
                                      Navigator.of(context1).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("إلغاء",
                                        style: TextStyle(color: Colors.red)),
                                    onPressed: () {
                                      ShopOwnerEditProfile.newLocation = "";
                                      Navigator.of(context1).pop();
                                      Navigator.of(context).pop();
                                      //The logic of cancle edits
                                      // imageProfile(widget.logo);
                                      // _nameTextEditingController
                                      //   ..text = widget.name;
                                      // _BODController..text = widget.DOB;
                                      // _PhoneNumberTextEditingController
                                      //   ..text = widget.phone_number;
                                      // _shopdescriptionTextEditingController
                                      //   ..text = widget.shopdescription;
                                      // _shopnameTextEditingController
                                      //   ..text = widget.shopname;
                                      // Navigator.of(context).pop();

                                      //Navigator.of(context).pop();
                                      // FirebaseAuth.instance.signOut();
                                      // Navigator.of(context, rootNavigator: true)
                                      //     .pushReplacement(MaterialPageRoute(
                                      //         builder: (context) => new Welcome()));
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "لم يتم تعديل بيانات الحساب",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Color.fromARGB(255, 156, 30, 21),
                            textColor: Colors.white,
                            fontSize: 18.0,
                          );
                        }

                        // showDialog(
                        //   context: context,
                        //   builder: (BuildContext context1) {
                        //     return AlertDialog(
                        //       title: Text("تنبيه"),
                        //       content: Text('سيتم إلغاء التعديلات'),
                        //       actions: <Widget>[
                        //         TextButton(
                        //           child: Text("إلغاء",
                        //               style: TextStyle(color: Colors.red)),
                        //           onPressed: () {
                        //             Navigator.of(context1).pop();
                        //             Navigator.of(context).pop();
                        //             //The logic of cancle edits
                        //             // imageProfile(widget.logo);
                        //             // _nameTextEditingController
                        //             //   ..text = widget.name;
                        //             // _BODController..text = widget.DOB;
                        //             // _PhoneNumberTextEditingController
                        //             //   ..text = widget.phone_number;
                        //             // _shopdescriptionTextEditingController
                        //             //   ..text = widget.shopdescription;
                        //             // _shopnameTextEditingController
                        //             //   ..text = widget.shopname;
                        //             // Navigator.of(context).pop();

                        //             //Navigator.of(context).pop();
                        //             // FirebaseAuth.instance.signOut();
                        //             // Navigator.of(context, rootNavigator: true)
                        //             //     .pushReplacement(MaterialPageRoute(
                        //             //         builder: (context) => new Welcome()));
                        //           },
                        //         ),
                        //         TextButton(
                        //           child: Text("تراجع"),
                        //           onPressed: () {
                        //             Navigator.of(context1).pop();
                        //           },
                        //         )
                        //       ],
                        //     );
                        //   },
                        // );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff51908E)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 55, vertical: 13)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27))),
                      ),
                      child: Text(
                        "إلغاء",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Tajawal",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //   ]),
                    // )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField reusableTextFieldShopOwner(
      String text, bool isPasswordType, TextEditingController controller) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      style: TextStyle(
          color: Color.fromARGB(255, 90, 90, 90), fontFamily: "Tajawal"),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 1.0, horizontal: 25),
        labelText: text,
        labelStyle: TextStyle(
            color: Color.fromARGB(255, 26, 96, 91),
            fontFamily: "Tajawal",
            fontSize: 20,
            fontWeight: FontWeight.bold),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: Colors.white.withOpacity(0.3),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(188, 26, 96, 91),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color.fromARGB(188, 26, 96, 91),
          ),
        ),
        errorStyle: TextStyle(color: Color.fromARGB(255, 164, 46, 46)),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 3, color: Color.fromARGB(255, 164, 46, 46)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "أدخل " + text;
        }
        if (!RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                .hasMatch(value) &&
            !isPasswordType &&
            text == 'البريد الإلكتروني') {
          return 'أدخل بريد إلكتروني صحيح';
        }

        if (text == "كلمة المرور") {
          if (value.length < 6) return "ادخل كلمة مرور اكبر من 6 خانات";
        }
        if (value.trim().isEmpty) {
          return "أدخل " + text + " صحيح";
        }
        // if (text == "اسم المشتري")
        //   maxLength:
        //   30;
      },
    );
  }

  TextFormField reusableTextFieldShopOwnerName(
      String text, bool isPasswordType, TextEditingController controller) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      style: TextStyle(
          color: Color.fromARGB(255, 90, 90, 90), fontFamily: "Tajawal"),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 1.0, horizontal: 25),
        labelText: text,
        labelStyle: TextStyle(
            color: Color.fromARGB(255, 26, 96, 91),
            fontFamily: "Tajawal",
            fontSize: 20,
            fontWeight: FontWeight.bold),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: Colors.white.withOpacity(0.3),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(188, 26, 96, 91),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color.fromARGB(188, 26, 96, 91),
          ),
        ),
        errorStyle: TextStyle(color: Color.fromARGB(255, 164, 46, 46)),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 3, color: Color.fromARGB(255, 164, 46, 46)),
        ),
      ),
      maxLength: 30,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "أدخل " + text;
        }
        //RegExp(r"\s\s")
        if (value.trim().isEmpty) {
          return "أدخل " + text + " صحيح";
        }
      },
    );
  }

  Widget imageProfile(String logo) {
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
        Positioned(
          bottom: 12.0,
          right: 15.0,
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
              size: 25.0,
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
        var pickedImage1 = File(file1.path);
        showLocalImage = true;

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

  //////////////////////////// Shop description Text form ////////////////////////////////
  TextFormField reusableTextFieldDec(
      String text, TextEditingController controller) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      minLines: text == "وصف المتجر" ? 3 : 1,
      maxLines: text == "وصف المتجر" ? 3 : 1,
      maxLength: 160,
      style: TextStyle(
          color: Color.fromARGB(255, 90, 90, 90), fontFamily: "Tajawal"),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        labelText: text,
        labelStyle: TextStyle(
            color: Color.fromARGB(255, 26, 96, 91),
            fontFamily: "Tajawal",
            fontSize: 20,
            fontWeight: FontWeight.bold),
        fillColor: Colors.white.withOpacity(0.3),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(188, 26, 96, 91),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color.fromARGB(188, 26, 96, 91),
          ),
        ),
        errorStyle: TextStyle(color: Color.fromARGB(255, 164, 46, 46)),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 2, color: Color.fromARGB(255, 164, 46, 46)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "أدخل " + text;
        }

        if (value.length < 6) {
          if (value.length < 6) return "أدخل وصف للمنتج لا يقل عن 6 خانات";
        }
        if (value.trim().isEmpty) {
          return "أدخل " + text + " صحيح";
        }

        return null;
      },
    );
  }

  TextFormField reusableTextFieldCustomer(
      String text, bool isPasswordType, TextEditingController controller) {
    return TextFormField(
      enabled: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      style: TextStyle(
          color: Color.fromARGB(255, 122, 122, 122), fontFamily: "Tajawal"),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 1.0, horizontal: 25),
        labelText: text,
        labelStyle: TextStyle(
            color: Color.fromARGB(255, 122, 122, 122),
            fontFamily: "Tajawal",
            fontSize: 20,
            fontWeight: FontWeight.bold),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: Colors.white.withOpacity(0.3),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 122, 122, 122),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.blue),
        ),
        errorStyle: TextStyle(color: Color.fromARGB(255, 164, 46, 46)),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 3, color: Color.fromARGB(255, 164, 46, 46)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "أدخل " + text;
        }
        if (!RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                .hasMatch(value) &&
            !isPasswordType &&
            text == 'البريد الإلكتروني') {
          return 'أدخل بريد إلكتروني صحيح';
        }

        if (text == "كلمة المرور") {
          if (value.length < 6) return "ادخل كلمة مرور اكبر من 6 خانات";
        }
        // if (text == "اسم المشتري")
        //   maxLength:
        //   30;
      },
    );
  }

  Widget checkingButton() {
    if (_nameTextEditingController.text != widget.name ||
        _BODController.text != widget.DOB ||
        _PhoneNumberTextEditingController.text != widget.phone_number ||
        _shopnameTextEditingController.text != widget.shopname ||
        _shopdescriptionTextEditingController.text != widget.shopdescription) {}
    return Container();
  }
}

class editOwner extends StatefulWidget {
  String msg;
  editOwner({Key? key, required msg})
      : this.msg = msg,
        super(key: key);
  @override
  _editOwnerState createState() => _editOwnerState();
}

class _editOwnerState extends State<editOwner> {
  String msgButton = "اضغط هنا لتعديل الموقع";
  Color color = new Color(0xff51908E);
  Color msgcoloredit = Color.fromARGB(255, 90, 90, 90);
  Color Tcolor = new Color.fromARGB(255, 255, 255, 255);
  TextDecoration t = TextDecoration.none;
  String m = "";

  @override
  void initState() {
    m = widget.msg;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 80,
      margin: EdgeInsets.only(left: 1.0, right: 1.0, bottom: 5.0),
      //padding: EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff51908E), width: 1),
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
              padding: const EdgeInsets.only(right: 19.0, top: 5, bottom: 5),
              child: Text(
                m,
                style: TextStyle(
                  //fontSize: 15,
                  color: msgcoloredit,
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
            height: 80,
            width: 120,
            //margin: EdgeInsets.only(left: 8.0, top: 2.0, bottom: 2.0),
            child: ElevatedButton(
              child: Text(
                msgButton,
                textAlign: TextAlign.center,
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
            //if (mounted)
            setState(() {
              if (result.formattedAddress == null) {
                //widget.msg = 'ادخل الموقع';
              } else {
                m = result.formattedAddress!;
                ShopOwnerEditProfile.newLocation = result.formattedAddress!;
                //msgButton = "تم تعديل الموقع";
                color = Colors.transparent;
                Tcolor = Color.fromARGB(255, 8, 24, 246);
                t = TextDecoration.underline;
                msgButton = "اضغط لتغيير الموقع";
                msgcoloredit = Color.fromARGB(255, 90, 90, 90);
              }
            });
          },
          initialPosition: kInitialPosition,
          useCurrentLocation: true,
        ),
      ),
    );
  }

  _changeFormat() {
    msgButton = "اضغط هنا لتعديل الموقع";
    color = new Color(0xff51908E);
    Tcolor = new Color.fromARGB(255, 255, 255, 255);
    t = TextDecoration.none;
  }
}
