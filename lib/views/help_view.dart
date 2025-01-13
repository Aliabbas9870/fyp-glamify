import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:flutter/material.dart';
import 'package:glamify/widgets/constant.dart';


class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  final Constant constant = Constant();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // Get the userId from FirebaseAuth
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? ''; 

  Future<void> addHelp(String userId, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection("Helps")
        .doc(userId) // Using userId as the document ID
        .set(userInfoMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constant.whiteC,
        title: Text(
          "Help",
          style: TextStyle(
              color: constant.primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Column(
            children: [
              const SizedBox(height: 40),
              Image.asset("assets/images/QMrk.png"),
              const SizedBox(height: 20),
              const Text(
                "How we can help you today?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please enter your personal data and describe your care needs or something we can help you with",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Name",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Enter the Name",
                  prefixIcon: Icon(Icons.person, color: constant.primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter the Email",
                  prefixIcon: Icon(Icons.email, color: constant.primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Describe",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              TextField(
                controller: descriptionController,
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Describe your needs",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  String name = nameController.text.trim();
                  String email = emailController.text.trim();
                  String description = descriptionController.text.trim();

                  if (name.isNotEmpty && email.isNotEmpty && description.isNotEmpty) {
                    // Create the user information map with the required fields
                    Map<String, dynamic> userInfoMap = {
                      'name': name,
                      'email': email,
                      'description': description,
                      'timestamp': DateTime.now(),
                    };

                    // Add help request with the user ID as the document ID
                    await addHelp(userId, userInfoMap);
                    nameController.clear();
                    emailController.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      
                      SnackBar(
                        backgroundColor: constant.primaryColor,
                        content: Text("Help Form submitted successfully",style:TextStyle(color: constant.whiteC))),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill in all fields")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: constant.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
