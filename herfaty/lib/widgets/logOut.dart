import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herfaty/main.dart';
import 'package:herfaty/pages/welcome.dart';

import '../constants/color.dart';

class logOutButton extends StatelessWidget {
  const logOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "تسجيل الخروج"),
      floatingActionButton: FloatingActionButton.extended(
          heroTag: "btn1",
          label: Text(
            'تسجيل خروج',
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
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => new Welcome()));
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
          backgroundColor: kPrimaryColor),
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
