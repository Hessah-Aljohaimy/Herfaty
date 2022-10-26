import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileCicle extends StatefulWidget {
  const ProfileCicle({super.key});

  @override
  State<ProfileCicle> createState() => _ProfileCicleState();
}

class _ProfileCicleState extends State<ProfileCicle> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: 150,
        color: Colors.white,
        child: IconButton(
          icon: const Icon(Icons.person),
          color: Colors.white,
          onPressed: () {},
        ));
  }
}
