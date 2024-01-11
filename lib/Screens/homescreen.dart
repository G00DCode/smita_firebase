import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smita_firebase/Screens/login.dart';
import 'package:smita_firebase/Widgets/uihelper.dart';

import '../Widgets/new_uihelper.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffff4f5a),
        title: Text("User Details"),
        centerTitle: true,
      ),
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection("Users").snapshots() ,builder: (context,snapshots){
        if(snapshots.connectionState==ConnectionState.active){
          if(snapshots.hasData){
            return ListView.builder(itemBuilder: (context,index){
              return ListTile(
                leading: CircleAvatar(child: Text("${index+1}",style: TextStyle(color: Colors.white),),backgroundColor: Color(0xff1a2e35),),
                title: Text("${snapshots.data!.docs[index]["Username"]}"),
                subtitle:Text("${snapshots.data!.docs[index]["Email"]}") ,
              );
            },itemCount: snapshots.data!.docs.length,);

          }
          else if(snapshots.hasError){
            return Uihelper.CustomAlertBox("${snapshots.hasError.toString()}", context);

          }
          else{
            return Uihelper.CustomAlertBox("Data Not Found!", context);
          }

        }

        else{
          return Center(child: CircularProgressIndicator(),);
        }

      },),
      floatingActionButton: Uihelper.CustomButton(() {
      FirebaseAuth.instance.signOut().then((value){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LogInScreen()));

      });}, "Log Out"),

    );
  }


}
