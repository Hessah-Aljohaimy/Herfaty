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
    var orderStatus;

    CollectionReference reference =
        FirebaseFirestore.instance.collection('orders');

    reference.snapshots().listen((querySnapshot) {
      querySnapshot.docChanges.forEach((change) async {
        DocumentSnapshot documentSnapshot;
        var a =
            await FirebaseFirestore.instance.collection('orders').doc().get();

        if (a.exists) {
          print("document exists");
          reference.doc().get().then((value) {
            documentSnapshot = value; // we get the document here
            orderStatus = documentSnapshot['status'];
          });
          if (change.type == DocumentChangeType.added &&
              orderStatus == "ready") {
            print("true condition");
            createNotification(
                0, "a new order", "you have a new order, tap to view", "");
          }
        } else {
          print("document does not exist 000000000000000000000");
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
