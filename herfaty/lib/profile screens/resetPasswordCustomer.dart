import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/pages/signupCustomer.dart';
import 'package:herfaty/widgets/customerSettings.dart';
import 'package:herfaty/widgets/logOut.dart';

class ResetPasswordCustomer extends StatefulWidget {
  const ResetPasswordCustomer({super.key});

  @override
  State<ResetPasswordCustomer> createState() => _ResetPasswordCustomerState();
}

class _ResetPasswordCustomerState extends State<ResetPasswordCustomer> {
  bool ishiddenpasswordold = true;
  bool ishiddenpasswordnew1 = true;
  bool ishiddenpasswordnew2 = true;
  //Define snapshot

  TextEditingController _oldPasswordTextController = TextEditingController();
  TextEditingController _newPasswordTextController1 = TextEditingController();
  TextEditingController _newPasswordTextController2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // getData();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

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
                builder: (BuildContext context) => CustomerSettings()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Color(0xff51908E)),
      ),
      body: FutureBuilder<Customer?>(
          future: readUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              print('333333333333333333333333333333333333333333333');
              return Center(
                  child: Text(
                      '!هناك خطأ في استرجاع البيانات${snapshot.hasError}'));
            }
            if (!snapshot.hasData) {
              print('2222222222222222222222222222222222222222222222');
              // return Center(child: Text('!  11خطأ في عرض البيانات '));
              return Center(child: CircularProgressIndicator());
            }

            // if (!snapshot.hasData) {
            //   print('2222222222222222222222222222222222222222222222');
            //   return Center(child: Text('! خطأ في عرض البيانات '));
            // }
            if (snapshot.hasData) {
              print('4444444444444444444444444444444444444444');

              final customer = snapshot.data;
              return customer == null
                  ? const Center(child: Text('!لا توجد معلومات المشتري '))
                  : buildCustomer(customer, context);
            } else {
              return Center(child: Text("! هناك مشكلة ما حاول مجددا"));
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

      //               //is it the same as the old one ?

      //               // if(value){

      //               // }
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
      //                 final docCustomer = FirebaseFirestore.instance
      //                     .collection('customers')
      //                     .doc(uid);
      //                 // final docCustomer = FirebaseFirestore.instance
      //                 //     .collection('customers')
      //                 //     .doc(uid);
      //                 FirebaseAuth.instance.currentUser
      //                     ?.updatePassword(_newPasswordTextController1.text);

      //                 docCustomer.update({
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

  Future<Customer?> readUser() async {
    print("go here ---------------------------");
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    print("----------------------------$uid");

    final docCustomer =
        await FirebaseFirestore.instance.collection('customers').doc(uid).get();
    print('after the refrence');

    if (docCustomer.exists) {
      print("SSSSSSSSSSSSSSSSSSNNNNNNNNNNNNNNNNAAAAAAAAAAAAAAAAAAPPPPPPPPPPP");
      return Customer.fromJson(docCustomer.data()!);
    }
  }

  Widget buildCustomer(Customer customer, BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    String oldpass = customer.password;
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

                    if (value != oldpass) {
                      return "كلمة المرور لا تطابق كلمة المرور المسجلة مسبقا ";
                    }
                    if (value.trim().isEmpty) {
                      return "أدخل " + 'كلمة المرور القديمة' + " صحيح";
                    }
                  },

                  //is it the same as the old one ?
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
                    if (value.trim().isEmpty) {
                      return "أدخل " + 'كلمة المرور الجديدة' + " صحيح";
                    }

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
                    if (value.trim().isEmpty) {
                      return "أدخل " + 'تأكيد كلمة المرور' + " صحيح";
                    }
                  },
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        FocusScope.of(context).requestFocus(new FocusNode());
                        if (_formKey.currentState!.validate()) {
                          final docCustomer = FirebaseFirestore.instance
                              .collection('customers')
                              .doc(uid);
                          // final docCustomer = FirebaseFirestore.instance
                          //     .collection('customers')
                          //     .doc(uid);

                          String email = customer.email;
                          String password = customer.password;

                          // Create a credential
                          AuthCredential credential =
                              EmailAuthProvider.credential(
                                  email: email, password: password);

                          // Reauthenticate
                          await FirebaseAuth.instance.currentUser!
                              .reauthenticateWithCredential(credential);

                          FirebaseAuth.instance.currentUser?.updatePassword(
                              _newPasswordTextController1.text);

                          docCustomer.update({
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  logOutButton()));
                        }
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
                        "حفظ",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Tajawal",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_oldPasswordTextController.text != '' &&
                            _newPasswordTextController1.text != '' &&
                            _newPasswordTextController2.text != '') {
                          showDialog(
                            context: context,
                            builder: (BuildContext context1) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                title: Text(
                                  "تنبيه",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 221, 112, 112),
                                    fontFamily: "Tajawal",
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
                                    child: Text("إلغاء",
                                        style: TextStyle(
                                            color: Color(0xff51908E))),
                                    onPressed: () {
                                      //The logic of cancle edits
                                      Navigator.of(context1).pop();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("تراجع"),
                                    onPressed: () {
                                      Navigator.of(context1).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "لم يتم تعديل كلمة المرور",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Color.fromARGB(255, 156, 30, 21),
                            textColor: Colors.white,
                            fontSize: 18.0,
                          );
                        }
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
