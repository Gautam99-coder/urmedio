import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
      // MODIFIED: Wrapped the original body with a Stack
      body: Stack(
        children: [
          // ADDED: Container for the background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                // IMPORTANT: Replace with the actual path to your background image asset
                image: AssetImage('assets/images/bg1.png'),
                fit: BoxFit.cover, // This makes the image cover the entire screen
              ),
            ),
          ),
          // Your original screen content
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
                  const SizedBox(height: 40),

                  // Title
                  const Text(
                    "Create \nAccount",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Input Fields
                  CustomTextField(
                    label: "Name",
                    controller: nameController,
                    icon: Icons.person,
                  ),
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
                  CustomTextField(
                    label: "Confirm Password",
                    controller: confirmPasswordController,
                    obscureText: true,
                    icon: Icons.lock_outline,
                  ),

                  // Remember Me + Pharmacy Signup
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (val) {
                          setState(() {
                            rememberMe = val ?? false;
                          });
                        },
                      ),
                      const Text("Agree Terms & Conditions"),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/pharmacySignup');
                        },
                        child: const Text(
                          "Sign up as Pharmacy",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

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
                                // handle tap on text
                              },
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              child: const Text(
                                'Sign up',
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

                  // Already have account? Sign in
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signin');
                        },
                        child: const Text(
                          "Sign in",
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