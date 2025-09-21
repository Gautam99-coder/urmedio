import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';

class PharmacySignup extends StatefulWidget {
  const PharmacySignup({super.key});

  @override
  State<PharmacySignup> createState() => _PharmacySignupState();
}

class _PharmacySignupState extends State<PharmacySignup> {
  final TextEditingController pharmacyNameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool agreeTerms = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          /// 🔹 Full-screen background image
          SizedBox.expand(
            child: Image.asset(
              'assets/images/bg1.png',
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 Foreground content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, size: 28),
                        color: const Color.fromARGB(255, 47, 46, 46),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Title
                    const Text(
                      "Create \nPharmacy Account",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // 🔹 Changed to black
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Input fields
                    CustomTextField(
                      label: "Pharmacy Id",
                      controller: pharmacyNameController,
                      icon: Icons.local_pharmacy,
                    ),
                    CustomTextField(
                      label: "Pharmacy Name",
                      controller: ownerNameController,
                      icon: Icons.person,
                    ),
                    CustomTextField(
                      label: "Email",
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      icon: Icons.email,
                    ),
                    // CustomTextField(
                    //   label: "Phone Number",
                    //   controller: phoneController,
                    //   keyboardType: TextInputType.phone,
                    //   icon: Icons.phone,
                    // ),
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

                    const SizedBox(height: 0),

                    // Terms & Conditions
                    Row(
                      children: [
                        Checkbox(
                          value: agreeTerms,
                          onChanged: (val) {
                            setState(() {
                              agreeTerms = val ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // TODO: Show terms page
                            },
                            child: const Text(
                              "Agree Terms & Conditions",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black, // 🔹 Changed to black
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 0),

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
                                  Navigator.pushNamed(context, 'phomePage');
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
                                  Navigator.pushNamed(context, '/phomePage');
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
                    const SizedBox(height: 5),
                    const SizedBox(height: 5),

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
          ),
        ],
      ),
    );
  }
}