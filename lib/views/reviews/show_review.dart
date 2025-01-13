import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glamify/widgets/constant.dart';
// import 'package:fypapp/widgets/constant.dart';

class ShowReviews extends StatelessWidget {
  final String userId;

  const ShowReviews({super.key, required this.userId});
  Future<List<Map<String, dynamic>>> getReviews() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("UsersRating")
        .doc(userId)
        .collection("Reviews")
        .orderBy('timestamp', descending: true) 
        .get();

    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      iconTheme: IconThemeData(color: Constant().whiteC),
        backgroundColor: Constant().primaryColor,
        title: Text("User Reviews",style: TextStyle(color: Constant().whiteC),)),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getReviews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No reviews yet."));
          }

          // List of reviews
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var review = snapshot.data![index];
              return ReviewCard(review: review);
            },
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewCard extends StatelessWidget {
  final Map<String, dynamic> review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    // Safely cast the rating value to int
    int rating = (review['rating'] as num).toInt();  // Handle double/num as int
    String title = review['title'] ?? '';
    String reviewText = review['review'] ?? '';
    String username = review['username'] ?? '';
    String userEmail = review['useremail'] ?? '';
    Timestamp timestamp = review['timestamp'] ?? Timestamp.now();

    String formattedDate = timestamp.toDate().toString().split(' ')[0];

    List<Widget> stars = List.generate(5, (index) {
      return Icon(
        index < rating ? Icons.star : Icons.star_border,
        color: Colors.yellow[700],
      );
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (index) {
                  // Delay each bar display
                  Future.delayed(Duration(milliseconds: 200 * index), () {
                    if (context.mounted) {
                    
                    }
                  });

                
                  Color barColor = index < rating
                      ? (index % 2 == 0 ? Constant().primaryColor : Colors.yellow)
                      : Colors.grey[300]!;

                  return Expanded(
                    child: Container(
                      height: 5,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      color: barColor,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),

              // Circular Avatar and username
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Constant().primaryColor,
                    child: const Icon(Icons.person, size: 30, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        userEmail,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Star rating
              Row(
                children: stars,
              ),
              const SizedBox(height: 10),

              // Created date
              Text(
                "Date: $formattedDate",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),

              // Review description
              Text(
                reviewText,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
