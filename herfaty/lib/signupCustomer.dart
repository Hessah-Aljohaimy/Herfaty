import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:herfaty/reusable_widgits.dart';
import 'package:herfaty/test_Login.dart';
// import 'package:herfaty/test_Login.dart';
import 'package:herfaty/welcome.dart';

class SignupCustomer extends StatefulWidget {
  const SignupCustomer({super.key});

  @override
  State<SignupCustomer> createState() => _SignupCustomerState();
}

class _SignupCustomerState extends State<SignupCustomer> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _nameTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SafeArea(
        child: Scaffold(
          body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ignore: prefer_const_constructors
                      Positioned(
                        top: 0,
                        left: 0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Welcome()),
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
                        "معلومات المشتري",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "myfont",
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 27,
                      ),
                      //////////////////Inputs Fields//////////////
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.green[100],
                      //     borderRadius: BorderRadius.circular(66),
                      //   ),
                      //   width: 266,
                      //   padding: EdgeInsets.symmetric(horizontal: 16),
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //         icon: Icon(
                      //           Icons.person,
                      //           color: Colors.white,
                      //         ),
                      //         hintText: "أدخل اسم المشتري",
                      //         border: InputBorder.none),
                      //   ),
                      // ),
                      Container(
                        width: 290,
                        height: 53,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: reusableTextField(
                            "اسم المشتري",
                            Icons.person_outline,
                            false,
                            _nameTextEditingController),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.green[100],
                      //     borderRadius: BorderRadius.circular(66),
                      //   ),
                      //   width: 266,
                      //   padding: EdgeInsets.symmetric(horizontal: 16),
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //         icon: Icon(
                      //           Icons.email,
                      //           color: Colors.white,
                      //         ),
                      //         hintText: ":أدخل عنوان البريد الإلكتروني",
                      //         border: InputBorder.none),
                      //   ),
                      // ),
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
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.green[100],
                      //     borderRadius: BorderRadius.circular(66),
                      //   ),
                      //   width: 266,
                      //   padding: EdgeInsets.symmetric(horizontal: 16),
                      //   child: TextField(
                      //     obscureText: true,
                      //     decoration: InputDecoration(
                      //         suffix: Icon(
                      //           Icons.visibility,
                      //           color: Colors.white,
                      //         ),
                      //         icon: Icon(
                      //           Icons.lock,
                      //           color: Colors.white,
                      //           size: 19,
                      //         ),
                      //         hintText: ":أدخل الرقم السري",
                      //         border: InputBorder.none),
                      //   ),
                      // ),
                      Container(
                        width: 290,
                        height: 53,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: reusableTextField("الرقم السري", Icons.lock,
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
                                    builder: (context) => const TestLogin()),
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
              ],
            ),
          ),
        ),
      )),
    );
  }
}
