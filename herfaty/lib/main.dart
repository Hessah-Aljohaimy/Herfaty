// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:herfaty/screens/ownerProductsCateg.dart';
import 'package:herfaty/screens/owner_base_screen.dart';
import 'firebase_options.dart';
import 'package:herfaty/screens/customer_base_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', 'AE'),
      ],
      debugShowCheckedModeBanner: false,
      //home: const customerBaseScreen(),
      home: const ownerBaseScreen(),
      //home: const ownerProductsCategScreen(),
    );
  }
}
