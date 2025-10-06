import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // Key for validation
  final _formKey = GlobalKey<FormState>();
  // Controller to get the email input value
  final TextEditingController _emailController = TextEditingController();

  // Define the primary blue color from the UI
  static const primaryBlue = Color.fromARGB(255, 20, 40, 95);

  // --- Validation Logic ---
  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your registered email.';
    }
    // Simple email format check
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  // --- Pop-up Dialog ---
  void _showOtpSentDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap OK to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              SizedBox(width: 10),
              Text('Verification Sent', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          content: Text(
            'We have sent an OTP to ${_emailController.text}. Please check your inbox.',
            style: const TextStyle(fontSize: 14),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Navigate to the OTP screen after the pop-up is closed
                Navigator.pushNamed(context, '/otpsrc');
              },
              child: const Text('OK', style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  // --- Send OTP Handler ---
  void _sendOtp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // If validation passes, show the pop-up and then navigate
      _showOtpSentDialog(context);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Setting to true to allow the body to resize when the keyboard appears
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg1.png', // Placeholder asset name
              fit: BoxFit.cover,
            ),
          ),
          // Screen Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // Back Button
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Expanded(
                    // Wrap the main content in a SingleChildScrollView to handle keyboard overlap gracefully
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          // Add padding equivalent to the keyboard height to scroll content up
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min, // Use minimum space
                            children: [
                              // Added space for centering effect (adjustable)
                              const SizedBox(height: 120),
                              // Forgot Password Text
                              const Text(
                                'Forgot Password',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Subtitle Text
                              const Text(
                                'Enter your registered email to reset password.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 32),
                              // Email Input Field (Now a TextFormField for validation)
                              TextFormField(
                                controller: _emailController,
                                validator: _emailValidator,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  errorStyle: const TextStyle(height: 0.8), // Compact error message
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                    horizontal: 16.0,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                    color: primaryBlue,
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 24),
                              // Send OTP Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () => _sendOtp(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryBlue,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                  ),
                                  child: const Text(
                                    'Send OTP',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // "Remember your password? Sign in" text (Note: This links to a Sign In page, not Register)
                              GestureDetector(
                                onTap: () {
                                  // Navigate back to the sign-in screen
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Remember your password? Sign in',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryBlue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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