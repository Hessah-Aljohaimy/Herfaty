import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:herfaty/cart/cart.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/pages/welcome.dart';
import 'package:herfaty/screens/customerHome.dart';
import 'package:herfaty/screens/ownerHome.dart';
import 'package:herfaty/widgets/logOut.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herfaty/secondNotificationScreen.dart';
import 'package:herfaty/LocalNotificationService.dart';

class navOwner extends StatefulWidget {
  const navOwner({super.key});

  @override
  State<navOwner> createState() => _navOwnerState();
}

class _navOwnerState extends State<navOwner> {
  // This widget is the root of your application.

  late final LocalNotificationService service;
  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();
    listenToNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listenToDB();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar', 'AE'),
        ],
        home: Scaffold(
          body: PersistentTabView(
            context,
            screens: screens(),
            items: navBarItems(),
          ),
        ));
  }

  List<Widget> screens() {
    return [
      ownerHomeScreen(),
      logOutButton(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: "  الرئيسية",
          activeColorPrimary: kPrimaryColor.withOpacity(0.9),
          inactiveColorPrimary: CupertinoColors.systemGrey),
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.settings),
          title: "  الإعدادت ",
          activeColorPrimary: kPrimaryColor.withOpacity(0.9),
          inactiveColorPrimary: CupertinoColors.systemGrey),
    ];
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //Listen to changes in DB==============================
  void listenToDB() {
    print("the notification form firestore method was called");

    CollectionReference reference =
        FirebaseFirestore.instance.collection('orders');

    reference.snapshots().listen((querySnapshot) {
      querySnapshot.docChanges.forEach((change) {
        if (change.type == DocumentChangeType.added) {
          for (var index = 0; index < querySnapshot.size; index++) {
            var data = querySnapshot.docs.elementAt(index).data() as Map;
            var notificationStatus = data["notification"];
            var docId = data["docId"];
            print(notificationStatus);
            print(index);
            if (notificationStatus == "notPushed") {
              print("pushinnnng===========================");
              createNotification(0, "طلب جديد",
                  "وصلك طلب جديد أيهاالحِرفيّ الصغير! انقر لعرض الطلبات ", "");
              print(docId);
              reference.doc('${docId}').update({"notification": "pushed"});
            }
          }
        }
      });
    });
  }

  //Create notification=================================================
  void createNotification(
      int id, String title, String body, String payload) async {
    await service.showNotificationWithPayload(
        id: id,
        title: title,
        body: body,
        //what should be the payload?
        payload: 'payload content');
  }

  //Navigator push when cklicking on the notification(should open product list page)
  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload: $payload');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) =>
                  secondNotificationScreen(payload: payload))));
    }
  }
}
