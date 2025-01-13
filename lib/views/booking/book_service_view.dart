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

class BookServiceView extends StatefulWidget {
  const BookServiceView({super.key});

  @override
  State<BookServiceView> createState() => _BookServiceViewState();
}

class _BookServiceViewState extends State<BookServiceView> {
  final Constant constant = Constant();
  String? selectedSpecialist;
  String? selectedDate;
  String? selectedTime;
  String? notes;
  double price=00.0;



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





  final FirebaseAuth _auth = FirebaseAuth.instance;



void setSpecialistPrice(String? specialist) {
  setState(() {
    if (specialist == null) {
      price = 0.0; 
    } else {
      switch (specialist) {
        case "Ali Abas":
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
    if (selectedSpecialist == null || selectedDate == null || selectedTime == null) {
      Get.snackbar(
        "Sorry!",
        "Please select specialist, date, and time",
        snackPosition: SnackPosition.TOP,
        backgroundColor: constant.primaryColor,
        colorText: Colors.white,
      );
      return;
    }

    // Debug selected inputs
    print("Selected Specialist: $selectedSpecialist, Date: $selectedDate, Time: $selectedTime");

    DateTime dateTime = DateTime.parse(selectedDate!);
    final formattedDate = "${dateTime.day}/${dateTime.month}/${dateTime.year}";

    final userId = _auth.currentUser?.uid ?? 'guestUser';

    // Check if the booking already exists in the sub-collection
    final existingBooking = await FirebaseFirestore.instance
        .collection("Bookings")
        .doc(userId)
        .collection("Booking")
        .where("specialist", isEqualTo: selectedSpecialist)
        .where("date", isEqualTo: formattedDate)
        .where("time", isEqualTo: selectedTime)
        .get();

    if (existingBooking.docs.isNotEmpty) {
      print("Booking already exists");
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

    // Proceed to save booking in the user's sub-collection
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
      "status": "booked",
      "created Date": DateTime.now(),
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
    print("Error saving booking: $e");
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
      backgroundColor: constant.whiteC,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: constant.whiteC,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (c) => const BottomBarStart()));
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: constant.primaryColor,
                )),
            Text("Book Service",
                style: TextStyle(
                    color: constant.primaryColor, fontWeight: FontWeight.bold)),
            const SizedBox()
          ],
        ),
        centerTitle: true,
        elevation: 20,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Our Specialist",
                        style: GoogleFonts.manrope(
                            fontSize: 18,
                            color: constant.primaryColor,
                            fontWeight: FontWeight.bold)),
                    // Text("view all",
                    //     style: GoogleFonts.manrope(
                    //         fontSize: 16,
                    //         color: constant.primaryColor,
                    //         fontWeight: FontWeight.bold)),
                  ],
                ),
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
                child: DateTimeWidget(onDateSelected: (date) {
       
       
       
                  setState(() {
                    selectedDate = date.toString();
                  });
                }),
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
                child: Text("Notes",
                    style: GoogleFonts.manrope(
                        fontSize: 18,
                        color: constant.primaryColor,
                        fontWeight: FontWeight.bold)),
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
              const SizedBox(height: 110),
            ],
          ),
        ),
      ),
    
    
      bottomSheet: Container(
        height: 80,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total (1 Service)",
                  style: TextStyle(color: constant.primaryColor, fontSize: 16),
                ),
              RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: 'PKR $price ',
        style: TextStyle(
          color: constant.primaryColor,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      TextSpan(
        text: 'PKR ${price * 2-25}',
        style: TextStyle(
          color: constant.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          decoration: TextDecoration.lineThrough,
        ),
      ),
    ],
  ),
),

              ],
            ),
            InkWell(
              onTap: saveBooking,
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 130,
                height: 60,
                decoration: BoxDecoration(
                    color: constant.primaryColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    "Checkout",
                    style: TextStyle(color: constant.whiteC, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
