import 'package:firebase_auth/firebase_auth.dart'; // For Firebase Auth
import 'package:flutter/material.dart';
// Constants
import 'package:get/get.dart';
import 'package:glamify/widgets/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailControl = TextEditingController();
  bool _isSendingOtp = false; // Track if OTP is being sent

  // Function to send password reset email
  Future<void> _sendOtp() async {
    // Check if the email field is not empty
    if (emailControl.text.isEmpty) {
      _showSnackBar('Please enter your email address', Colors.orange);
      return;
    }

    setState(() {
      _isSendingOtp = true; // Disable button while sending OTP
    });

    try {
      // Send password reset email directly
      await _auth.sendPasswordResetEmail(email: emailControl.text);

      // Show success message
      _showSnackBar('Password reset email sent! Please check your inbox.', Colors.green);

      // Navigate to OTP verification page (optional if you have another step after email)
      Get.back();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => EmailVerify(email: emailControl.text)),
      // );
    } catch (e) {
      // Improved error logging
      print("Error during password reset process: $e");
      _showSnackBar('Error: $e', Colors.red);
    } finally {
      setState(() {
        _isSendingOtp = false; // Re-enable the button after sending OTP
      });
    }
  }

  // Helper function to show snack bars
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant().whiteC,
      body: Padding(
        padding: const EdgeInsets.only(top: 55, left: 17, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Forgot password,",
              style: GoogleFonts.manrope(
                color: Constant().primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Please type your email below and we will send you a password reset link.",
              style: GoogleFonts.manrope(
                color: Constant().primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 140),
            TextField(
              controller: emailControl,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIconColor: Constant().primaryColor,
                hintText: "Email Address",
                hintStyle: TextStyle(color: Constant().primaryColor),
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isSendingOtp ? null : _sendOtp, // Disable button during OTP sending
              style: ElevatedButton.styleFrom(
                backgroundColor: Constant().primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                _isSendingOtp ? 'Sending Reset Link...' : 'Send Reset Link',
                style: GoogleFonts.manrope(
                  color: Colors.white,
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
