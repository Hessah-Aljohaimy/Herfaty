import 'package:flutter/material.dart';
import 'package:herfaty/constants/color.dart';

class profileButton extends StatelessWidget {
  final IconData icon;
  final GestureTapCallback onPressed;
  const profileButton({Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        //margin: EdgeInsets.only(left: 20),
        height: 35,
        width: 35,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Color.fromARGB(255, 198, 48, 37),
          size: 35,
        ),
      ),
      onTap: onPressed,
    );
  }
}
