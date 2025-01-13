import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamify/chatbot/AssistantBot.dart';
import 'package:glamify/views/booking/book_service_view.dart';
import 'package:glamify/widgets/constant.dart';

class NaerBySaloneData extends StatelessWidget {
  final String image;
  final String title;
  final String service;
  final String location;
  final Constant constant = Constant();


   NaerBySaloneData({
    super.key,
    required this.image,
    required this.title,
    required this.service,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(title, style: const TextStyle(color:Colors.white)),
        backgroundColor: const Color(0xff156778),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Image
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff156778),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Service
                  Text(
                    service,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Location
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
        bottomSheet: Container(
        height: 80,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "Total (1 Service)",
            //       style: TextStyle(color: constant.primaryColor, fontSize: 16),
            //     ),
            //     RichText(
            //       text: TextSpan(
            //         children: [
            //           TextSpan(
            //             text: '\$5 ',
            //             style: TextStyle(
            //                 color: constant.primaryColor,
            //                 fontSize: 25,
            //                 fontWeight: FontWeight.bold),
            //           ),
            //           TextSpan(
            //             text: '\$10',
            //             style: TextStyle(
            //               color: constant.primaryColor,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18,
            //               decoration: TextDecoration.lineThrough,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
        
        
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: constant.primaryColor),
                  borderRadius: BorderRadius.circular(30)),
              child: IconButton(
                  onPressed: () {
                    Get.to(const AssistantBot());

                  },
                  icon: Icon(
                    Icons.message,
                    color: constant.primaryColor,
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (c) => const BookServiceView()));
              },
              child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                      color: constant.primaryColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Text(
                      "Book Now",
                      style: TextStyle(color: constant.whiteC, fontSize: 18),
                    ),
                  )),
            ),
          ],
        ),
      ),
   
    );
  }
}
