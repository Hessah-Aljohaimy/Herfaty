import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:herfaty/profile%20screens/resetPasswordOwner.dart';

import '../pages/login.dart';
import '../profile screens/ShopOwnerProfile.dart';

class OwnerSettings extends StatefulWidget {
  const OwnerSettings({super.key});

  @override
  State<OwnerSettings> createState() => _OwnerSettingsState();
}

class _OwnerSettingsState extends State<OwnerSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الإعدادات",
            style: TextStyle(
              color: Color(0xff51908E),
              fontFamily: "Tajawal",
            )),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Color(0xff51908E),
        elevation: 3,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ShopOwnerProfile()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Color(0xff51908E)),
      ),
      body: SizedBox(
          height: 200,
          width: 600,
          child: ListView(
            padding: EdgeInsets.all(24),
            children: [
              SettingsGroup(
                title: "",
                children: <Widget>[
                  buildResetPassword(),
                  buildLogout(),
                ],
              )
            ],
          )),
    );
    // return SizedBox(
    //     height: 200,
    //     width: 200,
    //     child: Container(child: Center(child: Text('Owner settings page'))));
  }

//=========================RESET PASSWORD===========================
  Widget buildResetPassword() => TextButton(
        child: Container(
            child: Row(
          children: [
            IconWidget(
              icon: Icons.lock,
              color: Color(0xff51908E),
            ),
            SizedBox(
              width: 10,
            ),
            Text('إعادة تعيين كلمة المرور',
                style: TextStyle(
                    color: Color(0xff51908E),
                    fontFamily: "Tajawal",
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),

            // onTap: () {
            //
            // },
            SizedBox(
              width: 100,
            ),
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_forward_ios, color: Color(0xff51908E)),
            ),
          ],
        )),
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ResetPasswordOwner())),
      );
//===================================LOGOUT===============================

  Widget buildLogout() => TextButton(
        // leading: IconWidget(
        //   icon: Icons.logout,
        //   color: Color.fromARGB(255, 221, 112, 112),
        // ),
        // title: 'تسجيل الخروج',
        // subtitle: '',

        child: Container(
          child: Row(
            children: [
              IconWidget(
                icon: Icons.logout,
                color: Color.fromARGB(255, 221, 112, 112),
              ),
              SizedBox(
                width: 10,
              ),
              Text('تسجيل الخروج',
                  style: TextStyle(
                      color: Color.fromARGB(255, 221, 112, 112),
                      fontFamily: "Tajawal",
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ],
          ),
        ),
        onPressed: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("تنبيه"),
                  content: Text('سيتم تسجيل خروجك من الحساب'),
                  actions: <Widget>[
                    TextButton(
                      child: Text("تسجيل خروج",
                          style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        //Navigator.of(context).pop();
                        // FirebaseAuth.instance.signOut();
                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //     "/login", (Route<dynamic> route) => false);
                        Navigator.of(context, rootNavigator: true)
                            .pushReplacement(MaterialPageRoute(
                                builder: (context) => new login()));
                      },
                    ),
                    TextButton(
                      child: Text("تراجع"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        },
        //==========================================================
      );
}

class IconWidget extends StatelessWidget {
  final IconData icon;
  final Color color;

  const IconWidget({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}
