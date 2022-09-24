import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:herfaty/pages/login.dart';

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
          title: Text("تعديل الحساب", style: TextStyle(color: kPrimaryColor)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.logout, color: kPrimaryColor),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => login()));
            },
          ),
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: kPrimaryColor),
        ),
        body: Center(child: Text('Shop Owner Edit Profile page')));
  }
}
