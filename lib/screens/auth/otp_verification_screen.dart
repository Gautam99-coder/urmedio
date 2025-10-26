import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async'; // For Timer

class OtpVerificationScreen extends StatefulWidget {
  // Option to receive email argument from previous screen
  final String? email;
  // Added required key for consistency, though it's optional
  const OtpVerificationScreen({super.key, this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  static const primaryBlue = Color.fromARGB(255, 20, 40, 95);

  // --- Timer State FIX ---
  // Changed from late Timer to nullable Timer? to fix LateInitializationError
  Timer? _timer;
  int _start = 60;
  bool _canResend = false;
  bool _isVerifying = false;
  // --- End Timer State FIX ---

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    // ⚠️ CRITICAL FIX: Safely cancel the timer and dispose controllers
    _timer?.cancel();
    _fieldOne.dispose();
    _fieldTwo.dispose();
    _fieldThree.dispose();
    _fieldFour.dispose();
    super.dispose();
  }

  void startTimer() {
    // Cancel any existing timer safely
    _timer?.cancel();

    const oneSec = Duration(seconds: 1);
    _canResend = false;
    _start = 60;

    // Assign the new timer instance
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        // Stop timer if the widget is not mounted (prevents another error)
        if (!mounted) {
          timer.cancel();
          return;
        }
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _canResend = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  String get _combinedOtp =>
      _fieldOne.text + _fieldTwo.text + _fieldThree.text + _fieldFour.text;

  void _resendOtpAction() {
    // 🚨 FIRBASE RESEND LOGIC HERE:
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Resending OTP...'),
        duration: Duration(seconds: 1),
      ),
    );
    // Restart the timer
    startTimer();
  }

  void _showVerificationSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
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
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/restPass');
            },
            child: const Text('CONTINUE', style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Future<void> _verifyOtp() async {
    if (_combinedOtp.length != 4) {
      // Allow verification only if all fields are filled
      return;
    }

    setState(() {
      _isVerifying = true;
    });

    try {
      // 🚨 FIRBASE VERIFICATION LOGIC HERE:
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 1500));

      // If verification successful:
      _showVerificationSuccessDialog();

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid OTP. Please try again.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });
      }
    }
  }

  // Custom OTP input field
  Widget _otpInputField({
    required TextEditingController controller,
    required bool autoFocus,
    required bool isLast,
  }) {
    return SizedBox(
      width: 50,
      child: TextFormField(
        controller: controller,
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryBlue, width: 2),
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (!isLast) {
              FocusScope.of(context).nextFocus();
            } else {
              FocusManager.instance.primaryFocus?.unfocus();
              // Automatically try to verify when the last field is filled
              _verifyOtp();
            }
          } else if (value.isEmpty && !autoFocus) {
            // Move to previous field only if not the first field
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }

  // Timer Widget logic integrated directly
  Widget _buildResendTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Didn't receive code? ",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        _canResend
            ? GestureDetector(
          onTap: _resendOtpAction,
          child: const Text(
            'Resend',
            style: TextStyle(
              color: primaryBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
            : Text(
          // Use padLeft to format the remaining seconds (e.g., 09)
          'Resend in 00:${_start.toString().padLeft(2, '0')}',
          style: TextStyle(
            color: primaryBlue.withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    // Get email passed from ForgotPasswordScreen route arguments
    String? emailFromRoute = ModalRoute.of(context)?.settings.arguments as String?;

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background (ensure this asset path is correct)
          Positioned.fill(
            child: Image.asset('assets/images/bg1.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 120),
                              const Text('Verify OTP', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Text(
                                'Enter the 4-digit code sent to ${emailFromRoute ?? 'your email'}.',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                              const SizedBox(height: 32),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _otpInputField(controller: _fieldOne, autoFocus: true, isLast: false),
                                  _otpInputField(controller: _fieldTwo, autoFocus: false, isLast: false),
                                  _otpInputField(controller: _fieldThree, autoFocus: false, isLast: false),
                                  _otpInputField(controller: _fieldFour, autoFocus: false, isLast: true),
                                ],
                              ),
                              const SizedBox(height: 16),
                              _buildResendTimer(),
                              const SizedBox(height: 32),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  // Call _verifyOtp explicitly when button is pressed
                                  onPressed: _isVerifying ? null : () => _verifyOtp(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryBlue,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                  ),
                                  child: _isVerifying
                                      ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    ),
                                  )
                                      : const Text('Verify', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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