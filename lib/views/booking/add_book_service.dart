import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamify/views/booking/date_get_widget.dart';
import 'package:glamify/views/booking/specialList.dart';
import 'package:glamify/views/booking/time_get_widget.dart';
import 'package:glamify/widgets/bottomBar.dart';
import 'package:glamify/widgets/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class AddBookService extends StatefulWidget {
  final String img;
  final String title;
  final String price;
  final String desc;

  const AddBookService({
    super.key,
    required this.img,
    required this.title,
    required this.price,
    required this.desc,
  });

  @override
  State<AddBookService> createState() => _AddBookServiceState();
}

class _AddBookServiceState extends State<AddBookService> {
  final Constant constant = Constant();
  String? selectedSpecialist;
  String? selectedDate;
  String? selectedTime;
  String? notes;
  double price = 0.0;
  String bookingType = "home"; // Default booking type

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void setSpecialist(String specialist) {
    setState(() {
      if (selectedSpecialist == specialist) {
        selectedSpecialist = null; // Unselect if already selected
        setSpecialistPrice(null); // Reset price
      } else {
        selectedSpecialist = specialist; // Set selected specialist
        setSpecialistPrice(specialist); // Update price
      }
    });
  }

  void setSpecialistPrice(String? specialist) {
    setState(() {
      if (specialist == null || bookingType == "salon") {
        price = 0.0;
      } else {
        switch (specialist) {
          case "Ali Abbas":
            price = 50;
            break;
          case "Madam":
            price = 80;
            break;
          case "Ali A":
            price = 100;
            break;
          case "Rao Aqib":
            price = 100;
            break;
          default:
            price = 50;
        }
      }
    });
  }

  Future<void> saveBooking() async {
    try {
      if (selectedSpecialist == null ||
          selectedDate == null ||
          selectedTime == null) {
        Get.snackbar(
          "Sorry!",
          "Please select specialist, date, and time",
          snackPosition: SnackPosition.TOP,
          backgroundColor: constant.primaryColor,
          colorText: Colors.white,
        );
        return;
      }

      DateTime dateTime = DateTime.parse(selectedDate!);
      final formattedDate =
          "${dateTime.day}/${dateTime.month}/${dateTime.year}";

      final userId = _auth.currentUser?.uid ?? 'guestUser';

      // Check if the booking already exists
      final existingBooking = await FirebaseFirestore.instance
          .collection("Bookings")
          .doc(userId)
          .collection("Booking")
          .where("specialist", isEqualTo: selectedSpecialist)
          .where("date", isEqualTo: formattedDate)
          .where("time", isEqualTo: selectedTime)
          .get();

      if (existingBooking.docs.isNotEmpty) {
        Get.snackbar(
          duration: const Duration(seconds: 4),
          "Sorry!",
          "The selected specialist is already booked at this time. Please choose another time.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Save the booking
      await FirebaseFirestore.instance
          .collection("Bookings")
          .doc(userId)
          .collection("Booking")
          .add({
        "specialist": selectedSpecialist,
        "date": formattedDate,
        "time": selectedTime,
        "notes": notes ?? "",
        "price": price,
        "bookingType": bookingType,
        "serviceTitle": widget.title,
        "serviceDescription": widget.desc,
        "servicePrice": widget.price,
        "status": "booked",
        "createdDate": DateTime.now(),
      });

      Get.snackbar(
        "Congrats",
        "Booking booked successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: constant.primaryColor,
        colorText: constant.whiteC,
      );

      Future.delayed(const Duration(seconds: 2), () {
        Get.to(() => const BottomBarStart());
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to save booking: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constant.whiteC),
        title: Text(
          'Add Booking Service',
          style: GoogleFonts.manrope(color: constant.whiteC),
        ),
        backgroundColor: const Color(0xff156778),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  widget.img,
                  height: 190,
                  width: MediaQuery.of(context).size.width - 20,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: GoogleFonts.manrope(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff156778),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.price,
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff156778),
                ),
              ),
              const Divider(),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Booking Type",
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    color: constant.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text("Home"),
                      value: "home",
                      groupValue: bookingType,
                      onChanged: (value) {
                        setState(() {
                          bookingType = value!;
                          setSpecialistPrice(selectedSpecialist);
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text("Salon"),
                      value: "salon",
                      groupValue: bookingType,
                      onChanged: (value) {
                        setState(() {
                          bookingType = value!;
                          setSpecialistPrice(selectedSpecialist);
                        });
                      },
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SpecialListWidgetBok(
                      imgPath: "assets/images/Sp1.png",
                      title: "Ali Abbas",
                      isSelected: selectedSpecialist == "Ali Abbas",
                      onTap: () {
                        setSpecialist("Ali Abbas");
                      },
                    ),
                    SpecialListWidgetBok(
                      imgPath: "assets/images/SpG3.png",
                      title: "Madam",
                      isSelected: selectedSpecialist == "Madam",
                      onTap: () {
                        setSpecialist("Madam");
                      },
                    ),
                    SpecialListWidgetBok(
                      imgPath: "assets/images/SpG3.png",
                      title: "Ali A",
                      isSelected: selectedSpecialist == "Ali A",
                      onTap: () {
                        setSpecialist("Ali A");
                      },
                    ),
                    SpecialListWidgetBok(
                      imgPath: "assets/images/Sp4.png",
                      title: "Rao Aqib",
                      isSelected: selectedSpecialist == "Rao Aqib",
                      onTap: () {
                        setSpecialist("Rao Aqib");
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DateTimeWidget(
  onDateSelected: (date) {
    setState(() {
      selectedDate = date.toString();
    });
  },
  selectedSpecialist: selectedSpecialist,
)

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TimeGetWidget(
                  onTimeSelected: (time) {
                    setState(() {
                      selectedTime = time;
                    });
                  },
                  selectedSpecialist: selectedSpecialist,
                  selectedDate: selectedDate,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Notes",
                  style: GoogleFonts.manrope(
                      fontSize: 18,
                      color: constant.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  maxLines: 3,
                  onChanged: (value) {
                    notes = value;
                  },
                  decoration: const InputDecoration(
                      hintText: "Type your notes here",
                      border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: constant.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  onPressed: saveBooking,
                  child: const Text(
                    "Confirm Booking",
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
