
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamify/views/onBording_start.dart';
import 'package:glamify/widgets/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBordingwhat extends StatefulWidget {
  const OnBordingwhat({super.key});

  @override
  _OnBordingwhatState createState() => _OnBordingwhatState();
}

class _OnBordingwhatState extends State<OnBordingwhat> {
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
            image: AssetImage("assets/images/onW.png"),
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
                    "Want Our Services As!",
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
                          //  AuthMethodR().registerWithGoogle(context);
                          Get.to(const OnBordingStart());

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
                    // Image.asset(
                    //   'assets/images/g.png',
                    //   width: 30,
                    // ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text('Customer',
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
                  Get.to(const OnBordingStart());
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
                    // Icon(
                    //   Icons.email,
                    //   color: constant.whiteC,
                    //   size: 30,
                    // ),
                    const SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: (){
                        // Get.to(SignupAuth());
                      },
                      child: Text('Beautician',
                          style: GoogleFonts.manrope(
                              color: constant.whiteC,
                              fontSize: 16,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40.0),

            
          
            ],
          ),
        ),
      ),
    );
  }
}
