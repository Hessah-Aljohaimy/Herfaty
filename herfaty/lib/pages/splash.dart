import 'dart:async';

import 'package:flutter/material.dart';
import 'package:herfaty/welcome.dart';

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
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Welcome())));
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    // Color mycolor = const Color.fromARGB(248, 198, 149, 100);
    // Color mySeconedColor = const Color.fromARGB(255, 237, 178, 100);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromARGB(232, 238, 232, 182),
                    gradient: LinearGradient(
                      colors: [
                        (Color.fromARGB(248, 228, 175, 122)),
                        (Color.fromARGB(255, 243, 231, 103))
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
              ),
              Center(
                child: Container(
                  child: Image.asset("assets/images/HerfatyLogo.png"),
                ),
              ),
            ],
          ),
          CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 26, 96, 91)),
          ),
        ],
      ),
    );
  }
}
