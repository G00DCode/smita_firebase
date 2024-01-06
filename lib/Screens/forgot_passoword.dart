import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smita_firebase/Widgets/uihelper.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController=TextEditingController();

  forgot(String email )async{
    if(email==""){
      return UiHelper.CustomAlertBox("Enter Required Fields", context);

      }
    else{
      FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
        return UiHelper.CustomAlertBox("We have sent an email to Reset Password", context);
      });
        
    }
    }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailController, Icons.email, "Enter Email", false),
          SizedBox(height: 20,),
          TextButton(onPressed: (){
            forgot(emailController.text.toString());
          }, child: Text("Send OTP"))

        ],
      ),
    );
  }
}
