import 'package:flutter/material.dart';

class TestLogin extends StatefulWidget {
  const TestLogin({super.key});

  @override
  State<TestLogin> createState() => _TestLoginState();
}

class _TestLoginState extends State<TestLogin> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
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
                    height: 20,
                  ),
                  // ignore: prefer_const_constructors
                  Center(
                    child: Text(
                      "تجربة تسجيل حساب جديد",
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: "myfont",
                          color: Colors.black),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 21,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
