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
    // Color mycolor = const Color.fromARGB(248, 198, 149, 100);
    // Color mySeconedColor = const Color.fromARGB(255, 237, 178, 100);
    return Scaffold(
      body: Stack(
        children: [
          const Text("It is splash page"),
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(232, 238, 232, 182),
                gradient: LinearGradient(
                  colors: [
                    (Color.fromARGB(248, 198, 149, 100)),
                    (const Color.fromARGB(255, 237, 178, 100))
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
    );
  }
}
