import 'package:abc_app/loginpage.dart';
import 'package:abc_app/main.dart';
import 'package:abc_app/services/google_signin_helper.dart';
import 'package:abc_app/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUp(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Uihelper.CustomAlertBox(context, "Enter Required Fields");
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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

  Future<void> signUpWithGoogle() async {
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
        title: const Text("Signup Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Uihelper.CustomTextField(nameController, 'Enter your Name', Icons.person, false),
              const SizedBox(height: 18),
              Uihelper.CustomTextField(emailController, 'Enter your Email', Icons.email, false),
              const SizedBox(height: 18),
              Uihelper.CustomTextField(passwordController, 'Enter your Password', Icons.lock, true),
              const SizedBox(height: 18),
              Uihelper.CustomBtn(() {
                signUp(emailController.text.trim(), passwordController.text.trim());
              }, "Sign Up"),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already Have an account?", style: TextStyle(fontSize: 16)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Loginpage()));
                    },
                    child: const Text("Login", style: TextStyle(color: Colors.red, fontSize: 16)),
                  )
                ],
              ),
              const SizedBox(height: 18),
              IconButton(
                onPressed: signUpWithGoogle,
                icon: Image.asset('assets/icons/google.png', height: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}