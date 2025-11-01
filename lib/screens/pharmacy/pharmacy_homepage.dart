import 'package:abc_app/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PharmacyHomePage extends StatelessWidget {
  const PharmacyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pharmacy Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Loginpage()),
              );
            },
          )
        ],
      ),
      body: const Center(
        child: Text(
          "Welcome, Pharmacy!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}