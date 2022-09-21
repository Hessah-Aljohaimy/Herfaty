import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herfaty/pages/reusable_widgets.dart';
import 'package:herfaty/pages/login.dart';
import 'package:herfaty/screens/customer_base_screen.dart';
import 'package:herfaty/screens/navCustomer.dart';

class SignupCustomer extends StatefulWidget {
  const SignupCustomer({super.key});

  @override
  State<SignupCustomer> createState() => _SignupCustomerState();
}

class _SignupCustomerState extends State<SignupCustomer> {
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _nameTextEditingController = TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    return Form(
     // autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Image.asset(
                      "assets/images/login_toppp.png",
                      width: 150,
                    ),
                  ),
                  // Positioned(
                  //   bottom: 0,
                  //   right: 0,

                  //   child: Image.asset(
                  //     "assets/images/main_botomm.png",
                  //     width: 200,
                  //   ),
                  // ),
                  SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 70,
                          ),

                          Container(
                              child: Image.asset(
                            "assets/images/HerfatyLogoCroped.png",
                            height: 100,
                          )),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "تسجيل حساب جديد",
                            style: TextStyle(
                              fontSize: 35,
                              fontFamily: "Tajawal",
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 26, 96, 91),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Text(
                            "معلومات المشتري",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Tajawal",
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(248, 228, 175, 122),
                            ),
                          ),
                          SizedBox(
                            height: 27,
                          ),
                          //////////////////Inputs Fields//////////////

                          Container(
                            // width: 290,
                            // height: 53,
                            padding: EdgeInsets.symmetric(horizontal: 60),
                            // child: TextFormField (
                            //   validator: (value) => value.isEmpty?'ادخل اسم المشتري الثنائي':null,

                            child: reusableTextFieldForName(
                                " اسم المشتري الثنائي",
                                Icons.person,
                                _nameTextEditingController),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            // width: 290,
                            // height: 53,
                            padding: EdgeInsets.symmetric(horizontal: 60),
                            child: reusableTextField(
                                "البريد الإلكتروني",
                                Icons.email_rounded,
                                false,
                                _emailTextEditingController),
                          ),
                          SizedBox(
                            height: 23,
                          ),
                          Container(
                            // width: 290,
                            // height: 53,
                            padding: EdgeInsets.symmetric(horizontal: 60),
                            child: reusableTextField("كلمة المرور", Icons.lock,
                                true, _passwordTextController),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 110),
                            child: Text(
                              " كلمه المرور يجب ان لا تقل عن 6 خانات",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 84, 84, 84),
                                  fontSize: 13),
                            ),
                          ),
                          SizedBox(
                            height: 23,
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                if (_formKey.currentState!.validate()) {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email:
                                              _emailTextEditingController.text,
                                          password:
                                              _passwordTextController.text)
                                      .then((value) {
                                    final customer = Customer(
                                      name: _nameTextEditingController.text,
                                      email: _emailTextEditingController.text,
                                      password: _passwordTextController.text,
                                    );
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
                                    createCustomer(customer);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => nav()),
                                    );

                                    //  Navigator.pushNamed(context, "/home_screen");
                                  });
                                }
                              } on FirebaseAuthException catch (error) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("خطأ"),
                                        content: Text(
                                            'البريد الإلكتروني موجود مسبقا'),
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
                            height: 33,
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
                                        color:
                                            Color.fromARGB(255, 53, 47, 244)),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          // SizedBox(
                          //   width: 299,
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //           child: Divider(
                          //         thickness: 0.6,
                          //         color: Color.fromARGB(255, 26, 96, 91),
                          //       )),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
// Future registerWithEmailAndPassword(String email)
}

//Datebase
Future createCustomer(Customer customer) async {
  final docCustomr = FirebaseFirestore.instance.collection('customers').doc();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user!.uid;
  customer.id = uid;

  final json = customer.toJson();

  await docCustomr.set(json);
}

//Database
class Customer {
  String id;
  final String name;
  final String email;
  final String password;

  Customer({
    this.id = '',
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      };
}
