import 'package:flutter/material.dart';
import 'package:smita_firebase/Widgets/uihelper.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

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

        ElevatedButton(onPressed: (){
        }, child: Text("OTP"))
      ],
    ),

    );
  }
}
