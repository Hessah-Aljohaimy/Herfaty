import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:herfaty/constants/color.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: const Text('دفع'),
          icon: const Icon(Icons.payment),
          backgroundColor: Color(0xff5596A5),
          extendedPadding: EdgeInsetsDirectional.only(start: 50.0, end: 50.0),
        ),
        body: Column(
          children: const [AppBarc()],
        ),
      ),
    );
  }
}

class AppBarc extends StatelessWidget {
  const AppBarc({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("سلتي", style: TextStyle(color: kPrimaryColor)),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: kPrimaryColor),
    );
  }
}
/*
class Bodyc extends StatelessWidget {
  const Bodyc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text('دفع'),
        icon: const Icon(Icons.payment),
        backgroundColor: Color(0xffF8C695),
        extendedPadding: EdgeInsetsDirectional.only(start: 100.0, end: 100.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    );
  }
}
*/