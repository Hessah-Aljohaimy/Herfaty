// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "أهلا بك أيها الحرفي",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Image.asset(
                    "assets/images/HerfatyLogo.png",
                    width: 120,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/SignupHerafy");
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 79, vertical: 10)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27))),
                    ),
                    child: Text(
                      " تسجيل الدخول كحرفي",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/signupCustomer");
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 79, vertical: 10)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27))),
                    ),
                    child: Text(
                      " تسجيل الدخول كمشتري",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
//Here are the photos to the screen for UI
              ///////////////Positioned///////
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_left_side.png",
                  width: 111,
                ),
              ),
              // /////////////////////////////////////////////
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/craftiRightSide.png",
                  width: 120,
                ),
              )
              //              SizedBox(

//     const darkGreen = const Color(0x51908E);
//     const lightBlue = const Color(0x9BD6E6);
//     const lightOrange = const Color(0xF8C695);
//     const Orange = const Color(0xF8C695);
//     const pink = const Color(0xF38694);
            ],
          ),
        ),
      ),
    );
  }
}
