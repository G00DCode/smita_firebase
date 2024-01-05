import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smita_firebase/Screens/chechUser.dart';

void main(){
  runApp(FireBaseSmita());
}
class FireBaseSmita extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckUser(),
    );
  }

}