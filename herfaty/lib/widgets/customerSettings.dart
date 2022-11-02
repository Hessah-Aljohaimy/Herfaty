import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
            padding: EdgeInsets.all(2),
            children: <Widget>[
              buildResetPassword(),
              buildLogout(),
            ],
          )),
    );
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
            MaterialPageRoute(builder: (context) => ResetPasswordCustomer())),
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: Center(
                    child: Text(
                      "تنبيه",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 221, 112, 112),
                        fontFamily: "Tajawal",
                      ),
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Container(
                          width: 250,
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: AssetImage('assets/images/logout.png'),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(
                        'سيتم تسجيل خروجك من الحساب',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 26, 96, 91),
                          fontFamily: "Tajawal",
                        ),
                      )),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text("تراجع"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
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
                        Fluttertoast.showToast(
                          msg: "تم تسجيل الخروج  بنجاح",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Color.fromARGB(255, 26, 96, 91),
                          textColor: Colors.white,
                          fontSize: 18.0,
                        );
                      },
                    ),
                  ],
                );
              });
        },
        //==========================================================
      );
}
