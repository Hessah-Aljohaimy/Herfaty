import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:herfaty/CustomerProducts/wishList/CustomerWishList.dart';
import 'package:herfaty/cart/cart.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/customerOrder/listOrderCustomer.dart';
import 'package:herfaty/screens/customerHome.dart';
import 'package:herfaty/widgets/logOut.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:herfaty/LocalNotificationService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class nav extends StatefulWidget {
  const nav({super.key});

  @override
  State<nav> createState() => _navState();
}

class _navState extends State<nav> {
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
          resizeToAvoidBottomInset: false,
          body: PersistentTabView(
            context,
            screens: screens(),
            items: navBarItems(),
          ),
        ));
  }

  List<Widget> screens() {
    return [
      customerHomeScreen(),
      Cart(),
      CustomerWishList(),
      listOrderCustomer(),
      logOutButton(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: "الرئيسية",
          activeColorPrimary: kPrimaryColor.withOpacity(0.9),
          inactiveColorPrimary: CupertinoColors.systemGrey),
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.cart),
          title: "سلتي",
          activeColorPrimary: kPrimaryColor.withOpacity(0.9),
          inactiveColorPrimary: CupertinoColors.systemGrey),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.favorite_border),
          title: "مفضلاتي",
          activeColorPrimary: kPrimaryColor.withOpacity(0.9),
          inactiveColorPrimary: CupertinoColors.systemGrey),
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.square_favorites),
          title: "طلباتي",
          activeColorPrimary: kPrimaryColor.withOpacity(0.9),
          inactiveColorPrimary: CupertinoColors.systemGrey),
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.person),
          title: "حسابي",
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
            final FirebaseAuth auth = FirebaseAuth.instance;
            final User? user = auth.currentUser;
            String thisCustomerId = user!.uid;
            var data = querySnapshot.docs.elementAt(index).data() as Map;
            var notificationStatus = data["notificationCustomer"];
            var docId = data["docId"];
            var customerId = data["customerId"];
            var orderState = data["status"];
            //print(notificationStatus);
            //print(index);
            if (customerId == thisCustomerId) {
              print("--Notification: This customer id is:${customerId}");
              if (notificationStatus == "notPushed" &&
                  orderState == "خارج للتوصيل") {
                print("pushinnnng===========================");
                createNotification(0, "طلب خارج للتوصيل",
                    "لديك طلب خارج للتوصيل سيصلك قريبًا، استعد لاستلامه!", "");
                //print(docId);
                reference.doc('${docId}').update({"notification": "pushed"});
              }
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
              builder: ((context) => listOrderCustomer(
                  //selectedPage: 0,
                  ))));
    }
  }
}
