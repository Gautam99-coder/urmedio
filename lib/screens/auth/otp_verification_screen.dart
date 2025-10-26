import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async'; // For Timer

// Define the purpose of this OTP screen
enum VerificationPurpose { signUp, passwordReset }

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  final String? name; // Added for sign-up flow
  final String? photoUrl; // Added for sign-up flow
  final VerificationPurpose purpose; // To decide the post-verification action

  const OtpVerificationScreen({
    super.key,
    required this.email,
    this.name,
    this.photoUrl,
    // Default to passwordReset if not specified, based on your original dialog
    this.purpose = VerificationPurpose.passwordReset, 
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  static const primaryBlue = Color.fromARGB(255, 22, 50, 98); // Changed to your original primary color

  Timer? _timer;
  int _start = 60;
  bool _canResend = false;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    // 💡 Call the initial "Send OTP" function here, since initState is only called once.
    _sendInitialOtp();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _fieldOne.dispose();
    _fieldTwo.dispose();
    _fieldThree.dispose();
    _fieldFour.dispose();
    super.dispose();
  }
  
  // --- Core Methods: Timer & OTP Actions ---

  void startTimer() {
    _timer?.cancel();
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
  
  // 💡 Placeholder for initial OTP sending logic
  void _sendInitialOtp() {
    // 🚨 Backend Integration Point 1: Send the first OTP email
    // This function will call your Firebase Cloud Function or custom backend service
    // to send an OTP to widget.email.
    print("Initial OTP sent to: ${widget.email}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Verification code sent to ${widget.email}'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _resendOtpAction() {
    if (!_canResend) return;

    // 🚨 Backend Integration Point 2: Resend OTP
    // Call the same function as above to resend the OTP.
    _sendInitialOtp();
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('OTP resent successfully.'),
        duration: Duration(seconds: 2),
      ),
    );
    // Restart the timer
    startTimer();
  }

  String get _combinedOtp =>
      _fieldOne.text + _fieldTwo.text + _fieldThree.text + _fieldFour.text;

  // --- Success Dialog ---
  void _showVerificationSuccessDialog() {
    String title;
    String message;
    String nextRoute;
    
    if (widget.purpose == VerificationPurpose.passwordReset) {
      title = 'OTP Verified';
      message = 'The code has been verified. You can now reset your password.';
      nextRoute = '/restPass';
    } else {
      // VerificationPurpose.signUp (Google Sign-Up Flow)
      title = 'Account Verified!';
      message = 'Your account has been verified. Welcome to the app!';
      nextRoute = '/homePage'; // Navigate to the main application screen
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(widget.purpose == VerificationPurpose.passwordReset ? Icons.lock_open_rounded : Icons.check_circle_outline, 
                color: Colors.green, size: 28),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        content: Text(message, style: const TextStyle(fontSize: 14)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Replace the current screen with the next route
              Navigator.pushReplacementNamed(context, nextRoute);
            },
            child: const Text('CONTINUE', style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // --- Verify OTP Logic ---
  Future<void> _verifyOtp() async {
    if (_combinedOtp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the full 4-digit code.'), backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() {
      _isVerifying = true;
    });

    try {
      // 🚨 Backend Integration Point 3: Verify OTP
      // Call your backend/Cloud Function to check if _combinedOtp matches the expected code for widget.email
      await Future.delayed(const Duration(milliseconds: 2000)); // Simulate network

      // Assume success for now. Replace with actual API call result check.
      bool isSuccessful = true; // REPLACE with: actualVerificationResult.isSuccess 

      if (isSuccessful) {
        if (widget.purpose == VerificationPurpose.signUp) {
          // 🚨 Backend Integration Point 4: Finalize Google Sign-Up
          // After OTP success, finalize the user account creation in Firestore 
          // (e.g., set 'isVerified: true' and save name/photoUrl from the constructor).
          // Then, sign the user into Firebase Auth permanently.
          
          // For now, we'll skip this complex backend step and just show success.
          print('Sign-Up Finalization Required: ${widget.email}, ${widget.name}');
        }
        
        _showVerificationSuccessDialog();
      } else {
        throw Exception('OTP verification failed.'); // Throw error for catch block
      }
      
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid OTP or verification failed. Please check the code.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      // Clear all fields on failure to re-enter
      _fieldOne.clear();
      _fieldTwo.clear();
      _fieldThree.clear();
      _fieldFour.clear();
      FocusScope.of(context).requestFocus(FocusNode()); // Unfocus all
      
    } finally {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });
      }
    }
  }

  // --- UI Builder Methods (Mostly Unchanged) ---

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
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }

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


  @override
  Widget build(BuildContext context) {
    // Determine the email and user greeting dynamically
    final String displayEmail = widget.email;
    final String greeting = widget.purpose == VerificationPurpose.signUp && widget.name != null && widget.name!.isNotEmpty 
        ? 'Hello ${widget.name}!' 
        : 'Verify OTP';

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
                              Text(greeting, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Text(
                                'Enter the 4-digit code sent to $displayEmail.',
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