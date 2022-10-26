import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../profile screens/ShopOwnerProfile.dart';

class ProfileCicle extends StatefulWidget {
  const ProfileCicle({super.key});

  @override
  State<ProfileCicle> createState() => _ProfileCicleState();
}

class _ProfileCicleState extends State<ProfileCicle> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 62,
        height: 62,
        // color: Colors.white,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Color(0xffF19B1A),
            ),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: IconButton(
          icon: const Icon(
            Icons.person,
            size: 48,
          ),
          color: Color(0xffF19B1A),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ShopOwnerProfile()));
          },
        ));
  }
}
