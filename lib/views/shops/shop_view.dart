import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamify/chatbot/AssistantBot.dart';
import 'package:glamify/chatbot/AssistantBotMan.dart';
import 'package:glamify/views/booking/book_service_view.dart';
import 'package:glamify/views/booking/book_upcoming.dart';
import 'package:glamify/widgets/bottomBar.dart';
import 'package:glamify/widgets/constant.dart';

class ShopView extends StatefulWidget {
  const ShopView({super.key});

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  final Constant constant = Constant();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Image Section
            Container(
              height: MediaQuery.of(context).size.height / 2.2,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/shopbg.png"),
                  fit: BoxFit.cover, // Ensures the image covers the entire area
                ),
              ),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xffF9FAFA),
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                               Navigator.push(context, MaterialPageRoute(builder: (c)=>const BottomBarStart()));
                        },
                        icon: Center(
                            child: Icon(
                          Icons.arrow_back_ios,
                          color: constant.primaryColor,
                        ))),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xffF9FAFA),
                          borderRadius: BorderRadius.circular(30)),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 66,
                      height: 66,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      child: IconButton(
                          onPressed: () {
                            Get.to(const BookUpcoming());
                          },
                          icon: Image.asset(
                            "assets/images/mp.png",
                            fit: BoxFit.cover,
                            height: 55,
                            width: 55,
                          )),
                    ),
                  ],
                )
              ],
            ),
         
         
            ),

            // Information Section
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Booking Information",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: constant.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                "Discover our premium salon services tailored to your needs. Book now to experience exclusive offers and the best in beauty and care. Let us make your appointment seamless and enjoyable!"
                   , style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                         Get.to(const BookUpcoming());
                      },
                      style: ElevatedButton.styleFrom(
                    backgroundColor: constant.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Show Details",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Bottom Action Bar
      bottomSheet: Container(
        height: 80,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
               Container(
                width: 65,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all()),
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: InkWell(
                     onTap: () {
                       showDialog(
                         context: context,
                         builder: (BuildContext context) {
                           return AlertDialog(
                             title: const Text('Select AI Bot'),
                             content: Column(
                               mainAxisSize: MainAxisSize.min,
                               children: [
                                 ListTile(
                    title: const Text('Male Tips AI'),
                    onTap: () {
                      // Action for Male 
                      Navigator.pop(context);  
                      Get.to(AssistantBotMan()); 
                    },
                                 ),
                                 ListTile(
                    title: const Text('Female Tips AI'),
                    onTap: () {
                      // Action for Female
                      Navigator.pop(context);  
                      Get.to(AssistantBot());
                    },
                                 ),
                               ],
                             ),
                           );
                         },
                       );
                     },
                     child: Container(
                       width: 45,
                       height: 45,
                       decoration: BoxDecoration(
                         color: constant.primaryColor,
                         borderRadius: BorderRadius.circular(20),
                       ),
                       child: Icon(
                         Icons.message,
                         color: constant.whiteC,
                       ),
                     ),
                   ),
                 ),
               ),

                                    
      
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (c) => const BookServiceView()),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                  color: constant.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    "Book Now",
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
