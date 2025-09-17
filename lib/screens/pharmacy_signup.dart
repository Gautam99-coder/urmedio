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
                "Create Pharmacy Account",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Sign Up Button
              CustomButton(
                text: "Sign Up as Pharmacy",
                onPressed: () {
                  if (!agreeTerms) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text("Please agree to the Terms & Conditions")),
                    );
                    return;
                  }
                  // TODO: Handle pharmacy signup logic
                },
              ),
              const SizedBox(height: 20),

              // Already have an account? Sign In
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already registered? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signin');
                    },
                    child: const Text(
                      "Sign In",
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
