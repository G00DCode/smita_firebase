import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smita_firebase/Screens/login.dart';
import 'package:smita_firebase/Widgets/uihelper.dart';
import '../Widgets/new_uihelper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController= TextEditingController();
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();

  signUp(String email, String password,String name)async{
    if(email==""&& password==""&&name==""){
      return Uihelper.CustomAlertBox("Enter Required Fields", context);
    }
    else{
      UserCredential? userCredential;
      try{
        userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value)
        {
          return Uihelper.CustomAlertBox("User Created", context);
        }).then((value) {
          FirebaseFirestore.instance.collection("Users").doc(email).set({
            "Email":email,
            "Username":name,
            "Password":password,


          }).then((value) {

            return Uihelper.CustomAlertBox("Data Inserted", context);


          }).then((value) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogInScreen()));

          });
        });
      }
      on FirebaseAuthException catch(ex){
        return UiHelper.CustomAlertBox(ex.code.toString(), context);
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(

              children: [
                SizedBox(height: 50,),
                Container(
                  height: 210,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/chat.jpg"),fit: BoxFit.cover,
                      )
                  ),


                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF1A2E35),

                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                  ),

                  height: 500,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Uihelper.CustomTextField("Enter Username", Icons.person, false, nameController),
                          Uihelper.CustomTextField("Enter Email", Icons.email, false,emailController),
                          Uihelper.CustomTextField("Enter Password", Icons.password, true,passwordController),
                          SizedBox(height: 15,),
                          Uihelper.CustomButton(() {
                            signUp(emailController.text.toString(), passwordController.text.toString(), nameController.text.toString());
                          }, "Create Account"),
                          SizedBox(height: 20,),
                          Text("OR",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: Image.network("https://assets.stickpng.com/images/58e91965eb97430e819064f5.png"),
                                ),
                              ),
                              SizedBox(width:40,),
                              InkWell(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: Image.network("https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png"),

                                ),
                              ),
                              SizedBox(width: 40,),

                              InkWell(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: Image.network("https://assets.stickpng.com/images/580b57fcd9996e24bc43c53e.png"),

                                ),
                              ),



                            ],),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text( "Already have an account?",style: TextStyle(color: Colors.white),),
                              TextButton(onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogInScreen()));
                              },
                                child:Text("Log In",style: TextStyle(color: Color(0xFFFf4f5a)), ),


                              ),

                            ],
                          ),
                        ]  ),

                  ),

                )],
            ),
          ),




        ),
      ),

    );
  }
}
