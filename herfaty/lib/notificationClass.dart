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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SizedBox(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'This is a demo of how to use local notifications in Flutter.',
                    style: TextStyle(fontSize: 20),
                  ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     await service.showNotification(
                  //         id: 0,
                  //         title: 'Notification Title',
                  //         body: 'Some body simple');
                  //   },
                  //   child: const Text('Show Local Notification'),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     await service.showScheduledNotification(
                  //       id: 0,
                  //       title: 'Notification Title',
                  //       body: 'Some body scheduled',
                  //       seconds: 4,
                  //     );
                  //   },
                  //   child: const Text('Show Scheduled Notification'),
                  // ),
                  ElevatedButton(
                    onPressed: () async {
                      await service.showNotificationWithPayload(
                          id: 0,
                          title: 'Notification Title',
                          body: 'Some body with payload',
                          payload: 'payload content');
                    },
                    child: const Text('Show Notification With Payload'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void listenToDB() {
    print("the notification form firestore method was called");
    CollectionReference reference =
        FirebaseFirestore.instance.collection('orders');
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.docChanges.forEach((change) {
        createNotification(
            0, "a new order", "you have a new order, tap to view", "");
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
