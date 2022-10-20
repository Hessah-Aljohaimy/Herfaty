import 'dart:io';
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController _passwordTextController = new TextEditingController()
      ..text = widget.password;

    TextEditingController _emailTextEditingController =
        new TextEditingController()..text = widget.email;
    TextEditingController _nameTextEditingController =
        new TextEditingController()..text = widget.name;

    TextEditingController _BODController = new TextEditingController()
      ..text = widget.DOB;
    DateTime _selectedDate;
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
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Color(0xff51908E)),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            width: 430,
            height: 700,
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

                // SizedBox(
                //   height: 20,
                // ),

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
                      width: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final docShopOwner = FirebaseFirestore.instance
                            .collection('shop_owner')
                            .doc(widget.uid);
                        if (uploadImageUrl == "") {
                          uploadImageUrl = widget.logo;
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

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopOwnerProfile()));
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
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Diolog to enter the password

                        showDialog(
                          context: context,
                          builder: (BuildContext context1) {
                            return AlertDialog(
                              title: Text("تنبيه"),
                              content: Text('سيتم إلغاء التعديلات'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("إلغاء",
                                      style: TextStyle(color: Colors.red)),
                                  onPressed: () {
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
                                TextButton(
                                  child: Text("تراجع"),
                                  onPressed: () {
                                    Navigator.of(context1).pop();
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
      minLines: text == "وصف المتجر" ? 1 : 1,
      maxLines: text == "وصف المتجر" ? 9 : 1,
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
}
