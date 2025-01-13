import 'dart:async'; // For Timer

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glamify/widgets/constant.dart';
// import 'package:fypapp/widgets/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailVerify extends StatefulWidget {
  final String email;
  const EmailVerify({super.key, required this.email});

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  final Constant constant = Constant();
  var otpControl = TextEditingController();
  int _timerSeconds = 60; // 1 minute countdown
  bool _isResendEnabled = false; // Control whether Resend button is enabled
  late Timer _timer; // Timer instance

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the countdown timer
  }

  // Start the countdown timer
  void _startTimer() {
    _isResendEnabled = false; // Disable resend button initially
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        setState(() {
          _isResendEnabled = true; // Enable resend button when time is up
        });
        _timer.cancel(); // Stop the timer
      }
    });
  }

  // Resend OTP function (for simulation)
  void _resendOtp() {
    setState(() {
      _timerSeconds = 60; // Reset the timer to 60 seconds
      _startTimer(); // Restart the timer
    });
    // Add functionality here to resend the OTP via email or other services
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('OTP has been resent to ${widget.email}.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _verifyOtp() async {
    String otp = otpControl.text.trim();

    if (otp.isNotEmpty) {
      try {
        // Call Firebase's OTP verification (this is just a simulation for demonstration)
        // Typically, Firebase would send OTP through SMS or email, here it's simplified
        User? user = FirebaseAuth.instance.currentUser;
        
        if (user != null) {
          // Proceed with the OTP verification and logging in the user
          await user.reload();
          if (user.emailVerified) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Email Verified! Proceeding to login...'),
                backgroundColor: Colors.green,
              ),
            );
            // Navigate to login screen (replace with actual login page)
            Navigator.pushReplacementNamed(context, '/login');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('OTP verification failed. Please try again.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter OTP'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constant.whiteC,
      body: Container(
        padding: const EdgeInsets.only(top: 55, left: 17, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Email verification,",
              style: GoogleFonts.manrope(
                color: constant.primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Please type the OTP code sent to ${widget.email}",
              style: GoogleFonts.manrope(
                color: constant.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 140),
            TextField(
              controller: otpControl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter OTP",
                hintStyle: TextStyle(color: constant.primaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: constant.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: _verifyOtp,
                child: Text(
                  'Verify OTP',
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (!_isResendEnabled) // Display countdown timer
              Text(
                'Resend OTP in: ${_timerSeconds}s',
                style: GoogleFonts.manrope(
                  color: constant.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            if (_isResendEnabled) // Display Resend OTP button
              TextButton(
                onPressed: _resendOtp,
                child: Text(
                  'Resend OTP',
                  style: GoogleFonts.manrope(
                    color: constant.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
