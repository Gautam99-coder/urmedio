import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              IconButton(
                icon: const Icon(Icons.arrow_back, size: 28),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 10),

              // Title
              const Text(
                "Sign In",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Input fields
              CustomTextField(
                label: "Email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email,
              ),
              CustomTextField(
                label: "Password",
                controller: passwordController,
                obscureText: true,
                icon: Icons.lock,
              ),

          
Align(
  alignment: Alignment.centerRight, // 👈 right-align the entire button
  child: SizedBox(
    height: 50,
    width: double.infinity,
    child: OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sign in',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8), // spacing
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), // 50% radius → circle
              image: const DecorationImage(
                image: AssetImage(
                  'lib/assets/images/circle.png',
                ),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25), // shadow color
                  blurRadius: 6, // softness
                  spreadRadius: 1, // how far it spreads
                  offset: const Offset(2, 4), // horizontal & vertical shift
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
),

   
              // OR Divider
              Row(
                children: const [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("OR"),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              const SizedBox(height: 20),

              
SizedBox(
  height: 30, // ✅ Increased height to fit image properly
  width: double.infinity,
  child: OutlinedButton(
    onPressed: () {},
    style: OutlinedButton.styleFrom(
      padding: EdgeInsets.zero, // ✅ Remove default padding
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Match container corners
      ),
      side: BorderSide.none,
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), // ✅ Rounded corners
        image: const DecorationImage(
          image: AssetImage('lib/assets/images/googleup.png'),
          fit: BoxFit.cover, // ✅ Fill the space without distortion
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(2, 4),
          ),
        ],
      ),
    ),
  ),
),


              const SizedBox(height: 10),

              // Don’t have an account? Sign Up
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("    Don’t have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
