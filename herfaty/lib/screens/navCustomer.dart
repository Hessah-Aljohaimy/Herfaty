import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:herfaty/CustomerProducts/wishList/CustomerWishList.dart';
import 'package:herfaty/cart/cart.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/customerOrder/listOrderCustomer.dart';
import 'package:herfaty/screens/customerHome.dart';
import 'package:herfaty/widgets/logOut.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class nav extends StatelessWidget {
  const nav({super.key});

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
          resizeToAvoidBottomInset: false,
          body: PersistentTabView(
            context,
            screens: screens(),
            items: navBarItems(),
          ),
        ));
  }

  List<Widget> screens() {
    return [
      customerHomeScreen(),
      Cart(),
      listOrderCustomer(),
      logOutButton(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: "  الرئيسية",
          activeColorPrimary: kPrimaryColor.withOpacity(0.9),
          inactiveColorPrimary: CupertinoColors.systemGrey),
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.cart),
          title: "  السلة",
          activeColorPrimary: kPrimaryColor.withOpacity(0.9),
          inactiveColorPrimary: CupertinoColors.systemGrey),
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.square_favorites),
          title: "  الطلبات",
          activeColorPrimary: kPrimaryColor.withOpacity(0.9),
          inactiveColorPrimary: CupertinoColors.systemGrey),
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.person),
          title: "حسابي",
          activeColorPrimary: kPrimaryColor.withOpacity(0.9),
          inactiveColorPrimary: CupertinoColors.systemGrey),
    ];
  }
}
