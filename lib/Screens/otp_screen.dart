import 'package:flutter/material.dart';
import 'package:smita_firebase/Screens/homescreen.dart';
import 'package:smita_firebase/Widgets/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
class OTPScreen extends StatefulWidget {
  String verficationOTP;
   OTPScreen({super.key,required this.verficationOTP});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController OTPController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Screen'),
        centerTitle: true,
      ),body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UiHelper.CustomTextField(OTPController, Icons.phone, "Enter OTP", false),
        SizedBox(height: 20),

        ElevatedButton(onPressed: ()async{
          try{
            PhoneAuthCredential credential=await PhoneAuthProvider.credential(verificationId: widget.verficationOTP, smsCode: OTPController.text.toString());
            FirebaseAuth.instance.signInWithCredential(credential).then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            });
          }
          catch(ex){
            return UiHelper.CustomAlertBox(ex.toString(), context);
          }

        }, child: Text("OTP"))
      ],
    ),

    );
  }
}
