import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamify/views/reviews/show_review.dart';
import 'package:glamify/widgets/constant.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double _rating = 0.0; 
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();  // Added username controller
  final TextEditingController _useremailController = TextEditingController(); // Added email controller
  final Constant constant = Constant();

  // Add review to Firestore (now reviews are stored as a subcollection of the user)
  Future<void> addReview(String userId, Map<String, dynamic> reviewData) {
    return FirebaseFirestore.instance
        .collection("UsersRating")  
        .doc(userId)
        .collection("Reviews")  // Subcollection to store multiple reviews
        .add(reviewData);  
  }

  void submitReview() {
    
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You must be logged in to add a review'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    String userId = user.uid; // Use the current user's UID
    
    // Validation checks for rating, title, review, username, and email
    if (_rating == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select a rating'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a review title'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (_reviewController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please write a review'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter your name'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (_useremailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter your email'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    Map<String, dynamic> reviewData = {
      'rating': _rating,
      'title': _titleController.text,
      'review': _reviewController.text,
      'username': _usernameController.text,
      'useremail': _useremailController.text,
      'timestamp': FieldValue.serverTimestamp(), 
    };

  
    addReview(userId, reviewData).then((_) {
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Review Added Successfully!'),
        backgroundColor: constant.primaryColor,
      ));

      // Clear the input fields after submission
      _titleController.clear();
      _reviewController.clear();
      _usernameController.clear();
      _useremailController.clear();
      setState(() {
        _rating = 0.0; // Reset rating
      });
    }).catchError((error) {
      // Show error message if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add review: $error'),
        backgroundColor: Colors.red,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constant.whiteC),
        title: Text('Add Review', style: TextStyle(color: constant.whiteC)),
        backgroundColor: constant.primaryColor,
        actions: [
          TextButton(onPressed: (){

            // Fetch the current user's UID
            String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
            
            // Check if the user is logged in
            if (userId.isNotEmpty) {
              // Pass the userId when navigating to ShowReviews
              Get.to(() => ShowReviews(userId: userId));
            } else {
              // Handle the case when the user is not logged in
              print("No user logged in.");
            }
            // Get.to(ShowReviews());
          }, child: Text("Check Reviews",style: TextStyle(color: constant.whiteC),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rating section
              Row(
                children: [
                  Icon(Icons.star, color: _rating >= 1 ? Colors.amber : Colors.grey),
                  Icon(Icons.star, color: _rating >= 2 ? Colors.amber : Colors.grey),
                  Icon(Icons.star, color: _rating >= 3 ? Colors.amber : Colors.grey),
                  Icon(Icons.star, color: _rating >= 4 ? Colors.amber : Colors.grey),
                  Icon(Icons.star, color: _rating >= 5 ? Colors.amber : Colors.grey),
                ],
              ),
              const SizedBox(height: 8),
              Slider(
                value: _rating,
                min: 0,
                max: 5,
                divisions: 5,
                label: _rating.toString(),
                onChanged: (double value) {
                  setState(() {
                    _rating = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Review Title input
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter your review title here',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Review Text input
              TextField(
                controller: _reviewController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Write your review here',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Username input
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: 'Enter username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // User email input
              TextField(
                controller: _useremailController,
                decoration: const InputDecoration(
                  hintText: 'Enter user email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Add Review Button
              Center(
                child: ElevatedButton(
                  onPressed: submitReview, // Trigger the submitReview function
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: constant.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Add Review',
                    style: TextStyle(color: constant.whiteC),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
