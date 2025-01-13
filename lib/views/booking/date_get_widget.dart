import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glamify/widgets/constant.dart';

class DateTimeWidget extends StatefulWidget {
  final Function(DateTime date) onDateSelected;
  final String? selectedSpecialist;

  const DateTimeWidget({
    super.key,
    required this.onDateSelected,
    this.selectedSpecialist,
  });

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  DateTime currentDate = DateTime.now();
  final Constant constant = Constant();
  DateTime? selectedDate;
  Set<DateTime> bookedDates = {};

  @override
  void initState() {
    super.initState();
    if (widget.selectedSpecialist != null) {
      _fetchBookedDates(widget.selectedSpecialist!);
    }
  }

  Future<void> _fetchBookedDates(String specialist) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Bookings")
          .where("specialist", isEqualTo: specialist)
          .get();

      setState(() {
        bookedDates = querySnapshot.docs.map((doc) {
          final dateString = doc["date"] as String;
          final parts = dateString.split("/");
          return DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        }).toSet();
      });
    } catch (e) {
      print("Error fetching booked dates: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime monday = currentDate
        .subtract(Duration(days: (currentDate.weekday - DateTime.monday) % 7));

    List<DateTime> dates = List.generate(7, (index) {
      return monday.add(Duration(days: index));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Date",
          style: TextStyle(fontSize: 21),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: _previousWeek,
              child: const Icon(Icons.arrow_back_ios),
            ),
            Text("${_getMonthName(monday.month)}, ${monday.year}"),
            GestureDetector(
              onTap: _nextWeek,
              child: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: dates.map((date) {
              bool isSunday = date.weekday == DateTime.sunday;
              bool isBooked = bookedDates.contains(date);
              bool isSelected = selectedDate != null &&
                  selectedDate!.day == date.day &&
                  selectedDate!.month == date.month &&
                  selectedDate!.year == date.year;

              return GestureDetector(
                onTap: (isSunday || isBooked)
                    ? null
                    : () {
                        setState(() {
                          selectedDate = date;
                        });
                        widget.onDateSelected(date);
                      },
                child: Container(
                  margin: const EdgeInsets.only(left: 12, top: 12),
                  width: 55,
                  height: 80,
                  decoration: BoxDecoration(
                    color: isSelected
                        ?constant.primaryColor // Background color for selected date
                        : isSunday || isBooked
                            ? Colors.grey
                            : Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: isSelected
                          ? Colors.white // Border color for selected date
                          : Colors.black,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getWeekdayName(date.weekday),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
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

  void _previousWeek() {
    setState(() {
      currentDate = currentDate.subtract(const Duration(days: 7));
    });
  }

  void _nextWeek() {
    setState(() {
      currentDate = currentDate.add(const Duration(days: 7));
    });
  }

  String _getWeekdayName(int weekday) {
    const weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return weekdays[weekday - 1];
  }

  String _getMonthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }
}
