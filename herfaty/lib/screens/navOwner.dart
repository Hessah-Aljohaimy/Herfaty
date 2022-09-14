import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:herfaty/cart/cart.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/screens/customerHome.dart';
import 'package:herfaty/screens/ownerHome.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class navOwner extends StatelessWidget {
  const navOwner({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar', 'AE'),
        ],
        home: Scaffold(
          body: PersistentTabView(
            context,
            screens: screens(),
            items: navBarItems(),
          ),
        ));
  }

  List<Widget> screens() {
    return [
      ownerHomeScreen(),
      ownerHomeScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: "الرئيسية",
          activeColorPrimary: kPrimaryColor.withOpacity(0.9),
          inactiveColorPrimary: CupertinoColors.systemGrey),
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.settings),
          title: "الإعدادات",
          activeColorPrimary: kPrimaryColor.withOpacity(0.9),
          inactiveColorPrimary: CupertinoColors.systemGrey),
    ];
  }
}
