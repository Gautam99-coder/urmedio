import 'package:abc_app/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  TextEditingController emailController=TextEditingController();
  forgetpassword(String email)async{
    if(email == ""){
      return Uihelper.CustomAlertBox(context, "Entert an Email To Reset Password");
    }
    else{
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        print("Reset email request sent successfully");
      } on FirebaseAuthException catch (e) {
        print("FirebaseAuth error: ${e.code} — ${e.message}");
      }

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Foget password"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Uihelper.CustomTextField(emailController, "Enter your Email", Icons.mail, false),
          SizedBox(height: 18,),
          Uihelper.CustomBtn((){
            forgetpassword(emailController.text.toString());
          }, "Reset Password")
        ],
      ),
    );
  }
}
