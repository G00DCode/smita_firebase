import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smita_firebase/Screens/homescreen.dart';
import 'package:smita_firebase/Screens/signin_screen.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  Widget build(BuildContext context) {
    return checkUser();
  }
}

checkUser(){
  final user=FirebaseAuth.instance.currentUser;
  if(user!=null){
    return HomeScreen();
  }
  else{
    return SignInScreen();
  }

}