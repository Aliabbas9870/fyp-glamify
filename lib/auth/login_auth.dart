import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamify/auth/forget_pass.dart';
import 'package:glamify/auth/signup_auth.dart';
import 'package:glamify/service_db/database.dart';
import 'package:glamify/widgets/bottomBar.dart';
import 'package:glamify/widgets/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginAuth extends StatefulWidget {
  const LoginAuth({super.key});

  @override
  State<LoginAuth> createState() => _LoginAuthState();
}

class _LoginAuthState extends State<LoginAuth> {
  final Constant constant = Constant();
  var emailControl = TextEditingController();
  var passControl = TextEditingController();
  String email = '', password = '';
userLogin() async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    Get.to(const BottomBarStart());
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: constant.primaryColor,
          content: const Text(
            "User Not Found",
            style: TextStyle(
              fontSize: 18,
            ),
          )));
    } else if (e.code == "wrong-password") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: constant.primaryColor,
          content: const Text(
            "Wrong Password!",
            style: TextStyle(
              fontSize: 18,
            ),
          )));
    } else if (e.code == "invalid-email") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: constant.primaryColor,
          content: const Text(
            "Invalid Email Format!",
            style: TextStyle(
              fontSize: 18,
            ),
          )));
    } 
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: constant.primaryColor,
          content: const Text(
            "Please all enter the email and password!",
            style: TextStyle(
              fontSize: 18,
            ),
          )));
    }
  }
}

  bool obscurePass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constant.whiteC,
      body: Container(
        padding: const EdgeInsets.only(top: 55, left: 17, right: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Welcome back!",
                style: GoogleFonts.manrope(
                  color: constant.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Glad to meet you again!, please login to use the app.",
                style: GoogleFonts.manrope(
                  color: constant.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              // text field //
              const SizedBox(
                height: 140,
              ),

              Container(
                child: Column(
                  children: [
                    TextField(
                      controller: emailControl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          prefixIconColor: constant.primaryColor,
                          hintText: "Email Address",
                          hintStyle: TextStyle(color: constant.primaryColor),
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: passControl,
                      obscureText: obscurePass,
                      decoration: InputDecoration(
                          prefixIconColor: constant.primaryColor,
                          hintText: "Password",
                          hintStyle: TextStyle(color: constant.primaryColor),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIconColor: constant.primaryColor,
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscurePass = !obscurePass;
                                });
                              },
                              icon: obscurePass
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const ForgetPassword()));
                        // ForgetPassword
                      },
                      child: Text(
                        "Forgot password?",
                        style: GoogleFonts.manrope(
                          color: constant.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      )),
                ],
              ),
              // end text field
              const SizedBox(
                height: 40,
              ),

              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (emailControl.text != "" && passControl.text != "") {
                          setState(() {
                            email = emailControl.text;
                            password = passControl.text;
                          });
                        }
                        userLogin();
                      },
                      child: Container(
                        width: 348,
                        height: 55,
                        decoration: BoxDecoration(
                            color: constant.primaryColor,
                            border: Border.all(color: constant.primaryColor),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text("Sign in",
                              style: GoogleFonts.manrope(
                                  color: constant.whiteC,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 42,
                    ),

                    SizedBox(
                      width: 348,
                      child: Row(
                        children: [
                          const Expanded(
                              child: Divider(
                            thickness: 1.5,
                          )),
                          const SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text("Or",
                                style: GoogleFonts.manrope(
                                    color: constant.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Expanded(
                              child: Divider(
                            thickness: 1.5,
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    // Google Sign In Button
                    InkWell(
                      onTap: () {
                        AuthMethod().singInWithGoogle(context);
                      },
                      child: Container(
                        height: 55,
                        width: 348,
                        decoration: BoxDecoration(
                            border: Border.all(color: constant.primaryColor),
                            borderRadius: BorderRadius.circular(12)),
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
                            Text('Sign in with Google',
                                style: GoogleFonts.manrope(
                                    color: constant.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    )
                
                  ],
                ),
              ),

              const SizedBox(
                height: 32,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an account?",
                        style: GoogleFonts.manrope(
                          color: constant.primaryColor,
                          fontSize: 16,
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (c) => const SignupAuth()));
                        },
                        child: Text("Join Now",
                            style: GoogleFonts.manrope(
                                color: constant.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
