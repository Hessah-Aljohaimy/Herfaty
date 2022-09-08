// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:herfaty/constants/colors.dart';
=======
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
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
                  // Image.asset(
                  //   "herfaty/assets/images/HerfatyLogo.png",
                  //   width: 120,
                  // ),
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
                      " تسجيل الدخول كعميل",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),

              ///////////////Positioned///////
              // Positioned(
              //   top: 0,
              //   left: 0,
              //   child: Image.asset(
              //     "herfaty/assets/images/main_left_side.png",
              //     width: 111,
              //   ),
              // ),
              // /////////////////////////////////////////////
              // Positioned(
              //   bottom: 0,
              //   right: 0,
              //   child: Image.asset(
              //     "herfaty/assets/images/craftiRightSide.png",
              //     width: 120,
              //   ),
              // ),
=======
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      "Welcome to Herfaty App",
                      style: TextStyle(fontSize: 33, fontFamily: "myfont"),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/signup");
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple[100]),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 77, vertical: 13)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27))),
                      ),
                      child: Text(
                        "SIGNUP",
                        style: TextStyle(fontSize: 17, color: Colors.grey[850]),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: 111,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Image.asset(
                  "assets/images/main_bottom.png",
                  width: 111,
                ),
              ),
>>>>>>> Stashed changes
            ],
          ),
        ),
      ),
    );
<<<<<<< Updated upstream

//     const darkGreen = const Color(0x51908E);
//     const lightBlue = const Color(0x9BD6E6);
//     const lightOrange = const Color(0xF8C695);
//     const Orange = const Color(0xF8C695);
//     const pink = const Color(0xF38694);
//     return SafeArea(
//       child: Scaffold(
//         body: SizedBox(
//           height: double.infinity,
//           width: double.infinity,
//           child: Stack(
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 35,
//                     ),
//                     Text(
//                       "Welcome",
//                       style: TextStyle(
//                         fontSize: 33,
//                         fontFamily: "myfont",
//                       ),
//                     ),
//                     SizedBox(
//                       height: 35,
//                     ),
//                     SizedBox(
//                       height: 35,
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, "/login");
//                       },
//                       style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all(Colors.green),
//                         padding: MaterialStateProperty.all(
//                             EdgeInsets.symmetric(horizontal: 79, vertical: 10)),
//                         shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(27))),
//                       ),
//                       child: Text(
//                         "Login",
//                         style: TextStyle(fontSize: 24),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 22,
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, "/Signup");
//                       },
//                       style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all(Colors.green),
//                         padding: MaterialStateProperty.all(
//                             EdgeInsets.symmetric(horizontal: 77, vertical: 13)),
//                         shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(27))),
//                       ),
//                       child: Text(
//                         "SIGNUP",
//                         style: TextStyle(fontSize: 17, color: Colors.grey[850]),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
=======
>>>>>>> Stashed changes
  }
}
