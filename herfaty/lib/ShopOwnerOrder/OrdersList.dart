import 'package:flutter/material.dart';
import 'package:herfaty/constants/color.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    const title = 'قائمة الطلبات';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: DefaultAppBar(title: "طلبات متجري"),

        //title: const Text(title),
        // ),
        body: ListView(
          children: const <Widget>[
            ListTile(
              //leading: Icon(Icons.map),
              title: Text('الطلب الأول'),

              //style:Color(0xff51908E),
            ),
            ListTile(
              //leading: Icon(Icons.photo_album),
              title: Text('الطلب الثاني'),
            ),
            ListTile(
              // leading: Icon(Icons.phone),
              title: Text('الطلب الثالث'),
            ),
          ],
        ),
      ),
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
