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
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "أهلا بك !",
                          style: TextStyle(fontSize: 33, fontFamily: "Tajawal" 
                        ,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 26, 96, 91)
                          ),
                        ),
                         SizedBox(
                          height: 15,
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
 SizedBox(
                          height: 21,
                        ),
                        // Image.asset(
                        //   "assets/images/HerfatyLogo.png",
                        //   width: 120,
                        // ),

                         Text(
                          "تسجيل حساب جديد",
                          style: TextStyle(fontSize: 33, fontFamily: "Tajawal" 
                        ,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 26, 96, 91)
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
                                  builder: (context) => const SignupHerafy()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                               Color(0xff51908E)),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric( horizontal: 90, vertical: 13)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(27))),
                          ),
                          child: Text(
                            " حرفي",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Tajawal",
                              fontWeight: FontWeight.bold,
                            ),
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
                               Color(0xff51908E)),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric( horizontal: 90, vertical: 13)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(27))),
                          ),
                          child: Text(
                            "مشتري",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Tajawal",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
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
