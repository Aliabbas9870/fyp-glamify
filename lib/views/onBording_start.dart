
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamify/auth/login_auth.dart';
import 'package:glamify/auth/signup_auth.dart';
import 'package:glamify/widgets/constant.dart';
import 'package:google_fonts/google_fonts.dart';

import '../service_db/database.dart';

class OnBordingStart extends StatefulWidget {
  const OnBordingStart({super.key});

  @override
  _OnBordingStartState createState() => _OnBordingStartState();
}

class _OnBordingStartState extends State<OnBordingStart> {
  final Constant constant = Constant();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87.withOpacity(.4),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Onjoin.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black87.withOpacity(0.4),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 132,
              ),
              // Two Headings about Beauty
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 90,
                  ),
                  const Text(
                    "Beauty Redefined",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "Discover a new level of beauty with our products.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70.0),

            
              ElevatedButton(
                onPressed: () {
                           AuthMethodR().registerWithGoogle(context);

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: constant.whiteC,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/g.png',
                      width: 30,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text('Google',
                        style: GoogleFonts.manrope(
                            color: constant.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),

              // Email Sign In Button
              ElevatedButton(
                onPressed: () {
                  Get.to(const SignupAuth());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: constant.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.email,
                      color: constant.whiteC,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: (){
                        Get.to(const SignupAuth());
                      },
                      child: Text('Email',
                          style: GoogleFonts.manrope(
                              color: constant.whiteC,
                              fontSize: 16,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40.0),

              // Already have an account? Sign in
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
                        style: GoogleFonts.manrope(
                          color: constant.whiteC,
                          fontSize: 16,
                        )),
                    TextButton(
                      onPressed: () {
                       Get.to(const LoginAuth());
     
                      },
                      child: Text(
                        "Sign in",
                        style: GoogleFonts.manrope(
                          color: constant.secondColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
