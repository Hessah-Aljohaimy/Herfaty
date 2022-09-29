import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
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
      this.logo);
  final String name;
  final String email;
  final String password;
  final String DOB;
  final String phone_number;
  final String shopname;
  final String shopdescription;
  final String uid;
  final String logo;

  @override
  State<ShopOwnerEditProfile> createState() => _ShopOwnerEditProfileState();
}

class _ShopOwnerEditProfileState extends State<ShopOwnerEditProfile> {
  get kPrimaryColor => null;
  final ImagePicker _picker = ImagePicker();
  bool showLocalImage = false;
  var uploadImageUrl = ""; //image URL before choose pic
// Firebase storage + ref for pic place
  final storageRef = FirebaseStorage.instance.ref();
  PickedFile? _imageFile;
  File? pickedImage1;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _passwordTextController = new TextEditingController();
    TextEditingController _emailTextEditingController =
        new TextEditingController()..text = widget.email;
    TextEditingController _nameTextEditingController =
        new TextEditingController()..text = widget.name;

    TextEditingController _BODController = new TextEditingController()
      ..text = widget.DOB;
    ;
    TextEditingController _PhoneNumberTextEditingController =
        new TextEditingController()..text = widget.phone_number;

    TextEditingController _shopnameTextEditingController =
        new TextEditingController()..text = widget.shopname;
    TextEditingController _shoplogoEditingController =
        new TextEditingController()..text = widget.logo;

    TextEditingController _shopdescriptionTextEditingController =
        new TextEditingController()..text = widget.shopdescription;

    int passlength = widget.password.length;
    String passwordStar = '';

    for (int i = 0; i < passlength; i++) {
      passwordStar = passwordStar + '*';
    }

    final docShopOwner =
        FirebaseFirestore.instance.collection('customers').doc(widget.uid);

/** IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ShopOwnerProfile()));
            },
            icon: Icon(Icons.arrow_forward),
          ), */

    return Scaffold(
      appBar: AppBar(
        title: Text("تعديل الحساب", style: TextStyle(color: Color(0xff51908E))),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Color.fromARGB(255, 39, 141, 134),
        elevation: 3,
        leading: IconButton(
          icon: Icon(Icons.logout, color: Color(0xff51908E)),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => login()));
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ShopOwnerProfile()));
            },
            icon: Icon(Icons.arrow_forward),
          ),
        ],
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Color(0xff51908E)),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: 320,
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/BG2.png'),
                  )),
                  child: Center(
                    child: Column(
                      children: [
                        // imageProfile(shopowner.logo),
                      ],
                    ),
                  ),
                ),
              ),

              // Center(
              //   child: Text(
              //     "تعديل بيانات المشتري",
              //     style: TextStyle(
              //       color: Color.fromARGB(255, 26, 96, 91),
              //       fontWeight: FontWeight.bold,
              //       fontSize: 20,
              //       fontFamily: "Tajawal",
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 35,
              ),
              Container(
                color: Colors.white,
                width: 350,
                child: reusableTextFieldShopOwner(
                    'اسم الحرفي', false, _nameTextEditingController),
              ),

              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                width: 350,
                child: reusableTextFieldShopOwner(
                    "البريد الإلكتروني", false, _emailTextEditingController),
              ),

              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                width: 350,
                child: reusableTextFieldShopOwner(
                    "كلمة المرور", true, _passwordTextController),
              ),

              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                width: 350,
                child: reusableTextFieldShopOwner(
                    "كلمة المرور", true, _passwordTextController),
              ),

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
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: Row(children: [
                      ElevatedButton(
                        onPressed: () {
                          print(widget.uid);
                          //update this spesific feild
                          docShopOwner.update({
                            'email': _emailTextEditingController.text,
                            'id': widget.uid,
                            'name': _nameTextEditingController.text,
                            'password': _passwordTextController.text
                          });
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

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => CustomerEditProfile(
                          //           customer.name,
                          //           customer.email,
                          //           customer.password)),
                          // );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff51908E)),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 55, vertical: 13)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
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
                                content: Text('سيتم إلغاء التعديلات'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("إلغاء",
                                        style: TextStyle(color: Colors.red)),
                                    onPressed: () {
                                      //The logic of deleting an account

                                      //Navigator.of(context).pop();
                                      // FirebaseAuth.instance.signOut();
                                      // Navigator.of(context, rootNavigator: true)
                                      //     .pushReplacement(MaterialPageRoute(
                                      //         builder: (context) => new Welcome()));
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
                              EdgeInsets.symmetric(
                                  horizontal: 55, vertical: 13)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
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
                    ]),
                  )
                ],
              ),
            ],
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
      style:
          TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontFamily: "Tajawal"),
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
}
