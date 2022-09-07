import 'package:flutter/material.dart';
import 'package:herfaty/pages/login.dart';
import 'package:herfaty/pages/welcome.dart';
import 'package:herfaty/pages/forget_password.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
 
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute: "/" ,
      routes: {
        "/" : (context) => const Welcome(),
        "/login" : (context) => const login(),
        "/forget_password" : (context) => const forget_password(),

      },
    );
  }
}