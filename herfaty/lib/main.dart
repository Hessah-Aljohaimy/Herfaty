import 'package:flutter/material.dart';

import 'package:herfaty/pages/signup.dart';
import 'package:herfaty/pages/signupCustomer.dart';
import 'package:herfaty/pages/welcome.dart';

import 'package:herfaty/pages/signupHerafy.dart';
import 'package:herfaty/pages/splash.dart';
import 'package:herfaty/pages/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        "/": (context) => const Welcome(),
        // "/SignupHerafy": (context) => const SignupHerafy(),
        // "/SignupCustomer": (context) => const SignupCustomer(),
      },
    );
  }
}
