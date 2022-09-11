import 'dart:async';

import 'package:flutter/material.dart';

import 'package:herfaty/pages/welcome.dart';

//Here is the splash screen
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Welcome())));
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromARGB(232, 238, 232, 182),
                gradient: LinearGradient(
                  colors: [
                    (Color.fromARGB(159, 228, 175, 122)),
                    (Color.fromARGB(159, 243, 231, 103))
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
          ),
          Center(
            child: Container(
              width: 300,

              child: Image.asset("assets/images/HerfatyLogoCroped.png"),
            ),
          ),
        ],
      ),
    );
  }
}