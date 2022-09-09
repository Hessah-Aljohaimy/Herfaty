import 'package:flutter/material.dart';
import 'package:herfaty/splash.dart';
import 'package:herfaty/signupCustomer.dart';
import 'package:herfaty/signupHerafy.dart';
import 'package:herfaty/Welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const Splash(),
        // "/Welcome": (context) => const Welcome(),
        "/signupCustomer": (context) => const SignupCustomer(),
        "/signupHerfay": (context) => const SignupHerafy(),
        // "/home_screen": (context) => const Home_Screen(),
      },
    );
  }
}
