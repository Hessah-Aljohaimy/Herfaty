import 'package:herfaty/constants/color.dart';
import 'package:herfaty/constants/icons.dart';
import 'package:herfaty/constants/size.dart';
import 'package:herfaty/screens/ownerHome.dart';
import 'package:flutter/material.dart';
import 'package:herfaty/screens/ownerProductsCateg.dart';

class ownerBaseScreen extends StatefulWidget {
  const ownerBaseScreen({Key? key}) : super(key: key);

  @override
  _ownerBaseScreenState createState() => _ownerBaseScreenState();
}

class _ownerBaseScreenState extends State<ownerBaseScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ownerHomeScreen(),
    ownerProductsCategScreen(),
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
                icOrders,
                height: kBottomNavigationBarItemSize,
              ),
              icon: Image.asset(
                icOrdersOutlined,
                height: kBottomNavigationBarItemSize,
              ),
              label: "الطلبات",
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
