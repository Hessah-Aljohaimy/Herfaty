import 'package:flutter/material.dart';
import 'package:herfaty/pages/signup.dart';
import 'package:herfaty/pages/welcome.dart';

import 'package:herfaty/pages/signupHerafy.dart';
import 'package:herfaty/pages/splash.dart';
import 'package:herfaty/pages/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        //SignupHerafy
        // "/": (context) => const Welcome(),
        // "/": (context) => const SignupHerafy(),
        //Splash
        "/": (context) => const Splash(),
      },
    );
  }
}
