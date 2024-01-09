import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smita_firebase/Screens/addData.dart';
import 'package:smita_firebase/Screens/chechUser.dart';
import 'package:smita_firebase/Screens/fetch_data.dart';
import 'package:smita_firebase/Screens/profile_upload.dart';
import 'package:smita_firebase/Screens/signup_screen.dart';
import 'package:smita_firebase/Screens/verify_user.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FireBaseSmita());
}
class FireBaseSmita extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileUpload(),
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true),

    );
  }

}