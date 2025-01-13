import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glamify/widgets/constant.dart';

class TimeGetWidget extends StatefulWidget {
  final Function(String) onTimeSelected;
  final String? selectedSpecialist; // The selected specialist
  final String? selectedDate;       // The selected date

  const TimeGetWidget({
    super.key,
    required this.onTimeSelected,
    required this.selectedSpecialist,
    required this.selectedDate,
  });

  @override
  State<TimeGetWidget> createState() => _TimeGetWidgetState();
}

class _TimeGetWidgetState extends State<TimeGetWidget> {
  final Constant constant = Constant();
  String? selectedTime; // Currently selected time slot
  final List<String> times = [
    "8:00 AM", "9:30 AM", "11:00 AM", "12:30 PM", "2:00 PM", "3:00 PM", "4:00 PM"
  ];

  List<String> bookedTimes = []; // List of booked times fetched from Firestore

  @override
  void initState() {
    super.initState();
    fetchBookedTimes();
  }

  Future<void> fetchBookedTimes() async {
    if (widget.selectedSpecialist != null && widget.selectedDate != null) {
      try {
        // Parse and format the date for comparison
        DateTime date = DateTime.parse(widget.selectedDate!);
        String formattedDate = "${date.day}/${date.month}/${date.year}";

        // Fetch booked times from Firestore
        final querySnapshot = await FirebaseFirestore.instance
            .collection("Bookings")
            .where("specialist", isEqualTo: widget.selectedSpecialist)
            .where("date", isEqualTo: formattedDate)
            .get();

        setState(() {
          bookedTimes = querySnapshot.docs
              .map((doc) => doc["time"] as String)
              .toList();
        });
      } catch (e) {
        print("Error fetching booked times: $e");
      }
    } else {
      setState(() {
        bookedTimes = [];
      });
    }
  }

  @override
  void didUpdateWidget(TimeGetWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedSpecialist != oldWidget.selectedSpecialist ||
        widget.selectedDate != oldWidget.selectedDate) {
      fetchBookedTimes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Time",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: times.map((time) {
              final isBooked = bookedTimes.contains(time);
              return GestureDetector(
                onTap: isBooked
                    ? null
                    : () {
                        setState(() {
                          selectedTime = time;
                        });
                        widget.onTimeSelected(time);
                      },
                child: Container(
                  width: 88,
                  height: 50,
                  margin: const EdgeInsets.only(right: 8, top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(),
                    color: selectedTime == time
                        ? constant.primaryColor
                        : isBooked
                            ? Colors.grey.shade300
                            : constant.whiteC,
                  ),
                  child: Center(
                    child: Text(
                      time,
                      style: TextStyle(
                        color: selectedTime == time
                            ? Colors.white
                            : isBooked
                                ? Colors.grey
                                : Colors.black,
                        decoration: isBooked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
