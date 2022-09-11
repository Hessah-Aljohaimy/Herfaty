import 'package:flutter/material.dart';

class profileButton extends StatelessWidget {
  final IconData icon;
  final GestureTapCallback onPressed;
  const profileButton({Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Icon(
          icon,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
