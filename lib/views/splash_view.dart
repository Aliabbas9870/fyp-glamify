
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glamify/views/onBording.dart';
import 'package:glamify/widgets/bottomBar.dart';
import 'package:glamify/widgets/constant.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});



  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final Constant constant = Constant();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (c) => AuthChecker())));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: constant.primaryColor,
      body: 


            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Center(
                child: Image.asset("assets/images/Logo/logo.png")),
            ),

      
    
    
    );
  }
}



class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
         return const CircularProgressIndicator();
        }

        if (snapshot.hasData) {
          // User is signed in
          return const BottomBarStart();
        } else {
          // User is signed out
          return OnBording();
        }
      },
    );
  }
}

