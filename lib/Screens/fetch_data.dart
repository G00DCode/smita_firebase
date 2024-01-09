import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smita_firebase/Widgets/uihelper.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch Data"),
        centerTitle: true,
      ),
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection("Users").orderBy("Email",descending: true ).snapshots() ,builder: (context,snapshots){
        if(snapshots.connectionState==ConnectionState.active){
          if(snapshots.hasData){
            return ListView.builder(itemBuilder: (context,index){
              return ListTile(
                leading: CircleAvatar(child: Text("${index+1}")),
                title: Text("${snapshots.data!.docs[index]["Email"]}"),
              );
            },itemCount: snapshots.data!.docs.length,);

          }
          else if(snapshots.hasError){
            return UiHelper.CustomAlertBox("${snapshots.hasError.toString()}", context);

          }
          else{
            return UiHelper.CustomAlertBox("Data Not Found!", context);
          }

        }

        else{
          return Center(child: CircularProgressIndicator(),);
        }

      },),
    );
  }
}
