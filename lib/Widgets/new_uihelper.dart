import 'package:flutter/material.dart';

class Uihelper{
  static CustomTextField(String text,IconData iconData, bool toHide,TextEditingController controller){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: toHide,
        decoration: InputDecoration(
          fillColor: Color(0xFFE1e1e1),
          filled: true,
          hintText: text,
          prefixIcon: Icon(iconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
  static CustomButton(VoidCallback voidCallback,String text){
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFF4F5A),
          foregroundColor: Colors.white,
          fixedSize: Size(320, 55),

        ),

        onPressed: (){
          voidCallback();
        }, child: Text(text));
  }

  static CustomAlertBox(String text,BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(text),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },

          ),


        ],

      );
    });


  }

}