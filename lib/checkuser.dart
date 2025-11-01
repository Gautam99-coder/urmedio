import 'package:abc_app/loginpage.dart';
import 'package:abc_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Checkuser extends StatefulWidget {
  const Checkuser({super.key});

  @override
  State<Checkuser> createState() => _CheckuserState();
}

class _CheckuserState extends State<Checkuser> {
  @override
  Widget build(BuildContext context) {
    // ❌ cannot return Future — must return Widget
    // ✅ use FutureBuilder to call your async function correctly
    return FutureBuilder(
      future: checkusers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return snapshot.data!;
        }
        return const SizedBox(); // or a blank widget while waiting
      },
    );
  }

  Future<Widget> checkusers() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return MyHomePage(title: "My home page");
    } else {
      return const Loginpage();
    }
  }
}
