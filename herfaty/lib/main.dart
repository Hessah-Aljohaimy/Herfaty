import 'package:flutter/material.dart';
import 'package:herfaty/pages/login.dart';
import 'package:herfaty/pages/splash.dart';
import 'package:herfaty/pages/welcome.dart';
import 'package:herfaty/pages/forget_password.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:herfaty/screens/navCustomer.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:herfaty/pages/signupCustomer.dart';
import 'package:herfaty/pages/signupHerafy.dart';
import 'package:herfaty/pages/welcomeRegestration.dart';

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
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "AE"), // English, no country code
      ],
      locale: Locale("ar", "AE"),
      initialRoute: "/",
      routes: {
        "/": (context) => const Splash(),
        "/welcome": (context) => const Welcome(),
        "/login": (context) => const login(),
        "/forget_password": (context) => const forget_password(),
        "/home_screen": (context) => const nav(),
        "/welcomeRegestration": (context) => const WelcomeRegestration(),
        "/signupCustomer": (context) => const SignupCustomer(),
        "/signupHerfay": (context) => const SignupHerafy(),
      },
    );
  }
}
