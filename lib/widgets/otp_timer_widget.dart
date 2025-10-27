import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async'; // For Timer

class OtpVerificationScreen extends StatefulWidget {
  // Option to receive email argument from previous screen
  final String? email;
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

  // --- Timer State ---
  late Timer _timer;
  int _start = 60;
  bool _canResend = false;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _fieldOne.dispose();
    _fieldTwo.dispose();
    _fieldThree.dispose();
    _fieldFour.dispose();
    super.dispose();
  }

  void startTimer() {
    _timer.cancel(); // Cancel any existing timer
    const oneSec = Duration(seconds: 1);
    _canResend = false;
    _start = 60;
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
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
  // --- End Timer State ---

  String get _combinedOtp =>
      _fieldOne.text + _fieldTwo.text + _fieldThree.text + _fieldFour.text;

  void _resendOtpAction() {
    // 🚨 FIRBASE RESEND LOGIC HERE:
    // await FirebaseAuth.instance.sendPasswordResetEmail(email: widget.email!);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Resending OTP...'),
        duration: Duration(seconds: 1),
      ),
    );
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the complete 4-digit OTP.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _isVerifying = true;
    });

    try {
      // 🚨 FIRBASE VERIFICATION LOGIC HERE:
      // This step typically involves confirming the OTP with your backend.
      // E.g., verifying a code sent via SMS/Email using Firebase SDKs.
      await Future.delayed(const Duration(milliseconds: 1500)); // Simulated API call

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
      setState(() {
        _isVerifying = false;
      });
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
          } else {
            if (!autoFocus) {
              FocusScope.of(context).previousFocus();
            }
          }
        },
      ),
    );
  }

  // --- Timer Widget implementation within the build method for simplicity ---
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
          'Resend in 00:${_start.toString().padLeft(2, '0')}',
          style: TextStyle(
            color: primaryBlue.withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
  // --- End Timer Widget ---


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
                                  onPressed: _isVerifying ? null : _verifyOtp,
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