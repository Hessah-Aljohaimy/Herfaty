import 'package:flutter/material.dart';
import 'package:herfaty/signupShop.dart';
import 'package:herfaty/splash.dart';
import 'package:herfaty/signupCustomer.dart';
import 'package:herfaty/signupHerafy.dart';
import 'package:herfaty/test_Login.dart';
import 'package:herfaty/welcomeRegestration.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "AE"),
        Locale("ar", "AE"),
      ],
      initialRoute: "/",
      routes: {
        "/": (context) => const Splash(),
        "/welcomeRegestration": (context) => const WelcomeRegestration(),
        "/signupCustomer": (context) => const SignupCustomer(),
        "/signupHerfay": (context) => const SignupHerafy(),
        "/signupShop": (context) => const SignupShop(),
        "/test_Login": (context) => const TestLogin(),
      },
    );
  }
}
