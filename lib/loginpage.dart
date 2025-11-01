import 'package:abc_app/services/google_signin_helper.dart';
import 'package:abc_app/signup.dart';
import 'package:abc_app/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'main.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Uihelper.CustomAlertBox(context, "Enter required fields");
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage(title: "My homepage")),
      );
    } on FirebaseAuthException catch (ex) {
      Uihelper.CustomAlertBox(context, ex.code.toString());
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      User? user = await SimpleGoogleAuth.signInWithGoogle();

      if (user != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage(title: "My homepage")),
        );
      } else {
        Uihelper.CustomAlertBox(context, "Google Sign-In was cancelled");
      }
    } catch (e) {
      Uihelper.CustomAlertBox(context, "Google Sign-In failed: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Uihelper.CustomTextField(emailController, "Enter Email", Icons.email, false),
              const SizedBox(height: 20),
              Uihelper.CustomTextField(passwordController, "Enter Password", Icons.lock, true),
              const SizedBox(height: 20),
              Uihelper.CustomBtn(() {
                login(emailController.text.trim(), passwordController.text.trim());
              }, "Login"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: loginWithGoogle,
                    icon: Image.asset('assets/icons/google.png', height: 40),
                  ),
                  TextButton(onPressed: (){
                    Navigator.pushNamed(context, '/forgetpassword');
                  }, child: Text("Forget Password",style: TextStyle(color:Colors.orange),))
                ],
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an Account?", style: TextStyle(fontSize: 16)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Signup()));
                    },
                    child: const Text("Sign Up", style: TextStyle(fontSize: 16, color: Colors.red)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}