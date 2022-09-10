// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:herfaty/signupCustomer.dart';
import 'package:herfaty/signupHerafy.dart';

class WelcomeRegestration extends StatelessWidget {
  const WelcomeRegestration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // child: SafeArea(
      child: Scaffold(
        body: SafeArea(
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
                        "أهلا بك !",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        top: 50,
                        right: 10,
                        child: Image.asset(
                          "assets/images/kid_Waving.png",
                          width: 200,
                        ),
                      ),

                      // Image.asset(
                      //   "assets/images/HerfatyLogo.png",
                      //   width: 120,
                      // ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupHerafy()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 26, 96, 91)),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 79, vertical: 10)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(27))),
                        ),
                        child: Text(
                          " تسجيل حساب حرفي",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupCustomer()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 26, 96, 91)),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 79, vertical: 10)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(27))),
                        ),
                        child: Text(
                          "تسجيل حساب مشتري",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
//Here are the photos to the screen for UI
                  ///////////////Positioned///////
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
          // ),
        ),
      ),
    );
  }
}
// ignore_for_file: prefer_const_constructors
