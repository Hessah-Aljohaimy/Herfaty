import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herfaty/main.dart';
import 'package:herfaty/pages/welcome.dart';

import '../constants/color.dart';

class logOutButton extends StatelessWidget {
  const logOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "تسجيل الخروج"),
      floatingActionButton: FloatingActionButton.extended(
          label: Text(
            'تسجيل خروج',
          ),
          onPressed: () async {
            FirebaseAuth.instance.signOut();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Welcome()),
            );
          },
          backgroundColor: kPrimaryColor),
    );
  }
}

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const DefaultAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(56.0);
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(color: kPrimaryColor)),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: kPrimaryColor),
    );
  }
}
