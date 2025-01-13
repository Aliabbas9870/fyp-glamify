import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:glamify/service_db/database.dart';
import 'package:glamify/widgets/constant.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}


class _AccountViewState extends State<AccountView> {
  final Constant constant = Constant();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController locatController = TextEditingController();

  bool obscurePass = true;
  String userId = FirebaseAuth.instance.currentUser?.uid ?? 'guestUser'; // Dynamic user ID
  final DataBaseMethod dbMethod = DataBaseMethod();
  String imageUrl = ""; // For storing the image URL
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  User? user;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _loadUserData();
    }
  }

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  // Function to load user data from Firestore
  Future<void> _loadUserData() async {
    Map<String, dynamic>? data = await dbMethod.fetchUserData(user!.uid);
    setState(() {
      userData = data;
      imageUrl = data?['imageUrl'] ?? ''; // Fetch the saved image URL
      nameController.text = data?['name'] ?? ''; // Fetch and pre-fill name
      emailController.text = data?['email'] ?? ''; // Fetch and pre-fill email
      phoneController.text = data?['phone'] ?? ''; // Fetch and pre-fill phone
      locatController.text = data?['userLocation'] ?? ''; // Fetch and pre-fill location
    });
  }

  // Function to upload image to Firebase Storage and get the URL
  Future<String> _uploadImage(XFile imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance.ref().child('userImage').child(fileName);
      await storageRef.putFile(File(imageFile.path));
      String downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  // Method to update an existing user in Firestore
  Future<void> updateUser(String userId, Map<String, dynamic> userInfoMap) async {
    try {
      await FirebaseFirestore.instance.collection("User").doc(userId).update(userInfoMap);
    } catch (e) {
      throw Exception("Error updating user: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constant.whiteC,
        title: Text(
          "Account",
          style: TextStyle(
              color: constant.primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Container(
            color: constant.whiteC,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              children: [
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: _pickImage,  // Allow user to change image when tapped
                  child: CircleAvatar(
                    radius: 44,
                    backgroundImage: _imageFile != null
                        ? FileImage(File(_imageFile!.path))
                        : (imageUrl.isNotEmpty
                            ? NetworkImage(imageUrl)  // Display saved image
                            : null),  // Remove AssetImage and set to null if no image
                    child: _imageFile == null && imageUrl.isEmpty
                        ? const Icon(Icons.person, size: 44, color: Colors.grey) // Default icon when no image
                        : null,  // No icon if there's an image
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  userData?['name'] ?? user?.displayName ?? "User Name", // Display current user name
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 26),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Name"),
                      TextField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "Enter the Name",
                          prefixIcon: const Icon(Icons.person),
                          suffixIconColor: constant.primaryColor,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("Phone Number"),
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "Enter the phone",
                          prefixIcon: const Icon(Icons.phone),
                          suffixIconColor: constant.primaryColor,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("Location"),
                      TextField(
                        controller: locatController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Enter the Location",
                          prefixIcon: const Icon(Icons.location_city),
                          suffixIconColor: constant.primaryColor,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("Email"),
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Enter the Email",
                          prefixIcon: const Icon(Icons.email_rounded),
                          suffixIconColor: constant.primaryColor,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("Password"),
                      TextField(
                        controller: passController,
                        obscureText: obscurePass,
                        decoration: InputDecoration(
                          hintText: "Enter the password",
                          prefixIcon: const Icon(Icons.key_sharp),
                          suffixIconColor: constant.primaryColor,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscurePass = !obscurePass;
                              });
                            },
                            icon: obscurePass
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 52),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              // Collect updated data
                              String updatedImageUrl = _imageFile != null
                                  ? await _uploadImage(_imageFile!) // Upload image if new image selected
                                  : imageUrl; // Use old image if no image selected

                              Map<String, dynamic> updatedUserInfo = {
                                "email": emailController.text,
                                "name": nameController.text,
                                "phone": phoneController.text,
                                "password": passController.text,
                                "imageUrl": updatedImageUrl,
                                "id": userId,
                                "createdAt": FieldValue.serverTimestamp(),
                                "blockUser": false,
                                "userImage": updatedImageUrl,
                                "userLocation": locatController.text,
                              };

                              // Update the user data in Firestore
                              await updateUser(userId, updatedUserInfo);

                              // Show success message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Account updated successfully")),
                              );
                            } catch (e) {
                              // Handle error and show error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error: ${e.toString()}")),
                              );
                            }
                          },
                          child: Container(
                            height: 45,
                            width: MediaQuery.sizeOf(context).width / 1.7,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: constant.primaryColor),
                            child: Center(
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    color: constant.whiteC, fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
