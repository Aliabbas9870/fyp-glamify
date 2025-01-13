



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glamify/service_db/database.dart';
import 'package:glamify/widgets/constant.dart';


class CompletedContent extends StatefulWidget {
  const CompletedContent({super.key});

  @override
  State<CompletedContent> createState() => _CompletedContentState();
}

class _CompletedContentState extends State<CompletedContent> {
  final Constant constant = Constant();
  Stream? bookingStream;

  @override
  void initState() {
    super.initState();
    getOnLoadData();
  }

  getOnLoadData() async {
    bookingStream = await DataBaseMethod().fetchBookingData();
    setState(() {});
  }

  Widget bookingData() {
    return StreamBuilder(
      stream: bookingStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        }
        if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return const Center(child: Text('No upcoming bookings found.'));
        }

        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return Card(
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Text(
                      "Salone Booking",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Specialist
                    Text(
                      "Specialist: ${ds['specialist'] ?? 'Service Name Unavailable'}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                         Text(
                      "Service Price: ${ds['servicePrice'] ?? 'Service price Unavailable'}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                      Text(
                      "Booking Type: ${ds['bookingType'] ?? 'Service type Unavailable'}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Date and Time
                    Text(
                      "Date: ${ds['date'] ?? 'N/A'}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      "Time: ${ds['time'] ?? 'N/A'}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
               
                   
           
                         const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: bookingData(),
      ),
    );
  }
}



