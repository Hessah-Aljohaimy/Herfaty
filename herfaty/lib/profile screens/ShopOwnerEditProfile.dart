import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:herfaty/pages/login.dart';
import 'package:herfaty/profile%20screens/ShopOwnerProfile.dart';

class ShopOwnerEditProfile extends StatefulWidget {
  const ShopOwnerEditProfile({super.key});

  @override
  State<ShopOwnerEditProfile> createState() => _ShopOwnerEditProfileState();
}

class _ShopOwnerEditProfileState extends State<ShopOwnerEditProfile> {
  get kPrimaryColor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text("تعديل الحساب", style: TextStyle(color: Color(0xff51908E))),
          centerTitle: true,
          backgroundColor: Colors.white,
          shadowColor: Color.fromARGB(255, 39, 141, 134),
          elevation: 2,
          leading: IconButton(
            icon: Icon(Icons.logout, color: Color(0xff51908E)),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => login()));
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ShopOwnerProfile()));
              },
              icon: Icon(Icons.arrow_forward),
            ),
          ],
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: Color(0xff51908E)),
        ),
        body: Center(child: Text('Shop Owner Edit Profile page')));
  }
}
