import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:glamify/views/splash_view.dart';
import 'package:glamify/widgets/constant.dart';
import 'package:google_fonts/google_fonts.dart';
void main() async{

 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
    Gemini.init(apiKey: "AIzaSyDf3GSMQjwCJuRNItySQM7DZ8Igk3F_vcs");
    //  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp()); 
}
class MyApp extends StatelessWidget {
  final Constant constant = Constant();

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( 
      debugShowCheckedModeBanner: false, 
      title: 'Beautilly',
      theme: ThemeData(
        fontFamily: GoogleFonts.cabin().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: constant.whiteC),
        useMaterial3: true,
      ),
      home: const SplashView(),
    );
  }
}











