import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:herfaty/pages/login.dart';
import 'package:herfaty/profile%20screens/resetPasswordOwner.dart';
import 'package:herfaty/widgets/logOut.dart';
import 'package:herfaty/widgets/ownerSettings.dart';

import '../profile screens/resetPasswordCustomer.dart';

class CustomerSettings extends StatefulWidget {
  const CustomerSettings({super.key});

  @override
  State<CustomerSettings> createState() => _CustomerSettingsState();
}

class _CustomerSettingsState extends State<CustomerSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الإعدادات", style: TextStyle(color: Color(0xff51908E))),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Color(0xff51908E),
        elevation: 3,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => logOutButton()));
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
            children: <Widget>[
              buildResetPassword(),
              buildLogout(),
            ],
          )),
    );
  }

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
            Text('إعادة تعيين كلمة المرور'),

            // onTap: () {
            //
            // },
          ],
        )),
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ResetPasswordCustomer())),
      );

  Widget buildLogout() => SimpleSettingsTile(
        leading: IconWidget(
          icon: Icons.logout,
          color: Color.fromARGB(255, 221, 112, 112),
        ),
        title: 'تسجيل الخروج',
        subtitle: '',
        onTap: () async {
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

          /*Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
              return Welcome();
            }));*/
        },
      );
}
