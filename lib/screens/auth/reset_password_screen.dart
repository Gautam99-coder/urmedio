import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  // Key for form validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // State variables for password visibility
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Define the primary blue color from the UI statically
  static const primaryBlue = Color.fromARGB(255, 20, 40, 95);

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // --- Validation Logic ---

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters.';
    }
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your new password.';
    }
    if (value != _newPasswordController.text) {
      return 'Passwords do not match.';
    }
    return null;
  }

  // --- Pop-up Dialog ---

  void _showResetSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              SizedBox(width: 10),
              Text('Success', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          content: const Text(
            'Your password has been successfully reset. Please sign in with your new password.',
            style: TextStyle(fontSize: 14),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Pop the dialog
                Navigator.of(context).pop();
                // Navigate to the sign-in screen
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/signin',
                  (Route<dynamic> route) => false, // Remove all previous routes
                );
              },
              child: const Text('OK', style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  // --- Reset Handler ---

  void _resetPassword() {
    // Validate the form fields
    if (_formKey.currentState!.validate()) {
      // If validation passes, implement the reset logic (API call, etc.)
      // Since this is a UI implementation, we proceed to the success state.

      // Show success popup
      _showResetSuccessDialog(context);
    }
  }

  // Helper widget modified to use TextFormField and include validation logic
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool isVisible,
    required VoidCallback toggleVisibility,
    required FormFieldValidator<String> validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: !isVisible,
        validator: validator, // Added validator
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          errorStyle: const TextStyle(height: 0.8), // Compact error message
          fillColor: Colors.grey[100],
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder( // Retain UI style on focus
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryBlue, width: 2),
          ),
          errorBorder: OutlineInputBorder( // Show error border
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: toggleVisibility,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // Allow resize for keyboard
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView( // Added SingleChildScrollView to prevent overflow
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter your new password below.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),
                _buildPasswordField(
                  controller: _newPasswordController,
                  hintText: 'New Password',
                  isVisible: _isNewPasswordVisible,
                  toggleVisibility: () {
                    setState(() {
                      _isNewPasswordVisible = !_isNewPasswordVisible;
                    });
                  },
                  validator: _passwordValidator, // Applied new password validator
                ),
                _buildPasswordField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm New Password',
                  isVisible: _isConfirmPasswordVisible,
                  toggleVisibility: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                  validator: _confirmPasswordValidator, // Applied confirm password validator
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _resetPassword, // Call the new reset handler
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Reset Password',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // Note: The rest of your original layout (Spacer and Back to Sign In)
                // is now handled implicitly by the SingleChildScrollView and the fixed bottom text.
                const SizedBox(height: 100), // Push the link down slightly
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: GestureDetector(
                      onTap: () {
                        // Navigate back to Sign In screen
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Back to Sign In',
                        style: TextStyle(
                          color: primaryBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}