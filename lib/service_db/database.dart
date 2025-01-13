import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamify/widgets/bottomBar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

// This method for google login
class AuthMethod {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> singInWithGoogle(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      if (googleSignInAuthentication != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        UserCredential result = await auth.signInWithCredential(credential);
        User? userDetails = result.user;

        if (userDetails != null) {
          Map<String, dynamic> userInfoMap = {
            "email": userDetails.email,
            "name": userDetails.displayName,
            "password":
                  "", 
            "imageUrl": userDetails.photoURL,
            "id": userDetails.uid,
            "createdAt": FieldValue.serverTimestamp(),
            "blockUser": false, // Optional field for blocking user
            "userImage":
                userDetails.photoURL ?? "", // Optional field for user image
            "userLocation": "",
          };

          await DataBaseMethod()
              .addUser(userDetails.uid, userInfoMap)
              .then((e) {
            Navigator.of(context).pop(); // Close
            Get.to(const BottomBarStart());
          });
        }
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close the CircularProgressIndicator
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          // backgroundColor: constant.primaryColor,
          content: Text(
        "Sign in failed. Please try again.",
        style: TextStyle(fontSize: 18),
      )));
    }
  }
}

class DataBaseMethod {
  // Method to add user
  Future<void> addUser(String userId, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection("User")
        .doc(userId)
        .set(userInfoMap);
  }

  // Method to update an existing user
  Future<void> updateUser(String userId, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection("User")
        .doc(userId)
        .update(userInfoMap);
  }

  // Function to fetch user data from Firestore
  Future<Map<String, dynamic>?> fetchUserData(String uid) async {
    try {
      DocumentSnapshot documentSnapshot =
          await FirebaseFirestore.instance.collection('User').doc(uid).get();

      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      throw Exception("Error fetching user data: ${e.toString()}");
    }
  }

// booking specilist   
Future<Stream<QuerySnapshot>> fetchBookingData() async {
  final String userId = FirebaseAuth.instance.currentUser!.uid; // Ensure the user is authenticated
  return FirebaseFirestore.instance
      .collection("Bookings")
      .doc(userId)
      .collection("Booking")
      .snapshots();
}

//  Future<Stream<QuerySnapshot>> fetchBookingData() async {
//   // final String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
//   return FirebaseFirestore.instance
//       .collection("Bookings")
      
//       .snapshots();
// }


Future<void> addServiceBooking(String userId, Map<String, dynamic> bookingInfo) async {
  try {
    await FirebaseFirestore.instance
        .collection("ServiceBookings") 
        .doc(userId)
        .collection("Bookings") 
        .add(bookingInfo);
    print("Service booked successfully!");
  } catch (e) {
    print("Error booking service: $e");
  }
}


// Method to update the status of a booking for the logged-in user
Future<void> updateBookingStatus(String bookingId, String newStatus) async {
  try {
    await FirebaseFirestore.instance
        .collection("Bookings")
        .doc(bookingId)
        .update({
      'status': newStatus,
    });
    print("Booking status updated successfully");
  } catch (e) {
    print("Error updating booking status: \$e");
    rethrow;
  }
}


}




// fetech data from firebase

class MethodDataFetch {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>?> fetchUserData(String userId) async {
    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection("User").doc(userId).get();

      if (userSnapshot.exists && userSnapshot.data() != null) {
        return userSnapshot.data() as Map<String, dynamic>;
      } else {
        print("User data not found for userId: \$userId");
        return null;
      }
    } catch (e) {
      print("Error fetching user data: \$e");
      return null;
    }
  }
}

// update user data

class MethodUpdateData {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> updateUserData(User userDetails) async {
    try {
      // Getting reference to the user's document in Firestore
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('User').doc(userDetails.uid);

      // Data to be updated
      Map<String, dynamic> updatedData = {
        "email": userDetails.email,
        "name": userDetails.displayName,
        "password":
                  "", 
        "imageUrl": userDetails.photoURL,
        "id": userDetails.uid,
        "createdAt": FieldValue.serverTimestamp(),
        "blockUser": false,
        "userImage": userDetails.photoURL ?? "",
        "userLocation": "",
      };

      // Update the user document with new data
      await userRef.update(updatedData);
      print("User data updated successfully!");
    } catch (e) {
      print("Error updating user data: $e");
    }
  }
}



class AuthMethodR {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register a user with Google
  Future<void> registerWithGoogle(BuildContext context) async {
    _showLoadingDialog(context);

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection("User")
              .doc(user.uid)
              .get();

          if (!userDoc.exists) {
            // Register new user and upload image if available
            String imageUrl = user.photoURL != null
                ? await _uploadUserImage(user.photoURL!)
                : "";

            Map<String, dynamic> userInfo = {
              "email": user.email,
              "name": user.displayName,
              "password": "", // Placeholder
              "imageUrl": imageUrl,
              "id": user.uid,
              "createdAt": FieldValue.serverTimestamp(),
              "blockUser": false,
              "userImage": imageUrl,
              "userLocation": "",
            };

            await DataBaseMethod().addUser(user.uid, userInfo).then((_) {
              Navigator.of(context).pop(); // Close loading dialog
              Get.to(const BottomBarStart()); // Navigate to main screen
            });
          } else {
            _closeLoadingDialog(context);
            _showSnackBar(context, "User already registered. Please sign in.");
          }
        }
      }
    } catch (e) {
      _closeLoadingDialog(context);
      _showSnackBar(context, "Registration failed. Please try again.");
      print("Error during registration: $e");
    }
  }

  // Helper function to show loading dialog
  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  // Helper function to close loading dialog
  void _closeLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  // Helper function to show snack bar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  // Upload user's image to Firebase Storage
  Future<String> _uploadUserImage(String photoUrl) async {
    try {
      final response = await http.get(Uri.parse(photoUrl));
      if (response.statusCode == 200) {
        final String fileName =
            "user_images/${DateTime.now().millisecondsSinceEpoch}.jpg";
        final storageRef = FirebaseStorage.instance.ref().child(fileName);
        final uploadTask = await storageRef.putData(response.bodyBytes);
        return await uploadTask.ref.getDownloadURL();
      } else {
        throw Exception("Failed to load image");
      }
    } catch (e) {
      print("Error uploading user image: $e");
      return "";
    }
  }


}




