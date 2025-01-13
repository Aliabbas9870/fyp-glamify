
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glamify/service_db/database.dart';
import 'package:glamify/widgets/constant.dart';


class UpcomingContent extends StatefulWidget {
  const UpcomingContent({super.key});

  @override
  State<UpcomingContent> createState() => _UpcomingContentState();
}

class _UpcomingContentState extends State<UpcomingContent> {
  final Constant constant = Constant();
  Stream<QuerySnapshot>? bookingStream;

  @override
  void initState() {
    super.initState();
    getOnLoadData();
  }

  getOnLoadData() async {
    try {
      bookingStream = await DataBaseMethod().fetchBookingData();
      print("Booking stream initialized: $bookingStream");
      setState(() {});
    } catch (e) {
      print("Error initializing booking stream: $e");
    }
  }

  void showCancelBottomSheet(BuildContext context, DocumentSnapshot ds) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Specialist: ${ds['specialist'] ?? 'Service Name Unavailable'}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Are you sure you want to cancel?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Canceling your appointment will remove it from your upcoming bookings.",
                    style: TextStyle(fontSize: 15),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await ds.reference.update({'status': 'canceled'});
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: constant.primaryColor,
                          content: const Text('Booking cancelled.'),
                        ),
                      );
                    },
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: const Center(child: Text('Yes, Cancel Booking'))),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      backgroundColor: constant.primaryColor,
                    ),
                    child: Text(
                      'Keep Appointment',
                      style: TextStyle(color: constant.whiteC),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget bookingData() {
    return StreamBuilder<QuerySnapshot>(
      stream: bookingStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          print("Error: ${snapshot.error}");
          return Center(child: Text('Error loading data: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No upcoming bookings found.'));
        }

        List<DocumentSnapshot> bookedDocs =
            snapshot.data!.docs.where((doc) => doc['status'] == 'booked').toList();

        if (bookedDocs.isEmpty) {
          return const Center(child: Text('No booked appointments found.'));
        }

        return ListView.builder(
          itemCount: bookedDocs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = bookedDocs[index];
            return Card(
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Salon Booking",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Specialist: ${ds['specialist'] ?? 'Service Name Unavailable'}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                   
                     const SizedBox(height: 4),
                     
                    Text(
                      "Service Title: ${ds['serviceTitle'] ?? 'Service title Unavailable'}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                     
                    Text(
                      "Booking Type: ${ds['bookingType'] ?? 'Service type Unavailable'}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
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
                    const SizedBox(height: 8),
                    Text(
                      "Status: ${ds['status'] ?? 'Unknown'}",
                      style: TextStyle(
                        fontSize: 14,
                        color: ds['status'] == 'booked'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => showCancelBottomSheet(context, ds),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        backgroundColor: constant.primaryColor,
                      ),
                      child: Text(
                        'Cancel Booking',
                        style: TextStyle(color: constant.whiteC),
                      ),
                    ),
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
      body: bookingData(),
    );
  }
}
