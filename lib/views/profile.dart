import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamify/auth/login_auth.dart';
import 'package:glamify/service_db/database.dart';
import 'package:glamify/views/about_view.dart';
import 'package:glamify/views/account_view.dart';
import 'package:glamify/views/help_view.dart';
import 'package:glamify/views/payment/payment_view.dart';
import 'package:glamify/views/reviews/add_review.dart';
import 'package:glamify/views/reviews/show_review.dart';
import 'package:glamify/widgets/constant.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      Reference storageRef =
          FirebaseStorage.instance.ref().child('UserImages/${user!.uid}.jpg');

      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        imageUrl = downloadUrl;
      });
    }
  }

  final Constant constant = Constant();
  final MethodDataFetch dataFetcher = MethodDataFetch();
  User? user;
  Map<String, dynamic>? userData;

  String? imageUrl;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _loadUserData();
    }
  }

  Future<void> _loadUserData() async {
    Map<String, dynamic>? data = await dataFetcher.fetchUserData(user!.uid);
    setState(() {
      userData = data;
    });
  }

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: TextStyle(
              color: constant.whiteC,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        elevation: 20,
        backgroundColor: const Color(0xff156778),
        // actions: [
        //   Icon(Icons.cut, color: constant.whiteC),
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Text(
        //       "Gobar",
        //       style: TextStyle(
        //           color: constant.whiteC,
        //           fontSize: 16,
        //           fontWeight: FontWeight.bold),
        //     ),
        //   )
        // ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bgProfile.png"),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 34,
                      backgroundColor: constant.primaryColor,

                      backgroundImage: userData?["userImage"] != null
                          ? NetworkImage(userData!["userImage"])
                          : const AssetImage("assets/images/BtmM.png")
                              as ImageProvider, // Fallback default image
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 8),
                          child: Container(
                              width: 80,
                              height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: const Color(0xffF98600)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/patim.png"),
                                  const SizedBox(width: 5),
                                  const Center(
                                      child: Text(
                                    "Platinum",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            userData?['name'] ??
                                user?.displayName ??
                                "User Name",
                            style: TextStyle(
                                color: constant.whiteC,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(const AccountView());
                            },
                            child: Image.asset(
                              "assets/images/editIcon.png",
                              color: constant.primaryColor,
                              scale: 0.8,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: constant.whiteC,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          userData?['email'] ?? user?.email ?? "User Email",
                          style:
                              TextStyle(color: constant.whiteC, fontSize: 17),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_city,
                          color: constant.whiteC,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          userData?['userLocation'] ?? "Location",
                          style:
                              TextStyle(color: constant.whiteC, fontSize: 17),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: constant.whiteC,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(
                          25,
                        ),
                        topLeft: Radius.circular(25))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 20),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "settings",
                        style: TextStyle(
                            color: constant.primaryColor, fontSize: 17),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Notification",
                            style: TextStyle(
                                color: constant.primaryColor, fontSize: 17),
                          ),
                          Switch(
                            activeTrackColor: constant.primaryColor,
                            activeColor: constant.whiteC,
                            value: isSwitched,
                            inactiveThumbColor: constant.primaryColor,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) => const AccountView()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Account",
                              style: TextStyle(
                                  color: constant.primaryColor, fontSize: 17),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: constant.primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),

// show review

                      const SizedBox(
                        height: 12,
                      ),

                      InkWell(
                        onTap: () {
                          
                          String userId =
                              FirebaseAuth.instance.currentUser?.uid ?? '';
                          if (userId.isNotEmpty) {
                      
                            Get.to(() => ShowReviews(userId: userId));
                          } else {
                    
                            print("No user logged in.");
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Check Reviews",
                              style: TextStyle(
                                  color: constant.primaryColor, fontSize: 17),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: constant.primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => const JazzCashPaymentScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Payment pay",
                              style: TextStyle(
                                  color: constant.primaryColor, fontSize: 17),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: constant.primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      InkWell(
                        onTap: () {
                          Get.to(ReviewScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Review",
                              style: TextStyle(
                                  color: constant.primaryColor, fontSize: 17),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: constant.primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 12,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) => const HelpView()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Help",
                              style: TextStyle(
                                  color: constant.primaryColor, fontSize: 17),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: constant.primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 12,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) => const AboutView()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "About",
                              style: TextStyle(
                                  color: constant.primaryColor, fontSize: 17),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: constant.primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 59,
                      ),
                      InkWell(
                        onTap: () async {
                          try {
                            // Sign out the user from Firebase
                            await FirebaseAuth.instance.signOut();
                            print('User successfully signed out');

                            Get.to(const LoginAuth());
                          } catch (e) {
                            print('Error signing out: $e');
                            // Optionally, show an error message to the user
                          }
                        },
                        child: Center(
                          child: Container(
                            height: 45,
                            width: MediaQuery.sizeOf(context).width / 1.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: constant.primaryColor,
                            ),
                            child: Center(
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  color: constant.whiteC,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
