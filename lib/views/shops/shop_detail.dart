import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamify/chatbot/AssistantBot.dart';
import 'package:glamify/views/booking/book_service_view.dart';
import 'package:glamify/views/booking/book_upcoming.dart';
import 'package:glamify/widgets/bottomBar.dart';
import 'package:glamify/widgets/constant.dart';
import 'package:glamify/widgets/specialist.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopDetailView extends StatefulWidget {
  const ShopDetailView({super.key});

  @override
  State<ShopDetailView> createState() => _ShopDetailViewState();
}

class _ShopDetailViewState extends State<ShopDetailView> {
  final Constant constant = Constant();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            // height: MediaQuery.sizeOf(context).height / 2.2,
            height: 248,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/shopbg.png"),
                    fit: BoxFit.cover)),
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text("Gallery",
                //     style: GoogleFonts.manrope(
                //         fontSize: 18,
                //           color: constant.primaryColor,
                       
                //         fontWeight: FontWeight.bold)),
                // Text("view all",
                //     style: GoogleFonts.manrope(
                //         fontSize: 16,
                //         color: constant.primaryColor,
                //         fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        
     
     
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
                SpecialListWidget(
                    imgPath: "assets/images/Sp1.png", title: "Ali Abas", onTap: () {  },),
                SpecialListWidget(
                    imgPath: "assets/images/SpG2.png", title: "Dr. Binya", onTap: () {  },),
                SpecialListWidget(
                    imgPath: "assets/images/SpG3.png", title: "Sn. Aqib", onTap: () {  },),
                SpecialListWidget(
                    imgPath: "assets/images/Sp4.png", title: "Rao Aqib", onTap: () {  },),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
      bottomSheet: Container(
        height: 80,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
           
        
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: constant.primaryColor),
                  borderRadius: BorderRadius.circular(30)),
              child: IconButton(
                  onPressed: () {
                    Get.to(AssistantBot());

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
