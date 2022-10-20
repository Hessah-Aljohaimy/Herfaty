import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/pages/signupHerafy.dart';
import 'package:herfaty/widgets/ownerSettings.dart';

class ResetPasswordOwner extends StatefulWidget {
  const ResetPasswordOwner({super.key});

  @override
  State<ResetPasswordOwner> createState() => _ResetPasswordOwnerState();
}

class _ResetPasswordOwnerState extends State<ResetPasswordOwner> {
  bool ishiddenpasswordold = true;
  bool ishiddenpasswordnew1 = true;
  bool ishiddenpasswordnew2 = true;

  TextEditingController _oldPasswordTextController =
      new TextEditingController();
  TextEditingController _newPasswordTextController1 =
      new TextEditingController();
  TextEditingController _newPasswordTextController2 =
      new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? userSO = auth.currentUser;
    final uid = userSO!.uid;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("إعادة تعيين كلمة المرور",
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => OwnerSettings()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Color(0xff51908E)),
      ),
      body: FutureBuilder<ShopOwner?>(
          future: readUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
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
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              print('11111111111111111111111111111111111111');
              return Center(child: CircularProgressIndicator());
            } else {
              return Text("! هناك مشكلة ما حاول مجددا");
            }
          }),
      // body: Form(
      //   key: _formKey,
      //   child: SingleChildScrollView(
      //     child: Container(
      //       width: 430,
      //       height: 430,
      //       margin: EdgeInsets.only(top: 50),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: <Widget>[
      //           Container(
      //             width: 350,
      //             // child: reusableTextField(
      //             //     'كلمة المرور القديمة', true, _oldPasswordTextController),
      //             child: TextFormField(
      //               autovalidateMode: AutovalidateMode.onUserInteraction,
      //               controller: _oldPasswordTextController,
      //               obscureText: ishiddenpasswordold,
      //               enableSuggestions: false,
      //               autocorrect: false,
      //               keyboardType: TextInputType.visiblePassword,
      //               style: TextStyle(
      //                   color: Color.fromARGB(255, 90, 90, 90),
      //                   fontFamily: "Tajawal"),
      //               decoration: InputDecoration(
      //                 contentPadding: const EdgeInsets.symmetric(
      //                     vertical: 1.0, horizontal: 25),
      //                 labelText: 'كلمة المرور القديمة',
      //                 labelStyle: TextStyle(
      //                     color: Color.fromARGB(255, 26, 96, 91),
      //                     fontFamily: "Tajawal",
      //                     fontSize: 20,
      //                     fontWeight: FontWeight.bold),
      //                 floatingLabelBehavior: FloatingLabelBehavior.always,
      //                 fillColor: Colors.white.withOpacity(0.3),
      //                 enabledBorder: OutlineInputBorder(
      //                   borderSide: BorderSide(
      //                     color: Color.fromARGB(188, 26, 96, 91),
      //                   ),
      //                 ),
      //                 focusedBorder: OutlineInputBorder(
      //                   borderSide: BorderSide(width: 2, color: Colors.blue),
      //                 ),
      //                 errorStyle:
      //                     TextStyle(color: Color.fromARGB(255, 164, 46, 46)),
      //                 errorBorder: OutlineInputBorder(
      //                   borderSide:
      //                       BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
      //                 ),
      //                 focusedErrorBorder: OutlineInputBorder(
      //                   borderSide: BorderSide(
      //                       width: 3, color: Color.fromARGB(255, 164, 46, 46)),
      //                 ),
      //                 suffixIcon: InkWell(
      //                   onTap: _togglePasswordViewOld,
      //                   child: Icon(
      //                     ishiddenpasswordold
      //                         ? Icons.visibility
      //                         : Icons.visibility_off,
      //                   ),
      //                 ),
      //               ),
      //               validator: (value) {
      //                 if (value == null || value.isEmpty) {
      //                   return "أدخل " + 'كلمة المرور القديمة';
      //                 }

      //                 if (value.length < 6)
      //                   return "ادخل كلمة مرور اكبر من 6 خانات";
      //               },
      //             ),
      //           ),
      //           SizedBox(
      //             height: 25,
      //           ),
      //           Container(
      //             width: 350,
      //             // child: reusableTextField(
      //             //     'كلمة المرور الجديدة', true, _newPasswordTextController1),

      //             child: TextFormField(
      //               autovalidateMode: AutovalidateMode.onUserInteraction,
      //               controller: _newPasswordTextController1,
      //               obscureText: ishiddenpasswordnew1,
      //               enableSuggestions: false,
      //               autocorrect: false,
      //               keyboardType: TextInputType.visiblePassword,
      //               style: TextStyle(
      //                   color: Color.fromARGB(255, 90, 90, 90),
      //                   fontFamily: "Tajawal"),
      //               decoration: InputDecoration(
      //                 contentPadding: const EdgeInsets.symmetric(
      //                     vertical: 1.0, horizontal: 25),
      //                 labelText: 'كلمة المرور الجديدة',
      //                 labelStyle: TextStyle(
      //                     color: Color.fromARGB(255, 26, 96, 91),
      //                     fontFamily: "Tajawal",
      //                     fontSize: 20,
      //                     fontWeight: FontWeight.bold),
      //                 floatingLabelBehavior: FloatingLabelBehavior.always,
      //                 fillColor: Colors.white.withOpacity(0.3),
      //                 enabledBorder: OutlineInputBorder(
      //                   borderSide: BorderSide(
      //                     color: Color.fromARGB(188, 26, 96, 91),
      //                   ),
      //                 ),
      //                 focusedBorder: OutlineInputBorder(
      //                   borderSide: BorderSide(width: 2, color: Colors.blue),
      //                 ),
      //                 errorStyle:
      //                     TextStyle(color: Color.fromARGB(255, 164, 46, 46)),
      //                 errorBorder: OutlineInputBorder(
      //                   borderSide:
      //                       BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
      //                 ),
      //                 focusedErrorBorder: OutlineInputBorder(
      //                   borderSide: BorderSide(
      //                       width: 3, color: Color.fromARGB(255, 164, 46, 46)),
      //                 ),
      //                 suffixIcon: InkWell(
      //                   onTap: _togglePasswordViewNew1,
      //                   child: Icon(
      //                     ishiddenpasswordnew1
      //                         ? Icons.visibility
      //                         : Icons.visibility_off,
      //                   ),
      //                 ),
      //               ),
      //               validator: (value) {
      //                 if (value == null || value.isEmpty) {
      //                   return "أدخل " + 'كلمة المرور الجديدة';
      //                 }

      //                 if (value.length < 6)
      //                   return "ادخل كلمة مرور اكبر من 6 خانات";

      //                 if (_oldPasswordTextController.text ==
      //                     _newPasswordTextController1.text)
      //                   return "كلمة المرور تطابق كلمة المرور القديمة";

      //                 //==============================

      //                 // if (text == 'تأكيد كلمة المرور') {
      //                 //   if (_oldPasswordTextController.text ==
      //                 //       _newPasswordTextController2.text)
      //                 //     return "كلمة المرور تطابق كلمة المرور القديمة";
      //                 // }
      //                 //==============================
      //                 // if (text == 'تأكيد كلمة المرور') {
      //                 //   if (_newPasswordTextController1.text !=
      //                 //       _newPasswordTextController2.text)
      //                 //     return "كلمة المرور غير متطابقة";

      //                 // }
      //               },
      //             ),
      //           ),
      //           SizedBox(
      //             height: 25,
      //           ),
      //           Container(
      //             width: 350,
      //             // child: reusableTextField(
      //             //     'تأكيد كلمة المرور', true, _newPasswordTextController2),
      //             child: TextFormField(
      //               autovalidateMode: AutovalidateMode.onUserInteraction,
      //               controller: _newPasswordTextController2,
      //               obscureText: ishiddenpasswordnew2,
      //               enableSuggestions: false,
      //               autocorrect: false,
      //               keyboardType: TextInputType.visiblePassword,
      //               style: TextStyle(
      //                   color: Color.fromARGB(255, 90, 90, 90),
      //                   fontFamily: "Tajawal"),
      //               decoration: InputDecoration(
      //                 contentPadding: const EdgeInsets.symmetric(
      //                     vertical: 1.0, horizontal: 25),
      //                 labelText: 'تأكيد كلمة المرور',
      //                 labelStyle: TextStyle(
      //                     color: Color.fromARGB(255, 26, 96, 91),
      //                     fontFamily: "Tajawal",
      //                     fontSize: 20,
      //                     fontWeight: FontWeight.bold),
      //                 floatingLabelBehavior: FloatingLabelBehavior.always,
      //                 fillColor: Colors.white.withOpacity(0.3),
      //                 enabledBorder: OutlineInputBorder(
      //                   borderSide: BorderSide(
      //                     color: Color.fromARGB(188, 26, 96, 91),
      //                   ),
      //                 ),
      //                 focusedBorder: OutlineInputBorder(
      //                   borderSide: BorderSide(width: 2, color: Colors.blue),
      //                 ),
      //                 errorStyle:
      //                     TextStyle(color: Color.fromARGB(255, 164, 46, 46)),
      //                 errorBorder: OutlineInputBorder(
      //                   borderSide:
      //                       BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
      //                 ),
      //                 focusedErrorBorder: OutlineInputBorder(
      //                   borderSide: BorderSide(
      //                       width: 3, color: Color.fromARGB(255, 164, 46, 46)),
      //                 ),
      //                 suffixIcon: InkWell(
      //                   onTap: _togglePasswordViewNew2,
      //                   child: Icon(
      //                     ishiddenpasswordnew2
      //                         ? Icons.visibility
      //                         : Icons.visibility_off,
      //                   ),
      //                 ),
      //               ),
      //               validator: (value) {
      //                 if (value == null || value.isEmpty) {
      //                   return "أدخل " + 'تأكيد كلمة المرور';
      //                 }

      //                 if (value.length < 6)
      //                   return "ادخل كلمة مرور اكبر من 6 خانات";

      //                 if (_oldPasswordTextController.text ==
      //                     _newPasswordTextController2.text)
      //                   return "كلمة المرور تطابق كلمة المرور القديمة";

      //                 //==============================

      //                 // if (text == 'تأكيد كلمة المرور') {
      //                 //   if (_oldPasswordTextController.text ==
      //                 //       _newPasswordTextController2.text)
      //                 //     return "كلمة المرور تطابق كلمة المرور القديمة";
      //                 // }
      //                 //==============================

      //                 if (_newPasswordTextController1.text !=
      //                     _newPasswordTextController2.text)
      //                   return "كلمة المرور غير متطابقة";
      //               },
      //             ),
      //           ),
      //           SizedBox(
      //             height: 35,
      //           ),
      //           ElevatedButton(
      //             onPressed: () async {
      //               if (_formKey.currentState!.validate()) {
      //                 final docShopOwner = FirebaseFirestore.instance
      //                     .collection('shop_owner')
      //                     .doc(uid);
      //                 // final docCustomer = FirebaseFirestore.instance
      //                 //     .collection('customers')
      //                 //     .doc(uid);

      //                 FirebaseAuth.instance.currentUser
      //                     ?.updatePassword(_newPasswordTextController1.text);
      //                 docShopOwner.update({
      //                   'password': _newPasswordTextController1.text,
      //                 });

      //                 // if (docCustomer != null) {
      //                 //   docCustomer.update({
      //                 //     'password': _newPasswordTextController1.text,
      //                 //   });
      //                 // }

      //                 Fluttertoast.showToast(
      //                   msg: "تم إعادة تعيين كلمة المرور بنجاح",
      //                   toastLength: Toast.LENGTH_SHORT,
      //                   gravity: ToastGravity.CENTER,
      //                   timeInSecForIosWeb: 3,
      //                   backgroundColor: Color.fromARGB(255, 26, 96, 91),
      //                   textColor: Colors.white,
      //                   fontSize: 18.0,
      //                 );
      //               }
      //             },
      //             style: ButtonStyle(
      //               backgroundColor:
      //                   MaterialStateProperty.all(Color(0xff51908E)),
      //               padding: MaterialStateProperty.all(
      //                   EdgeInsets.symmetric(horizontal: 160, vertical: 13)),
      //               shape: MaterialStateProperty.all(RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(27))),
      //             ),
      //             child: Text(
      //               "حفظ",
      //               style: TextStyle(
      //                   fontSize: 18,
      //                   fontFamily: "Tajawal",
      //                   fontWeight: FontWeight.bold),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  ///Text feild ///
  // TextFormField reusableTextField(
  //     String text, bool isPasswordType, TextEditingController controller) {
  //   return TextFormField(
  //     autovalidateMode: AutovalidateMode.onUserInteraction,
  //     controller: controller,
  //     obscureText: ishiddenpassword,
  //     enableSuggestions: !isPasswordType,
  //     autocorrect: !isPasswordType,
  //     keyboardType: isPasswordType
  //         ? TextInputType.visiblePassword
  //         : TextInputType.emailAddress,
  //     style: TextStyle(
  //         color: Color.fromARGB(255, 90, 90, 90), fontFamily: "Tajawal"),
  //     decoration: InputDecoration(
  //         contentPadding:
  //             const EdgeInsets.symmetric(vertical: 1.0, horizontal: 25),
  //         labelText: text,
  //         labelStyle: TextStyle(
  //             color: Color.fromARGB(255, 26, 96, 91),
  //             fontFamily: "Tajawal",
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold),
  //         floatingLabelBehavior: FloatingLabelBehavior.always,
  //         fillColor: Colors.white.withOpacity(0.3),
  //         enabledBorder: OutlineInputBorder(
  //           borderSide: BorderSide(
  //             color: Color.fromARGB(188, 26, 96, 91),
  //           ),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(width: 2, color: Colors.blue),
  //         ),
  //         errorStyle: TextStyle(color: Color.fromARGB(255, 164, 46, 46)),
  //         errorBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
  //         ),
  //         focusedErrorBorder: OutlineInputBorder(
  //           borderSide:
  //               BorderSide(width: 3, color: Color.fromARGB(255, 164, 46, 46)),
  //         ),
  //         suffixIcon: InkWell(
  //           onTap: _togglePasswordView,
  //           child: Icon(
  //             ishiddenpassword ? Icons.visibility : Icons.visibility_off,
  //           ),
  //         )),
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return "أدخل " + text;
  //       }

  //       if (value.length < 6) return "ادخل كلمة مرور اكبر من 6 خانات";

  //       if (text == 'كلمة المرور الجديدة') {
  //         if (_oldPasswordTextController.text ==
  //             _newPasswordTextController1.text)
  //           return "كلمة المرور تطابق كلمة المرور القديمة";
  //       }

  //       //==============================

  //       if (text == 'تأكيد كلمة المرور') {
  //         if (_oldPasswordTextController.text ==
  //             _newPasswordTextController2.text)
  //           return "كلمة المرور تطابق كلمة المرور القديمة";
  //       }
  //       //==============================
  //       if (text == 'تأكيد كلمة المرور') {
  //         if (_newPasswordTextController1.text !=
  //             _newPasswordTextController2.text)
  //           return "كلمة المرور غير متطابقة";
  //       }
  //     },
  //   );
  void _togglePasswordViewOld() {
    setState(() {
      ishiddenpasswordold = !ishiddenpasswordold;
    });
  }

  void _togglePasswordViewNew1() {
    setState(() {
      ishiddenpasswordnew1 = !ishiddenpasswordnew1;
    });
  }

  void _togglePasswordViewNew2() {
    setState(() {
      ishiddenpasswordnew2 = !ishiddenpasswordnew2;
    });
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
      print("BBBBBBBBBBEGIningggggggggggggggggggggggg ");
      return ShopOwner.fromJson(docShopOwner.data()!);
    }
  }

  Widget buildOwner(ShopOwner shopowner, BuildContext context) {
    //get trying the edit
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    String oldpass = shopowner.password;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          width: 430,
          height: 430,
          margin: EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 350,
                // child: reusableTextField(
                //     'كلمة المرور القديمة', true, _oldPasswordTextController),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _oldPasswordTextController,
                  obscureText: ishiddenpasswordold,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                      color: Color.fromARGB(255, 90, 90, 90),
                      fontFamily: "Tajawal"),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 1.0, horizontal: 25),
                    labelText: 'كلمة المرور القديمة',
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
                    errorStyle:
                        TextStyle(color: Color.fromARGB(255, 164, 46, 46)),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromARGB(255, 164, 46, 46)),
                    ),
                    suffixIcon: InkWell(
                      onTap: _togglePasswordViewOld,
                      child: Icon(
                        ishiddenpasswordold
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color.fromARGB(255, 26, 96, 91),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "أدخل " + 'كلمة المرور القديمة';
                    }

                    if (value.length < 6)
                      return "ادخل كلمة مرور اكبر من 6 خانات";
                    if (value != oldpass) {
                      return "كلمة المرور لا تطابق كلمة المرور المسجلة مسبقا ";
                    }
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: 350,
                // child: reusableTextField(
                //     'كلمة المرور الجديدة', true, _newPasswordTextController1),

                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _newPasswordTextController1,
                  obscureText: ishiddenpasswordnew1,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                      color: Color.fromARGB(255, 90, 90, 90),
                      fontFamily: "Tajawal"),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 1.0, horizontal: 25),
                    labelText: 'كلمة المرور الجديدة',
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
                    errorStyle:
                        TextStyle(color: Color.fromARGB(255, 164, 46, 46)),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromARGB(255, 164, 46, 46)),
                    ),
                    suffixIcon: InkWell(
                      onTap: _togglePasswordViewNew1,
                      child: Icon(
                        ishiddenpasswordnew1
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color.fromARGB(255, 26, 96, 91),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "أدخل " + 'كلمة المرور الجديدة';
                    }

                    if (value.length < 6)
                      return "ادخل كلمة مرور اكبر من 6 خانات";

                    if (_oldPasswordTextController.text ==
                        _newPasswordTextController1.text)
                      return "كلمة المرور تطابق كلمة المرور القديمة";

                    //==============================

                    // if (text == 'تأكيد كلمة المرور') {
                    //   if (_oldPasswordTextController.text ==
                    //       _newPasswordTextController2.text)
                    //     return "كلمة المرور تطابق كلمة المرور القديمة";
                    // }
                    //==============================
                    // if (text == 'تأكيد كلمة المرور') {
                    //   if (_newPasswordTextController1.text !=
                    //       _newPasswordTextController2.text)
                    //     return "كلمة المرور غير متطابقة";

                    // }
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: 350,
                // child: reusableTextField(
                //     'تأكيد كلمة المرور', true, _newPasswordTextController2),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _newPasswordTextController2,
                  obscureText: ishiddenpasswordnew2,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                      color: Color.fromARGB(255, 90, 90, 90),
                      fontFamily: "Tajawal"),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 1.0, horizontal: 25),
                    labelText: 'تأكيد كلمة المرور',
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
                    errorStyle:
                        TextStyle(color: Color.fromARGB(255, 164, 46, 46)),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromARGB(255, 164, 46, 46)),
                    ),
                    suffixIcon: InkWell(
                      onTap: _togglePasswordViewNew2,
                      child: Icon(
                        ishiddenpasswordnew2
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color.fromARGB(255, 26, 96, 91),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "أدخل " + 'تأكيد كلمة المرور';
                    }

                    if (value.length < 6)
                      return "ادخل كلمة مرور اكبر من 6 خانات";

                    if (_oldPasswordTextController.text ==
                        _newPasswordTextController2.text)
                      return "كلمة المرور تطابق كلمة المرور القديمة";

                    //==============================

                    // if (text == 'تأكيد كلمة المرور') {
                    //   if (_oldPasswordTextController.text ==
                    //       _newPasswordTextController2.text)
                    //     return "كلمة المرور تطابق كلمة المرور القديمة";
                    // }
                    //==============================

                    if (_newPasswordTextController1.text !=
                        _newPasswordTextController2.text)
                      return "كلمة المرور غير متطابقة";
                  },
                ),
              ),
              SizedBox(
                height: 35,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final docShopOwner = FirebaseFirestore.instance
                        .collection('shop_owner')
                        .doc(uid);
                    // final docCustomer = FirebaseFirestore.instance
                    //     .collection('customers')
                    //     .doc(uid);

                    String email = shopowner.email;
                    String password = shopowner.password;

// Create a credential
                    AuthCredential credential = EmailAuthProvider.credential(
                        email: email, password: password);

// Reauthenticate
                    await FirebaseAuth.instance.currentUser!
                        .reauthenticateWithCredential(credential);
                    FirebaseAuth.instance.currentUser
                        ?.updatePassword(_newPasswordTextController1.text);
                    docShopOwner.update({
                      'password': _newPasswordTextController1.text,
                    });

                    // if (docCustomer != null) {
                    //   docCustomer.update({
                    //     'password': _newPasswordTextController1.text,
                    //   });
                    // }

                    Fluttertoast.showToast(
                      msg: "تم إعادة تعيين كلمة المرور بنجاح",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Color.fromARGB(255, 26, 96, 91),
                      textColor: Colors.white,
                      fontSize: 18.0,
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff51908E)),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 160, vertical: 13)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27))),
                ),
                child: Text(
                  "حفظ",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Tajawal",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
