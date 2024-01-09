import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smita_firebase/Widgets/uihelper.dart';

class FetchImage extends StatefulWidget {
  const FetchImage({super.key});

  @override
  State<FetchImage> createState() => _FetchImageState();
}

class _FetchImageState extends State<FetchImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch Data"),
        centerTitle: true,
      ),
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection("Images").snapshots() ,builder: (context,snapshots){
        if(snapshots.connectionState==ConnectionState.active){
          if(snapshots.hasData){
            return ListView.builder(itemBuilder: (context,index){
              return ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage("${snapshots.data!.docs[index]["Image URL"]}"),),
                title: Text("${snapshots.data!.docs[index]["Image Name"]}"),
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
