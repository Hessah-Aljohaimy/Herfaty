import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class customerHomePage extends StatefulWidget {
  const customerHomePage({Key? key}) : super(key: key);

  @override
  State<customerHomePage> createState() => _customerHomePageState();
}

class _customerHomePageState extends State<customerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
    BottomNavigationBar: GNav(
      backgroundColor: Colors.black, //should change the color
      color: Colors.white,
      activeColor: Colors.white,
      tabBackgroundColor: Colors.grey.shade800,
      gap: 8,
      padding: EdgeInsets.all(16),
      tabs: const [
        GButton(
          icon: Icons.home,
          text: 'الرئيسية',
        ),
        GButton(
          icon: Icons.favorite_border,
          text: 'المفضلة',
        ),
        GButton(
          icon: Icons.settings, //change it
          text: 'السلة',
        ),
        GButton(
          icon: Icons.search,
          text: 'تسجيل خروج',
        ),
      ],
    ),
  };
}
