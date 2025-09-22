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
      // Prevents the background from resizing when the keyboard appears
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          // --- BACKGROUND IMAGE CONTAINER ---
          // This container sits at the bottom of the stack, serving as the background.
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                // You can change this to a different background image if you like
                image: AssetImage('assets/images/bg1.png'),
                fit: BoxFit.cover, // Ensures the image covers the entire screen
              ),
            ),
          ),

          // --- YOUR ORIGINAL SCREEN CONTENT ---
          // This SafeArea is placed on top of the background image.
          SafeArea(
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
                  const SizedBox(height: 60),

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
    
 Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("  forget your password? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/forgetPass');
                        },
                        child: const Text(
                          "Reset password",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

    Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {}, // keep for accessibility if needed
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.only(left: 205),
                          side: BorderSide.none,
                          backgroundColor: Colors.transparent,
                          overlayColor:
                              Colors.transparent, // 👈 remove button hover/splash
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text wrapped with InkWell so hover works only on text
                            InkWell(
                              onTap: () {
                          Navigator.pushNamed(context, '/homePage');
                        },
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Circle image also wrapped
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/homePage');
                                // handle tap on circle
                              },
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/circle.png'),
                                    fit: BoxFit.cover,
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
                          borderRadius: BorderRadius.circular(
                              12), // Match container corners
                        ),
                        side: BorderSide.none,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(12), // ✅ Rounded corners
                          image: const DecorationImage(
                            image:
                                AssetImage('assets/images/googleup.png'),
                            fit: BoxFit
                                .cover, // ✅ Fill the space without distortion
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
                      const Text("      Don’t have an account? "),
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
        ],
      ),
    );
  }
}