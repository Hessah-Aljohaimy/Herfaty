import 'package:flutter/material.dart';
import 'package:herfaty/pages/login.dart';
import 'package:herfaty/pages/splash.dart';
import 'package:herfaty/pages/welcome.dart';
import 'package:herfaty/pages/forget_password.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:herfaty/screens/navCustomer.dart';
import 'package:herfaty/screens/navOwner.dart';
import 'blocs/payment/payment_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:herfaty/pages/signupCustomer.dart';
import 'package:herfaty/pages/signupHerafy.dart';
import 'package:herfaty/pages/welcomeRegestration.dart';
import 'package:herfaty/screens/customer_base_screen.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:herfaty/cart/payForm.dart';
import '.env';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

/*
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
          // "/welcome": (context) => const Welcome(),
          "/login": (context) => const login(),
          "/forget_password": (context) => const forget_password(),
          "/home_screen_customer": (context) => const nav(),
          "/home_screen_owner": (context) => const navOwner(),
          "/welcomeRegestration": (context) => const WelcomeRegestration(),
          "/signupCustomer": (context) => const SignupCustomer(),
          "/signupHerfay": (context) => const SignupHerafy(),
          "/customer_base_screen": (context) => const customerBaseScreen(),
          "/payForm": (context) => const payForm(),
        },
      ),
    );
  }
}

*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => PaymentBloc(),
        child: Container(
          margin: EdgeInsets.only(top: 1.0, left: 8.0, right: 8.0),
          padding: EdgeInsets.all(1.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xff51908E), width: 1),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color(0xff51908E).withOpacity(0.9),
                    offset: Offset(1, 1))
              ]),
          child: BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, state) {
              CardFormEditController controller = CardFormEditController(
                initialDetails: state.cardFieldInputDetails,
              );
              if (state.status == PaymentStatus.initial) {
                print('dddddddddddddddddddddddd');
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'بيانات البطاقة',
                        style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff5596A5),
                          fontFamily: "Tajawal",
                        ),
                      ), // Text
                      SizedBox(
                        height: 30,
                      ),
                      const SizedBox(height: 20),
                      CardFormField(
                        controller: controller,
                      ), // CardFormField
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          (controller.details.complete)
                              ? context.read<PaymentBloc>().add(
                                    const PaymentCreateIntent(
                                      billingDetails: BillingDetails(
                                          email: 'auoosh2000@gmail.com'),
                                      items: [
                                        {'id': 0},
                                        {'id': 1},
                                      ],
                                    ),
                                  )
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('the form is not complete')),
                                );

                          print('dddddddddddddddddddddddd');
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff51908E)),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 45, vertical: 13)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(27))),
                        ),
                        child: Text(
                          "ادفع",
                          style: TextStyle(
                              fontSize: 19,
                              fontFamily: "Tajawal",
                              fontWeight: FontWeight.bold),
                        ),
                      ), // ElevatedButton
                    ],
                  ),
                );
              }

              if (state.status == PaymentStatus.success) {
                print('sssssssssssssssssssssssssssssssssss');
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('success'),
                    const SizedBox(
                      height: 10,
                      width: double.infinity,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PaymentBloc>().add(PaymentStart());
                      },
                      child: const Text('success'),
                    )
                  ],
                );
              }
              if (state.status == PaymentStatus.failure) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('failure'),
                    const SizedBox(
                      height: 10,
                      width: double.infinity,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PaymentBloc>().add(PaymentStart());
                      },
                      child: const Text('try again'),
                    )
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
