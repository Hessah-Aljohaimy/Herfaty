import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/customerModel.dart';
import 'package:herfaty/herafyModel.dart';

import 'package:herfaty/reusable_widgits.dart';
import 'package:herfaty/test_Login.dart';
import 'package:herfaty/welcomeRegestration.dart';

class SignupCustomer extends StatefulWidget {
  const SignupCustomer({super.key});

  @override
  State<SignupCustomer> createState() => _SignupCustomerState();
}

class _SignupCustomerState extends State<SignupCustomer> {
  var _sheetController;
  var _loading = true;
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  @override
//   void initState(){
// super.initState();
//  final _auth = FirebaseAuth.instance;
//   }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/images/main_botomm.png",
                      width: 200,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),

                          Container(
                              child: Image.asset(
                            "assets/images/HerfatyLogoCroped.png",
                            height: 120,
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

                            child: reusableTextField(
                                " اسم المشتري الثنائي",
                                Icons.person,
                                false,
                                nameTextEditingController),
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signupCustomer(_emailTextEditingController.text,
                                    _passwordTextController.text);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const TestLogin()),
                                );
                                // FirebaseAuth.instance.singIn
                                // FirebaseAuth.instance..createUserWithEmailAndPassword(email:_emailTextEditingController.text,password:_passwordTextController.text).then((value) (){
                                // Navigator.push(context,MaterialPageRoute(builder:(context)=>HomeScreen()));

                                // });

/*

void _validateRegisterInput() async {
      final FormState? form = _formKey.currentState;

      if (_formKey.currentState?.validate()) {
        form?.save();
        _sheetController.setState(() {
          _loading = true;
        });
        try {
          FirebaseUser user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email, password: _password);
          UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
          userUpdateInfo.displayName = _displayName;
          user.updateProfile(userUpdateInfo).then((onValue) {
            Navigator.of(context).pushReplacementNamed('/home');
            Firestore.instance.collection('users').document().setData(
                {'email': _email, 'displayName': _displayName}).then((onValue) {
              _sheetController.setState(() {
                _loading = false;
              });
            });
          });
        } catch (error) {
          switch (error.code) {
            case "ERROR_EMAIL_ALREADY_IN_USE":
              {
                _sheetController.setState(() {
                  errorMsg = "البريد الإلكتروني مستخدم مسبقا";
                  _loading = false;
                });
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(errorMsg),
                        ),
                      );
                    });
              }
              break;
            case "ERROR_WEAK_PASSWORD":
              {
                _sheetController.setState(() {
                  errorMsg = "The password must be 6 characters long or more.";
                  _loading = false;
                });
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(errorMsg),
                        ),
                      );
                    });
              }
              break;
            default:
              {
                _sheetController.setState(() {
                  errorMsg = "";
                });
              }
          }
        }
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }


*/

                                print(' customer signed up correctly');
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 26, 96, 91)),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 89, vertical: 10)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(27))),
                            ),
                            child: Text(
                              "سجل الحساب",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          SizedBox(
                            height: 33,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/login");
                                },
                                child: Text(
                                  " هل لديك حساب بالفعل؟",
                                  style: TextStyle(fontFamily: "Tajawal"),
                                ),
                              ),
                              TextButton(
                                child: Text(
                                  " تسجيل الدخول",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontFamily: "Tajawal"),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TestLogin()),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          SizedBox(
                            width: 299,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                  thickness: 0.6,
                                  color: Color.fromARGB(255, 26, 96, 91),
                                )),
                              ],
                            ),
                          ),
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
<<<<<<< Updated upstream
// Future registerWithEmailAndPassword(String email)
=======
//
//
//
//
//
//
// Future registerWithEmailAndPassword(String email)

  void signupCustomer(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    //crating our firestore
//calling our user model
//sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser!;

    CustomerModel customerModel = CustomerModel();
    customerModel.email = user.email;
    customerModel.uid = user.uid;
    customerModel.customer_name = nameTextEditingController.text;

    await firebaseFirestore
        .collection("customers")
        .doc("c3")
        .set(customerModel.toMAp());

    Fluttertoast.showToast(msg: "تم تسجيل الحساب بنجاح");

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TestLogin()),
    );
  }
>>>>>>> Stashed changes
}
