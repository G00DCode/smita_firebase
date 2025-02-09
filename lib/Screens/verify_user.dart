import 'package:flutter/material.dart';
import 'package:smita_firebase/Widgets/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp_screen.dart';

class VerifyUser extends StatefulWidget {
  const VerifyUser({super.key});

  @override
  State<VerifyUser> createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify User"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(
              phoneController, Icons.phone, "Enter Phone Number", false),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException ex) {},
                    codeSent: (String verficationOTP, int? UIDtoken) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(verficationOTP: verficationOTP,)));
                    },phoneNumber: phoneController.text.toString(),
                    codeAutoRetrievalTimeout: (String verficationOTP) {});
              },
              child: Text("Verify")),
        ],
      ),
    );
  }
}
