import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiHelper{
  static CustomTextField(TextEditingController controller,IconData iconData,String text,bool toHide){
   return Padding(
     padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 15),
     child: TextField(
       controller: controller,
       decoration: InputDecoration(
         hintText: text,
         suffixIcon: Icon(iconData),
         border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(25),
         )

       ),
     ),
   );

  }
  static CustomAlertBox(String text,BuildContext context){
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


  }


}