// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';


class SignupHerafy extends StatelessWidget {
  const SignupHerafy({Key? key}) : super(key: key);

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
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 266,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              hintText: ":أدخل اسم الحرفي",
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 266,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              hintText: ":أدخل عنوان البريد الإلكتروني",
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 266,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                              suffix: Icon(
                                Icons.visibility,
                                color: Colors.white,
                              ),
                              icon: Icon(
                                Icons.lock,
                                color: Colors.white,
                                size: 19,
                              ),
                              hintText: ":أدخل الرقم السري",
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 266,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.date_range,
                                color: Colors.white,
                              ),
                              hintText: ":أدخل تاريخ الميلاد",
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 266,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.phone_android,
                                color: Colors.white,
                              ),
                              hintText: ":أدخل رقم الجوال",
                              border: InputBorder.none),
                        ),
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
                          Text(
                            " تسجيل الدخول",
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                              color: Colors.purple[900],
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
