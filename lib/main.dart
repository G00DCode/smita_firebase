import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:smita_firebase/Screens/addData.dart';
import 'package:smita_firebase/Screens/chechUser.dart';
import 'package:smita_firebase/Screens/fetchImage.dart';
import 'package:smita_firebase/Screens/fetch_data.dart';
import 'package:smita_firebase/Screens/in_app_notification.dart';
import 'package:smita_firebase/Screens/profile_upload.dart';
import 'package:smita_firebase/Screens/signup.dart';
import 'package:smita_firebase/Screens/signup_screen.dart';
import 'package:smita_firebase/Screens/verify_user.dart';
import 'package:smita_firebase/Services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.initialized();


  runApp(FireBaseSmita());
}

class FireBaseSmita extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true),
    );
  }
}
