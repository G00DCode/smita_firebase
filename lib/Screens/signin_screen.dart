import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smita_firebase/Screens/forgot_passoword.dart';
import 'package:smita_firebase/Screens/homescreen.dart';
import 'package:smita_firebase/Screens/signup_screen.dart';
import 'package:smita_firebase/Widgets/uihelper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController=TextEditingController();
  signIn(String email, String password)async{
    if(email==""&& password==""){

          return UiHelper.CustomAlertBox("Enter Required Fields", context);

    }
    else{
      UserCredential? userCredential;
      try{
        userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        });
      }
      on FirebaseAuthException catch(ex){

            return UiHelper.CustomAlertBox(ex.code.toString(), context);

      }


    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignIn Screen"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailController, Icons.email, "Enter Email", false),
          UiHelper.CustomTextField(passwordController, Icons.password, "Enter Password", true),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));}, child: Text("Forgot Password?")),
            ],
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            signIn(emailController.text.toString(), passwordController.text.toString());
          }, child: Text("Sign In"))   ,
        SizedBox(height: 15,),
        TextButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUp()));
        }, child: Text("Create Account"))
        ],
      ),
    );
  }
}
