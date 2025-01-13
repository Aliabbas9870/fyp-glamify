import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamify/auth/login_auth.dart';
import 'package:glamify/service_db/database.dart';
import 'package:glamify/widgets/bottomBar.dart';
import 'package:glamify/widgets/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupAuth extends StatefulWidget {
  const SignupAuth({super.key});

  @override
  State<SignupAuth> createState() => _SignupAuthState();
}

class _SignupAuthState extends State<SignupAuth> {
  final Constant constant = Constant();
  String name = '', email = '', phone = '', password = '';
  var nameControl = TextEditingController();
  var phoneControl = TextEditingController();
  var emailControl = TextEditingController();
  var passControl = TextEditingController();

register() async {
    if (name != "" && phone != "" && email != "" && password != "") {
     


if (phone.length < 9 || phone.length > 14) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: constant.primaryColor,
      content: const Text(
        "Invalid phone number format!",
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    ),
  );
  return;
}

      
     if (!email.contains('@') || !email.contains('.') || email.length < 5) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: constant.primaryColor,
      content: const Text(
        "Invalid email format!",
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    ),
  );
  return;
}


      // Validate password strength
      if (password.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: constant.primaryColor,
            content: const Text(
              "Password should be at least 6 characters long!",
              style: TextStyle(
                fontSize: 18,
              ),
            )));
        return;
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        // Add user data to Firestore
        await FirebaseFirestore.instance
            .collection('User')
            .doc(userCredential.user!.uid)
            .set({
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'uid': userCredential.user!.uid,
          'createdAt': FieldValue.serverTimestamp(),
          'blockUser': false, 
          'userImage': userCredential.user?.photoURL ??
              "",
          'userLocation': "",
        });

        Navigator.of(context).pop(); 
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: constant.primaryColor,
            content: const Text(
              "Register Successfully!",
              style: TextStyle(fontSize: 18),
            )));
        Get.to(const BottomBarStart());
      } on FirebaseAuthException catch (e) {
        Navigator.of(context).pop();
        if (e.code == "weak-password") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: constant.primaryColor,
              content: const Text(
                "Password is weak!",
                style: TextStyle(
                  fontSize: 18,
                ),
              )));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: constant.primaryColor,
              content: const Text(
                "Account Already Exist!",
                style: TextStyle(
                  fontSize: 18,
                ),
              )));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: constant.primaryColor,
          content: const Text(
            "Please fill in all fields!",
            style: TextStyle(
              fontSize: 18,
            ),
          )));
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
                "Create an account,",
                style: GoogleFonts.manrope(
                  color: constant.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please type full information bellow and we can create your account",
                style: GoogleFonts.manrope(
                  color: constant.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              // text field //
              const SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  children: [
                    TextField(
                      controller: nameControl,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          prefixIconColor: constant.primaryColor,
                          prefixIcon: const Icon(Icons.person),
                          hintText: "Name",
                          hintStyle: TextStyle(color: constant.primaryColor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: phoneControl,
                      decoration: InputDecoration(
                          prefixIconColor: constant.primaryColor,
                          prefixIcon: const Icon(Icons.phone),
                          hintText: "Mobile Number",
                          hintStyle: TextStyle(color: constant.primaryColor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailControl,
                      decoration: InputDecoration(
                          hintText: "Email Address",
                          hintStyle: TextStyle(color: constant.primaryColor),
                          prefixIconColor: constant.primaryColor,
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

              // end text field
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: RichText(
                    text: TextSpan(
                        text: "By signing up you agree our ",
                        style: GoogleFonts.manrope(
                            color: constant.primaryColor, fontSize: 12),
                        children: [
                      TextSpan(
                        text: "Term of use and privacy ",
                        style: GoogleFonts.manrope(
                            color: constant.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "notice",
                        style: GoogleFonts.manrope(
                            color: constant.primaryColor, fontSize: 12),
                      ),
                    ])),
              ),

              const SizedBox(
                height: 40,
              ),

              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (nameControl.text != "" &&
                            phoneControl.text != "" &&
                            emailControl.text != "" &&
                            passControl.text != "") {
                          setState(() {
                            name = nameControl.text;
                            email = emailControl.text;
                            phone = phoneControl.text;
                            password = passControl.text;
                          });
                        }
                        register();
                      },
                      child: Container(
                        width: 348,
                        height: 55,
                        decoration: BoxDecoration(
                            color: constant.primaryColor,
                            border: Border.all(color: constant.primaryColor),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text("Join Now",
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
                        AuthMethodR().registerWithGoogle(context);
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
                            Text('Join with Google',
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
                    Text("Already have an account?",
                        style: GoogleFonts.manrope(
                          color: constant.primaryColor,
                          fontSize: 16,
                        )),
                    TextButton(
                        onPressed: () {
                          Get.to(const LoginAuth());
                        },
                        child: Text("Sign In",
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
