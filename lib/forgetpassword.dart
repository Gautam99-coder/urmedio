import 'package:abc_app/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  // Controller from your code
  final TextEditingController emailController = TextEditingController();

  // Your forgetpassword function (unchanged)
  forgetpassword(String email) async {
    if (email.isEmpty) { // Simplified check
      return Uihelper.CustomAlertBox(context, "Enter an Email To Reset Password");
    } else {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        // Added a success message for the user
        // ignore: use_build_context_synchronously
        Uihelper.CustomAlertBox(context, "Password reset email sent. Please check your inbox.");
      } on FirebaseAuthException catch (e) {
        // ignore: use_build_context_synchronously
        Uihelper.CustomAlertBox(context, e.code.toString());
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg1.png'), // Using the same background
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. Back Button
          Positioned(
            top: 40.0, // Adjust for status bar
            left: 10.0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          // 3. Main Content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Spacing from top
                    const SizedBox(height: 120),

                    // Title
                    const Text(
                      "Reset\nPassword", // New Title
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1), // Dark blue
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Enter the email associated with your account.",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 30),

                    // Email Field
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _buildInputDecoration("Email"),
                    ),
                    const SizedBox(height: 30),

                    // Reset Password Button Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Reset", // Changed text
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Calls your forgetpassword function
                            forgetpassword(emailController.text.trim());
                          },
                          child: Image.asset(
                            'assets/images/circle.png', // Using the same button
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create consistent text field styling
  InputDecoration _buildInputDecoration(String label, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 25.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2.0),
      ),
      suffixIcon: suffixIcon,
    );
  }
}