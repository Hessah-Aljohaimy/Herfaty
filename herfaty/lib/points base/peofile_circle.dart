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
        width: 50,
        height: 50,
        // color: Colors.white,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: IconButton(
          icon: const Icon(
            Icons.person,
            size: 50,
          ),
          color: Color(0xffF19B1A),
          onPressed: () {},
        ));
  }
}
