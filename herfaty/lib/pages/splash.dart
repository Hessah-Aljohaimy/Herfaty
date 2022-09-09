import 'package:flutter/material.dart';

//Here is the splash screen
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
    Color mycolor = const Color.fromARGB(0, 92, 157, 155);
    Color mySeconedColor = const Color.fromARGB(0, 245, 214, 111);
    return Scaffold(
      body: Stack(
        children: [
          const Text("It is splash page"),
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
