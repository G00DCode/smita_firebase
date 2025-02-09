import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:smita_firebase/Widgets/uihelper.dart';

class ProfileUpload extends StatefulWidget {
  const ProfileUpload({super.key});

  @override
  State<ProfileUpload> createState() => _ProfileUploadState();
}

class _ProfileUploadState extends State<ProfileUpload> {
  TextEditingController imageController = TextEditingController();
  File? pickedImage;

  _showAlert() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Pick Image From"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  title: Text("Gallery"),
                  trailing: Icon(Icons.image),
                ),
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  title: Text("Camera"),
                  trailing: Icon(Icons.camera_alt),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
          );
        });
  }

  pickImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });
    } catch (ex) {
      return UiHelper.CustomAlertBox("${ex.toString()}", context);
    }
  }

  auth(String title) async {
    if (title == "" && pickedImage == null) {
      return UiHelper.CustomAlertBox("Enter Required Fields", context);
    } else {
      uploadImage();
    }
  }

  uploadImage() async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref("Profile Pictures")
        .child(imageController.text.toString())
        .putFile(pickedImage!);

    TaskSnapshot taskSnapshot=await uploadTask;
    String imageUrl=await taskSnapshot.ref.getDownloadURL();
    String imageName =imageController.text.toString();
    
    FirebaseFirestore.instance.collection("Images").doc(imageName).set({
      "Image Name":imageName,
      "Image URL":imageUrl,
    }).then((value) {
      return UiHelper.CustomAlertBox("Image Uploaded", context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Upload"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _showAlert();
            },
            child: pickedImage == null
                ? CircleAvatar(
                    child: Icon(
                      Icons.person,
                      size: 70,
                    ),
                    radius: 70,
                  )
                : CircleAvatar(
                    backgroundImage: FileImage(pickedImage!),
                    radius: 70,
                  ),
          ),
          SizedBox(
            height: 20,
          ),
          UiHelper.CustomTextField(
              imageController, Icons.image, "Enter Image Name", false),
          SizedBox(height: 30),
          ElevatedButton(onPressed: () {
            auth(imageController.text.toString());

          }, child: Text("SAVE")),
        ],
      ),
    );
  }
}
