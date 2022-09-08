import 'package:flutter/material.dart';
import 'package:herfaty/constants/colors.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    Color mycolor = new Color(0x51908E);
    Color mySeconedColor = new Color(0xFFEDB2)
    return Scaffold(
      body: Stack(
        children: [
          Text("It is splash page"),
          Container(
            decoration: BoxDecoration(
                color: mycolor,
                gradient: LinearGradient(
                  colors: [(mycolor), (mySeconedColor)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
          ),
          Center(
            child: Container(
              child: Image.asset(
                  "herfaty/build/flutter_assets/assets/images/HerfatyLogo.png"),
            ),
          ),
        ],
      ),
    );
  }
}
