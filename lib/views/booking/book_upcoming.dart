import 'package:flutter/material.dart';
import 'package:glamify/views/booking/bookingWidget/cancelBook.dart';
import 'package:glamify/views/booking/bookingWidget/completeBook.dart';
import 'package:glamify/views/booking/bookingWidget/upcomingBook.dart';
import 'package:glamify/widgets/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class BookUpcoming extends StatefulWidget {
  const BookUpcoming({super.key});

  @override
  State<BookUpcoming> createState() => _BookUpcomingState();
}

class _BookUpcomingState extends State<BookUpcoming> {
  final Constant constant = Constant();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constant.whiteC),
        backgroundColor: constant.primaryColor,
        title: Text(
          "Bookings",
          style: GoogleFonts.manrope(
            fontSize: 18,
            color: constant.whiteC,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Row for the buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0; // Set to show "Upcoming"
                      });
                    },
                    child: Text(
                      "Upcoming",
                      style: TextStyle(
                        color: _selectedIndex == 0
                            ? constant.primaryColor
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1; // Set to show "Completed"
                      });
                    },
                    child: Text(
                      "All Booking",
                      style: TextStyle(
                        color: _selectedIndex == 1
                            ? constant.primaryColor
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                    child: Text(
                      "Cancelled",
                      style: TextStyle(
                        color: _selectedIndex == 2
                            ? constant.primaryColor
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _buildContent(), // Show content based on the selected index
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return const UpcomingContent();
      case 1:
        return const CompletedContent();
      case 2:
        return const CancelledContent();
      default:
        return const Center(child: Text("Select a tab to view content"));
    }
  }
}







