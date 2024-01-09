import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smita_firebase/Widgets/uihelper.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController titlecontroller =TextEditingController();
  TextEditingController descController= TextEditingController();

  addData(String title, String desc)async{
    if(title.isEmpty && desc.isEmpty){
      return UiHelper.CustomAlertBox("Enter required Fields", context);
    }
    else{
      FirebaseFirestore.instance.collection("Notes").doc(title).set({
        "Title":title,
        "Description":desc,

      }).then((value){
        UiHelper.CustomAlertBox("Data Inserted", context);

      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(titlecontroller, Icons.title, "Enter Title", false),
          UiHelper.CustomTextField(descController, Icons.description, "Enter Description", false),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            addData(titlecontroller.text.toString(), descController.text.toString());
          }, child: Text("Add Data")),
        ],
      ),
    );
  }
}
