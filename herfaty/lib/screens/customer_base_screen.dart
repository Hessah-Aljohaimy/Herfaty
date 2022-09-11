import 'package:herfaty/constants/color.dart';
import 'package:herfaty/constants/icons.dart';
import 'package:herfaty/constants/size.dart';
import 'package:herfaty/screens/customerHome.dart';
import 'package:flutter/material.dart';
import 'package:herfaty/cart/cart.dart';

class customerBaseScreen extends StatefulWidget {
  const customerBaseScreen({Key? key}) : super(key: key);

  @override
  _customerBaseScreenState createState() => _customerBaseScreenState();
}

class _customerBaseScreenState extends State<customerBaseScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    customerHomeScreen(),
    Cart(),
    customerHomeScreen(),
    customerHomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                icFeatured,
                height: kBottomNavigationBarItemSize,
              ),
              icon: Image.asset(
                icFeaturedOutlined,
                height: kBottomNavigationBarItemSize,
              ),
              label: "الرئيسية",
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                icLearning,
                height: kBottomNavigationBarItemSize,
              ),
              icon: Image.asset(
                icLearningOutlined,
                height: kBottomNavigationBarItemSize,
              ),
              label: "سلتي",
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                icWishlist,
                height: kBottomNavigationBarItemSize,
              ),
              icon: Image.asset(
                icWishlistOutlined,
                height: kBottomNavigationBarItemSize,
              ),
              label: "مفضلاتي",
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                icSetting,
                height: kBottomNavigationBarItemSize,
              ),
              icon: Image.asset(
                icSettingOutlined,
                height: kBottomNavigationBarItemSize,
              ),
              label: "تسجيل الخروج",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
