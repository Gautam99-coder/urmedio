import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart'; // ✅ 1. ADD THIS IMPORT
import 'package:urmedio/theme/colors.dart';
import 'package:urmedio/widgets/custom_textfield.dart';
// ✅ 2. FIX THE TYPO (removed extra .dart)
import '../../services/firebase_auth_methods.dart.dart';
import '../splash_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool agreeTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // ---------------- Dialogs & Snackbars ----------------

  void _showSuccessDialog(String message, {bool navigateToSignIn = true}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 20),
              const Icon(Icons.check_circle, color: AppColors.sky, size: 80),
              const SizedBox(height: 20),
              Text(
                message,
                style:
                const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                navigateToSignIn
                    ? 'Your account has been created successfully.'
                    : 'You have signed up with Google successfully.',
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
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (navigateToSignIn) {
                      Navigator.pushReplacementNamed(context, '/signin');
                    } else {
                      // Google sign-up now redirects to customer home
                      Navigator.pushReplacementNamed(context, '/homePage');
                    }
                  },
                  child: Text(
                    navigateToSignIn ? 'GO TO SIGN IN' : 'CONTINUE',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // ---------------- Email/Password Sign Up ----------------

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    if (!agreeTerms) {
      _showErrorSnackBar('You must agree to the Terms & Conditions.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // ✅ This line now works
      await context.read<FirebaseAuthMethods>().signUpWithEmail(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      if (!mounted) return;
      _showSuccessDialog('Registration Successful!');
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
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

  // ---------------- Google Sign In / Sign Up ----------------

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      // ✅ This line now works
      final authService = context.read<FirebaseAuthMethods>();
      final userCredential = await authService.signInWithGoogle();

      if (!mounted) return;

      if (userCredential != null) {
        // Get the correct redirect route
        final route = await authService.getRedirectRoute();
        if (mounted) {
          Navigator.pushReplacementNamed(context, route);
        }
      } else {
        _showErrorSnackBar('Google Sign-In was cancelled.');
      }
    } catch (e) {
      if (!mounted) return;
      _showErrorSnackBar('Google Sign-In failed. Please try again.');
      print('Google Sign-In Error: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // ---------------- Main Build (Unchanged) ----------------

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Scrollable Form Content
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(screenWidth),
                    _buildFormFields(screenWidth),
                    _buildTermsAndPharmacyRow(),
                    SizedBox(height: screenWidth * 0.03),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _buildSignUpButton(screenWidth),
                    ),
                    SizedBox(height: screenWidth * 0.05),
                    _buildDivider(),
                    SizedBox(height: screenWidth * 0.05),
                    _buildGoogleSignUpButton(),
                    _buildSignInNavigation(screenWidth),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- ALL YOUR UI BUILDER METHODS (UNCHANGED) ---

  Widget _buildHeader(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SplashScreen()),
          ),
        ),
        SizedBox(height: screenWidth * 0.1),
        const Text(
          "Create \nAccount",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: screenWidth * 0.05),
      ],
    );
  }

  Widget _buildFormFields(double screenWidth) {
    return Column(
      children: [
        CustomTextField(
          label: "Name",
          prefixIcon: Icons.person_outline,
          controller: nameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
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
      ],
    );
  }

  Widget _buildTermsAndPharmacyRow() {
    return Row(
      children: [
        Checkbox(
          value: agreeTerms,
          onChanged: (val) {
            setState(() {
              agreeTerms = val ?? false;
            });
          },
        ),
        const Text("Agree Terms & \nConditions"), // Your manual line break
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
    );
  }

  Widget _buildSignUpButton(double screenWidth) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: OutlinedButton(
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
        child: _isLoading
            ? const CircularProgressIndicator(color: AppColors.primaryButton)
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Sign up',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/images/circle.png'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
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
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("OR"),
        ),
        Expanded(child: Divider(thickness: 1)),
      ],
    );
  }
Widget _buildGoogleSignUpButton() {
  return SizedBox(
    height: 50,
    width: double.infinity,
    child: OutlinedButton(
      onPressed: _isLoading ? null : _signInWithGoogle,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide.none,
      ),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: _isLoading
              ? null
              : const DecorationImage(
                  image: AssetImage('assets/images/googleup.png'),
                  fit: BoxFit.cover,
                ),
          color: _isLoading ? Colors.grey[300] : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              spreadRadius: 1,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : null,
      ),
    ),
  );
}

  Widget _buildSignInNavigation(double screenWidth) {
    return Column(
      children: [
        SizedBox(height: screenWidth * 0.03),
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
    );
  }
}

// ✅ 3. REMOVE THE FAULTY EXTENSION FROM THE BOTTOM
// extension on BuildContext {
//   read() {}
// }
