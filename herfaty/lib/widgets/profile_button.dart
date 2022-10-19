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
        margin: EdgeInsets.only(left: 20),
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: kPrimaryColor,
          size: 40,
        ),
      ),
      onTap: onPressed,
    );
  }
}
