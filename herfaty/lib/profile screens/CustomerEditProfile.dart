import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/pages/login.dart';
import 'package:herfaty/widgets/logOut.dart';

class CustomerEditProfile extends StatefulWidget {
  CustomerEditProfile(this.name, this.email, this.password, this.uid);
  final String name;
  final String email;
  final String password;
  final String uid;
  @override
  State<CustomerEditProfile> createState() => _CustomerEditProfileState();
}

class _CustomerEditProfileState extends State<CustomerEditProfile> {
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _nameTextEditingController = TextEditingController();

  get kPrimaryColor => null;
  final _formKey = new GlobalKey<FormState>();
  String Oldname = '';
  void initState() {
    //..text = widget.email
    //..text = widget.name
    _nameTextEditingController.text = widget.name;
    _emailTextEditingController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    /// just  define _formkey with static final

    final titles = [
      'اسم المشتري',
      'البريد الإلكتروني',
      'كلمة المرور',
    ];
    // final icons = [Icons.person, Icons.email_rounded, Icons.lock];
    // String getUD() {
    //   final FirebaseAuth auth = FirebaseAuth.instance;
    //   final User? user = auth.currentUser;
    //   final uid = user!.uid;

    //   return uid;
    // }

    // String uid = getUD();

    final docCustomer =
        FirebaseFirestore.instance.collection('customers').doc(widget.uid);

    print(widget.uid);

    /**  SizedBox(
            width: 630,
            height: 100,
            child: Image.asset(
              'assets/images/customerBG.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 20,
          ), */
/*IconButton(
          icon: Icon(Icons.logout, color: Color.fromARGB(255, 39, 141, 134)),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => login()));
          },
        ),*/
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("تعديل الحساب",
            style: TextStyle(
              color: Color.fromARGB(255, 39, 141, 134),
              fontFamily: "Tajawal",
            )),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Color.fromARGB(255, 39, 141, 134),
        elevation: 3,

        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.logout, color: Color.fromARGB(255, 39, 141, 134)),
        //     onPressed: () {
        //       Navigator.of(context).push(MaterialPageRoute(
        //           builder: (BuildContext context) => login()));
        //     },
        //   ),
        // ],
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => logOutButton()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Color(0xff51908E)),
      ),
      body:
          //Center(child: Text('Customer Edit Profile page')));

          Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 55,
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

                Container(
                  color: Colors.white,
                  width: 350,
                  child: reusableTextFieldEditName(
                      'اسم المشتري', _nameTextEditingController),
                ),

//Only view the email
                SizedBox(
                  height: 10,
                ),

                Container(
                  color: Colors.white,
                  width: 350,
                  child: reusableTextFieldCustomer(
                      "البريد الإلكتروني", false, _emailTextEditingController),
                ),

                // Container(
                //   color: Colors.white,
                //   width: 350,
                //   child: reusableTextFieldCustomer(
                //       "كلمة المرور", true, _passwordTextController),
                // ),
                // Container(
                //   padding: const EdgeInsets.only(left: 110),
                //   child: Text(
                //     " كلمه المرور يجب ان لا تقل عن 6 خانات",
                //     style: TextStyle(
                //         color: Color.fromARGB(255, 84, 84, 84), fontSize: 13),
                //   ),
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
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 38,
                    ),
                    Expanded(
                      child: Row(children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_nameTextEditingController.text !=
                                widget.name) {
                              print(widget.uid);
                              //update this spesific feild
                              docCustomer.update({
                                'email': widget.email,
                                'id': widget.uid,
                                'name': _nameTextEditingController.text,
                                'password': widget.password,
                              });
                              Fluttertoast.showToast(
                                msg: "تم تحديث حسابك بنجاح",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                                backgroundColor:
                                    Color.fromARGB(255, 26, 96, 91),
                                textColor: Colors.white,
                                fontSize: 18.0,
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => logOutButton()));
                              // openPasswordDialog(context);
                              //Navigator.of(context).pop();}
                            } else {
                              Fluttertoast.showToast(
                                msg: "لم يتم تعديل بيانات الحساب",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                                backgroundColor:
                                    Color.fromARGB(255, 156, 30, 21),
                                textColor: Colors.white,
                                fontSize: 18.0,
                              );
                            }
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
                          width: 19,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_nameTextEditingController.text !=
                                widget.name) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context1) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    title: Text(
                                      "تنبيه",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            Color.fromARGB(255, 221, 112, 112),
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
                                            color:
                                                Color.fromARGB(255, 26, 96, 91),
                                            fontFamily: "Tajawal",
                                          ),
                                        )),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("تراجع"),
                                        onPressed: () {
                                          Oldname =
                                              _nameTextEditingController.text;
                                          _nameTextEditingController
                                            ..text = Oldname;

                                          Navigator.of(context1).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text("إلغاء",
                                            style:
                                                TextStyle(color: Colors.red)),
                                        onPressed: () {
                                          //The logic of cancle edits
                                          Navigator.of(context1).pop();
                                          Navigator.of(context).pop();
                                          /* Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  logOutButton()),
                                        );*/
                                          // _nameTextEditingController
                                          //   ..text = widget.name;
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
                                backgroundColor:
                                    Color.fromARGB(255, 156, 30, 21),
                                textColor: Colors.white,
                                fontSize: 18.0,
                              );
                            }
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
      ),
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
      },
    );
  }

  TextFormField reusableTextFieldEditName(
      String text, TextEditingController controller) {
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
        if (value.trim().isEmpty) {
          return "أدخل " + text + " صحيح";
        }
      },
    );
  }
}
