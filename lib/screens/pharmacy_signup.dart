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

    // You can adjust these to control the width/height of the form area.
    final double containerMaxWidth =
        screenWidth < 700 ? screenWidth * 0.95 : 600;
    final double containerMaxHeight = screenHeight * 0.85;

    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 Full-screen background image
          SizedBox.expand(
            child: Image.asset(
              'lib/assets/images/bg1.png', // <-- put your bg image path
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 Foreground content
          SafeArea(
            child: Center(
              child: Container(
                // Transparent: no color, no border, no shadow
                color: Colors.transparent,
                constraints: BoxConstraints(
                  maxWidth: containerMaxWidth,
                  maxHeight: containerMaxHeight,
                ),
                padding: const EdgeInsets.all(20),

                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, size: 28),
                          color: Colors.white, // looks better on bg image
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Title
                      const Text(
                        "Create Pharmacy Account",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Input fields
                      CustomTextField(
                        label: "Pharmacy Name",
                        controller: pharmacyNameController,
                        icon: Icons.local_pharmacy,
                      ),
                      CustomTextField(
                        label: "Owner Name",
                        controller: ownerNameController,
                        icon: Icons.person,
                      ),
                      CustomTextField(
                        label: "Email",
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        icon: Icons.email,
                      ),
                      CustomTextField(
                        label: "Phone Number",
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        icon: Icons.phone,
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

                      const SizedBox(height: 10),

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
                                "I agree to the Terms & Conditions",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Sign up button (right aligned)
                      Row(
                        children: [
                          const Spacer(),
                          SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // handle sign up text tap
                                  },
                                  borderRadius: BorderRadius.circular(4),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () {
                                    // handle sign up circle tap
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'lib/assets/images/circle.png'),
                                        fit: BoxFit.cover,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 6,
                                          spreadRadius: 1,
                                          offset: Offset(2, 4),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Already registered? Sign In
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already registered? ",
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/signin');
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
