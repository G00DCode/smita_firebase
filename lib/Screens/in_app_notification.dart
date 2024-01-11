// notification_service.dart

import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> requestNotificationPermission() async {
  await FirebaseMessaging.instance.requestPermission();
}

void initializeFirebaseMessaging() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      log("Foreground Message Received: ${message.notification!.title}");
      // Firebase In-App Messaging will automatically handle displaying messages.
    }
  });
}
