import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamify/views/booking/add_book_service.dart';
import 'package:glamify/widgets/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceMenueWidget extends StatelessWidget {
  final String img;
  final String title;
  final String price;
  final String desc;

  ServiceMenueWidget({
    super.key,
    required this.img,
    required this.title,
    required this.price,
    required this.desc,
  });

  final Constant constant = Constant();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  img,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Details Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: GoogleFonts.manrope(
                        fontSize: 18,
                        color: const Color(0xff156778),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Price with + Button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          price,
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            color: const Color(0xff156778),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(
                              AddBookService(
                                img: img,
                                title: title,
                                price: price,
                                desc: desc,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(
                              backgroundColor: constant.primaryColor,
                              child: Icon(
                                Icons.add,
                                color: constant.whiteC,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Description
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      desc,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: const Color(0xff156778),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
