import 'package:flutter/material.dart';
import 'package:herfaty/test_Login.dart';
import 'package:herfaty/reusable_widgits.dart';
import 'package:herfaty/welcomeRegestration.dart';

// ignore_for_file: file_names, prefer_const_constructors

class SignupHerafy extends StatefulWidget {
  const SignupHerafy({Key? key}) : super(key: key);

  @override
  State<SignupHerafy> createState() => _SignupHerafyState();
}

class _SignupHerafyState extends State<SignupHerafy> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _nameTextEditingController = TextEditingController();
  TextEditingController intialdateval = TextEditingController();
  TextEditingController _PhoneNumberTextEditingController =
      TextEditingController();

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
                    ////////////////////////I will remov it //////////////////////
                    Positioned(
                      top: 0,
                      left: 0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const WelcomeRegestration()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 79, vertical: 10)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(27))),
                        ),
                        child: Text(
                          " العوده للصفحه الرئيسيه",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),

                          Text(
                            "تسجيل حساب جديد",
                            style: TextStyle(
                                fontSize: 35,
                                fontFamily: "myfont",
                                color: Colors.black),
                          ),

                          SizedBox(
                            height: 21,
                          ),

                          Text(
                            "معلومات الحرفي",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "myfont",
                                color: Colors.black),
                          ),

                          SizedBox(
                            height: 27,
                          ),
                          Container(
                            width: 290,
                            height: 53,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: reusableTextField(
                                "اسم الحرفي",
                                Icons.person_outline,
                                false,
                                _nameTextEditingController),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Container(
                            width: 290,
                            height: 53,
                            padding: EdgeInsets.symmetric(horizontal: 16),
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
                            width: 290,
                            height: 53,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: reusableTextField("الرقم السري", Icons.lock,
                                true, _passwordTextController),
                          ),

                          SizedBox(
                            height: 17,
                          ),

/////////////////////picking date///////////////////////

                          Container(
                            width: 290,
                            height: 53,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: reusableTextField(
                                "تاريخ الميلاد",
                                Icons.date_range,
                                false,
                                _passwordTextController),
                          ),

                          SizedBox(
                            height: 17,
                          ),

                          Container(
                            width: 290,
                            height: 53,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: reusableTextField(
                                "رقم الجوال",
                                Icons.phone_android,
                                false,
                                _PhoneNumberTextEditingController),
                          ),

                          SizedBox(
                            height: 17,
                          ),

                          Text("!هيا لتبدأ رحلتك"),
                          SizedBox(
                            height: 6,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
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
                              TextButton(
                                child: Text(
                                  " تسجيل الدخول",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/login");
                                },
                                child: Text(
                                  " هل لديك حساب بالفعل؟",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          SizedBox(
                            width: 299,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
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
                  ],
                ),
              ),
            ),
          )),

//get image from user

      // GestureDetector(
      //   onTap: () {},
      //   child: CircleAvatar(
      //     radius: MediaQuery.of(context).size.width * 0.10,
      //     backgroundColor: Colors.white,
      //     child: Icon(
      //       Icons.add_photo_alternate,
      //       color: Colors.grey,
      //       size: MediaQuery.of(context).size.width * 0.10,
      //     ),
      //   ),
      // ),
    );
  }
}
