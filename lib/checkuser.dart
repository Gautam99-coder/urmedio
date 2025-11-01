import 'package:abc_app/loginpage.dart';
import 'package:abc_app/screens/patient/patient_homepage.dart';
import 'package:abc_app/screens/pharmacy/pharmacy_homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Checkuser extends StatefulWidget {
  const Checkuser({super.key});

  @override
  State<Checkuser> createState() => _CheckuserState();
}

class _CheckuserState extends State<Checkuser> {
  // This function checks auth state and then fetches role from Firestore
  Future<String?> checkUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          return userDoc.data()?['role']; // Returns 'patient' or 'pharmacy'
        }
      } catch (e) {
        print("Error fetching user role: $e");
        return null; // On error, send to login
      }
    }
    return null; // No user logged in
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: checkUserRole(), // Call the function that returns the role
      builder: (context, snapshot) {
        // Show a loading circle while checking
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Check the data from the future
        if (snapshot.hasData) {
          String? role = snapshot.data;
          if (role == 'pharmacy') {
            return const PharmacyHomePage();
          } else {
            // Default to patient home page if role is 'patient' or anything else
            return const PatientHomePage();
          }
        }

        // If no data (snapshot.data is null), send to login page
        return const Loginpage();
      },
    );
  }
}