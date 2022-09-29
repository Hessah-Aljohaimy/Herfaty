import 'package:flutter/material.dart';
import 'package:herfaty/LocalNotificationService.dart';
import 'package:herfaty/secondNotificationScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class notificationClass extends StatefulWidget {
  const notificationClass({super.key});

  @override
  State<notificationClass> createState() => _notificationClassState();
}

class _notificationClassState extends State<notificationClass> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Notification Demo'),
        centerTitle: true,
      ),
    );
  }

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
              print("pushinnnng الحمد لله ===========================");
              createNotification(0, "طلب جديد",
                  "وصلك طلب جديد أيهاالحِرفيّ الصغير، اضغط لعرض الطلبات ", "");
              print(docId);
              reference.doc('${docId}').update({"notification": "pushed"});
            }
          }
        }
      });
    });
  }

  void createNotification(
      int id, String title, String body, String payload) async {
    await service.showNotificationWithPayload(
        id: id,
        title: title,
        body: body,
        //what should be the payload?
        payload: 'payload content');
  }

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
