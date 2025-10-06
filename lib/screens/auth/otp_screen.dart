import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  // Define a TextEditingController for each OTP digit
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Define the primary blue color from the UI statically
  static const primaryBlue = Color.fromARGB(255, 20, 40, 95);

  @override
  void dispose() {
    _fieldOne.dispose();
    _fieldTwo.dispose();
    _fieldThree.dispose();
    _fieldFour.dispose();
    super.dispose();
  }

  // Helper method to get the combined OTP string
  String get _combinedOtp =>
      _fieldOne.text + _fieldTwo.text + _fieldThree.text + _fieldFour.text;

  // --- Pop-up Dialog ---
  void _showVerificationSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.lock_open_rounded, color: Colors.green, size: 28),
              SizedBox(width: 10),
              Text('OTP Verified', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          content: const Text(
            'The code has been verified. You can now reset your password.',
            style: TextStyle(fontSize: 14),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Navigate to the password reset screen
                Navigator.pushNamed(context, '/restPass');
              },
              child: const Text('CONTINUE', style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  // --- Verification Handler ---
  void _verifyOtp(BuildContext context) {
    // Basic validation: Check if all 4 characters are entered
    if (_combinedOtp.length == 4) {
      // In a real application, you would send this OTP to an API for verification.
      // For this implementation, we treat a full 4-digit entry as success.

      // Example of the OTP you collected: print(_combinedOtp);

      // Show success popup
      _showVerificationSuccessDialog(context);
    } else {
      // Show an error message (snackbar is commonly used for this)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter the complete 4-digit OTP.'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // Define a custom widget for the OTP input fields
  Widget _otpInputField({
    required TextEditingController controller,
    required bool autoFocus,
    required bool isLast, // New parameter to handle the submit action on the last field
  }) {
    return SizedBox(
      height: 60,
      width: 50,
      // Using TextFormField for future validation capabilities if needed
      child: TextFormField(
        autofocus: autoFocus,
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        // Trigger verification if the last field is filled
        onFieldSubmitted: (value) {
          if (isLast && value.isNotEmpty) {
            _verifyOtp(context);
          }
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (!isLast) {
              FocusScope.of(context).nextFocus();
            } else {
              // If last field is filled, hide keyboard and attempt verification
              FocusManager.instance.primaryFocus?.unfocus();
              _verifyOtp(context);
            }
          } else if (value.isEmpty) {
            // Move backward on deletion
            FocusScope.of(context).previousFocus();
          }
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          // Set a thin gray border for the enabled state
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey[400]!,
              width: 1.5,
            ),
          ),
          // Set a thicker blue border for the focused state
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: primaryBlue,
              width: 2.0,
            ),
          ),
          counterText: '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Resetting the color definition here for correctness within the build method
    // (though already defined as static const in the state class)
    // const primaryBlue = Color.fromARGB(255, 20, 40, 95);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // Set to true to allow scrolling if keyboard appears
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
                    // Added SingleChildScrollView for better keyboard handling
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
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
                              const Text(
                                'Verify OTP',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Enter the 4-digit code sent to your email.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 32),
                              // OTP Input Fields
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _otpInputField(
                                    controller: _fieldOne,
                                    autoFocus: true,
                                    isLast: false,
                                  ),
                                  _otpInputField(
                                    controller: _fieldTwo,
                                    autoFocus: false,
                                    isLast: false,
                                  ),
                                  _otpInputField(
                                    controller: _fieldThree,
                                    autoFocus: false,
                                    isLast: false,
                                  ),
                                  _otpInputField(
                                    controller: _fieldFour,
                                    autoFocus: false,
                                    isLast: true, // Mark the last field
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Resend Button
                              GestureDetector(
                                onTap: () {
                                  // Handle "Resend" logic
                                  // For a complete flow, this would trigger a new OTP request
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Resending OTP...'),
                                      backgroundColor: primaryBlue,
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Didn't receive code? Resend",
                                  style: TextStyle(
                                    color: primaryBlue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                              // Verify Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () => _verifyOtp(context), // Call the verification handler
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryBlue,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                  ),
                                  child: const Text(
                                    'Verify',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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