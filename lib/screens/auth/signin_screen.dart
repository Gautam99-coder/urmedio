import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart'; // ✅ THIS IS THE FIX
import 'package:urmedio/theme/colors.dart';
import 'package:urmedio/widgets/custom_textfield.dart';

import '../../services/firebase_auth_methods.dart.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // ---------------- Email / Password Sign-In ----------------
  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // ✅ This line now works
      final authService = context.read<FirebaseAuthMethods>();
      await authService.signInWithEmail(
        email: emailController.text,
        password: passwordController.text,
      );

      // Get the correct redirect route
      final route = await authService.getRedirectRoute();
      if (mounted) {
        Navigator.pushReplacementNamed(context, route);
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Sign In failed.';
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        message = 'Invalid email or password.';
      } else {
        message = e.message ?? message;
      }
      _showErrorSnackBar(message);
    } catch (e) {
      _showErrorSnackBar('An unexpected error occurred. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // ---------------- Google Sign-In ----------------
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
      }
      // If userCredential is null, the user cancelled, so do nothing.
    } on Exception catch (e) {
      _showErrorSnackBar('Google Sign-In failed: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // ---------------- UI Build (Unchanged) ----------------

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
                    _buildHeader(screenWidth),
                    _buildFormFields(screenWidth),
                    _buildForgotPasswordRow(),
                    SizedBox(height: screenWidth * 0.04),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _buildSignInButton(screenWidth),
                    ),
                    SizedBox(height: screenWidth * 0.05),
                    _buildDivider(),
                    SizedBox(height: screenWidth * 0.05),
                    _buildGoogleSignInButton(screenWidth),
                    _buildSignUpNavigation(screenWidth),
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
          onPressed: () => Navigator.pushNamed(context, '/signup'),
        ),
        SizedBox(height: screenWidth * 0.15),
        const Text(
          "Sign In",
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
          label: "Email",
          prefixIcon: Icons.email_outlined,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Please enter a valid email address';
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
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildForgotPasswordRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            // This navigation now works because we added the route
            Navigator.pushNamed(context, '/forgetPass');
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "Forgot password?",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton(double screenWidth) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: _isLoading ? null : _signIn,
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
              'Sign in',
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

  Widget _buildGoogleSignInButton(double screenWidth) {
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

  Widget _buildSignUpNavigation(double screenWidth) {
    return Column(
      children: [
        SizedBox(height: screenWidth * 0.03),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don’t have an account? "),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text(
                "Sign Up",
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
