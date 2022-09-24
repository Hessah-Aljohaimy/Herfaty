import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../pages/login.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key});

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  get kPrimaryColor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("حسابي", style: TextStyle(color: kPrimaryColor)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.logout, color: kPrimaryColor),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => login()));
          },
        ),
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: kPrimaryColor),
      ),
    );
  }
}
