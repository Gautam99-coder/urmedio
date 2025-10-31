// lib/screens/pharmacy_signup.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ✅ 1. ADD FIREBASE IMPORT
import 'package:urmedio/theme/colors.dart';
import 'package:urmedio/widgets/custom_textfield.dart';

import '../../services/firebase_auth_methods.dart.dart';

class PharmacySignup extends StatefulWidget {
  const PharmacySignup({super.key});

  @override
  State<PharmacySignup> createState() => _PharmacySignupState();
}

class _PharmacySignupState extends State<PharmacySignup> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController pharmacyIdController = TextEditingController();
  final TextEditingController pharmacyNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // ✅ 3. Create an instance of our service
  final AuthService _authService = AuthService();

  bool agreeTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    pharmacyIdController.dispose();
    pharmacyNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // ✅ 4. ADD ERROR SNACKBAR (Unchanged)
  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // This success dialog is perfect and already redirects to '/phomePage' (Unchanged)
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Don't dismiss on tap
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              const Icon(Icons.check_circle, color: AppColors.info, size: 80),
              const SizedBox(height: 20),
              const Text(
                'Registration Successful!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Your pharmacy account has been created successfully.',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryButton,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close popup
                    Navigator.pushReplacementNamed(
                        context, '/phomePage'); // Go to pharmacy home
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ✅ 5. REWRITE _signUp TO USE THE SIMPLE SERVICE
  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    if (!agreeTerms) {
      _showErrorSnackBar('You must agree to the Terms & Conditions.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Use our simple auth service
      await _authService.signUpWithPharmacyEmail(
        pharmacyId: pharmacyIdController.text.trim(),
        pharmacyName: pharmacyNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;
      _showSuccessDialog();
    } on FirebaseAuthException catch (e) {
      String message = 'Registration failed.';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists for that email.';
      } else {
        message = e.message ?? message;
      }
      _showErrorSnackBar(message);
    } catch (e) {
      if (!mounted) return;
      _showErrorSnackBar('An unexpected error occurred. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 28),
                      color: Colors.black,
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                    ),
                    SizedBox(height: screenWidth * 0.1),
                    const Text(
                      "Create \nPharmacy Account",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.05),

                    // --- ALL YOUR CustomTextFields (UNCHANGED) ---
                    CustomTextField(
                      label: "Pharmacy ID",
                      prefixIcon: Icons.local_pharmacy_outlined,
                      controller: pharmacyIdController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Pharmacy ID';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenWidth * 0.04),
                    CustomTextField(
                      label: "Pharmacy Name",
                      prefixIcon: Icons.store_outlined,
                      controller: pharmacyNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Pharmacy Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenWidth * 0.04),
                    CustomTextField(
                      label: "Email",
                      prefixIcon: Icons.email_outlined,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenWidth * 0.04),
                    CustomTextField(
                      label: "Password",
                      prefixIcon: Icons.lock_outline,
                      controller: passwordController,
                      isPassword: true,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenWidth * 0.04),
                    CustomTextField(
                      label: "Confirm Password",
                      prefixIcon: Icons.lock_outline,
                      controller: confirmPasswordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    // --- End of TextFields ---

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
                        const Text(
                          "Agree Terms & Conditions",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: screenWidth * 0.02),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: OutlinedButton(
                          // ✅ 6. UPDATE onPressed
                          onPressed: _isLoading ? null : _signUp,
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.only(left: screenWidth * 0.55),
                            side: BorderSide.none,
                            backgroundColor: Colors.transparent,
                            overlayColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          // ✅ 7. ADD LOADING INDICATOR
                          child: _isLoading
                              ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryButton,
                              ))
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Sign up',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black, // Added color
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(20),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/circle.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.25),
                                      blurRadius: 6,
                                      spreadRadius: 1,
                                      offset: const Offset(2, 4),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.05),

                    // --- Divider and Sign In (UNCHANGED) ---
                    const Row(
                      children: [
                        Expanded(child: Divider(thickness: 1)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text("OR"),
                        ),
                        Expanded(child: Divider(thickness: 1)),
                      ],
                    ),
                    SizedBox(height: screenWidth * 0.05),
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
        ],
      ),
    );
  }
}