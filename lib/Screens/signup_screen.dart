import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smita_firebase/Screens/signin_screen.dart';
import 'package:smita_firebase/Widgets/uihelper.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController=TextEditingController();


  signUp(String email, String password)async{
    if(email==""&& password==""){

          return UiHelper.CustomAlertBox("Enter Required Fields", context);
    }
    else{
      UserCredential? userCredential;
      try{
        userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {

              return UiHelper.CustomAlertBox("User Created", context);
        }).then((value) {
          FirebaseFirestore.instance.collection("Users").doc(email).set({
            "Email":email,
          }).then((value){
            return UiHelper.CustomAlertBox("Data Inserted", context);
        });
        });
      }
      on FirebaseAuthException catch(ex){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return UiHelper.CustomAlertBox(ex.code.toString(), context);
          },
        );
      }


    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailController, Icons.email, "Enter Email", false),
          UiHelper.CustomTextField(passwordController, Icons.password, "Enter Password", true),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            signUp(emailController.text.toString(), passwordController.text.toString());
          }, child: Text("Sign Up")),
          SizedBox(height: 15,),
          TextButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
          }, child: Text("Sign In")),
    


        ],
      ),
    );
  }
}
