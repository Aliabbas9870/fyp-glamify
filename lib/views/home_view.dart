import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamify/chatbot/AssistantBot.dart';
import 'package:glamify/chatbot/AssistantBotMan.dart';
import 'package:glamify/service_db/database.dart';
import 'package:glamify/views/booking/book_service_view.dart';
import 'package:glamify/views/booking/service_menue.dart';
import 'package:glamify/views/near_by_salon_list.dart';
import 'package:glamify/views/search_view.dart';
// import 'package:glamify/views/services/service_menue.dart';
import 'package:glamify/widgets/constant.dart';
import 'package:glamify/widgets/feature.dart';
import 'package:glamify/widgets/fellow.dart';
import 'package:glamify/widgets/near_by_offer.dart';
import 'package:glamify/widgets/search_interest.dart';
import 'package:glamify/widgets/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Constant constant = Constant();
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        margin: const EdgeInsets.only(left: 5, top: 15),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 9,
                ),
                Container(
                  // height: size.height,
                  // height: double.infinity,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<Map<String, dynamic>?>(
                        future: MethodDataFetch().fetchUserData(userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text(
                              'Error fetching data',
                              style: GoogleFonts.manrope(
                                  fontSize: 18, color: Colors.red),
                            );
                          } else if (snapshot.hasData &&
                              snapshot.data != null) {
                            final userData = snapshot.data!;
                            final name = userData['name'] ?? 'User';
                            final email =
                                userData['email'] ?? 'No email provided';

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Hello! ",
                                                style: GoogleFonts.manrope(
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(name,
                                                style: GoogleFonts.manrope(
                                                    fontSize: 23,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        Text(email,
                                            style: GoogleFonts.manrope(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                     InkWell(
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
                  Get.to(const AssistantBotMan()); 
                },
              ),
              ListTile(
                title: const Text('Female Tips AI'),
                onTap: () {
                  // Action for Female
                  Navigator.pop(context);  
                  Get.to(const AssistantBot());
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

                                    
                                    
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(const SearchView());
                                          },
                                          child: Container(
                                            width: 45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                                color: constant.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Icon(
                                              Icons.search,
                                              color: constant.whiteC,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return Text(
                              'No user data found',
                              style: GoogleFonts.manrope(fontSize: 18),
                            );
                          }
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 108,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(12),
                            image: const DecorationImage(
                                image: AssetImage(
                                  "assets/images/homSlidBg.png",
                                ),
                                fit: BoxFit.cover)),
                        child: SizedBox(
                          height: 78,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 20),
                                    child: SizedBox(
                                      width: 166,
                                      child: Text(
                                          "Look more beautiful and save more discount",
                                          style: GoogleFonts.manrope(
                                            fontSize: 14,
                                            color: constant.whiteC,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: 98,
                                    width: 120,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(12),
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(12)),
                                        color: Color(0xffFFF9E5)),
                                    child: Center(
                                      child: Text("Get offer now!",
                                          style: GoogleFonts.manrope(
                                            fontSize: 14,
                                            color: const Color(0xffF98600),
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  )),
                                  const SizedBox(
                                    height: 7,
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5),
                                child: Container(
                                  width: 88,
                                  height: 84,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: const Color(0xffF98600)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Text("Up To 50%",
                                          style: GoogleFonts.manrope(
                                              fontSize: 24,
                                              color: constant.whiteC,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("What do you want to do?",
                          style: GoogleFonts.manrope(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 12,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap:(){
                              Get.to(ServiceMenue());
                            },
                            child: Container(
                              child: const Services(
                                imgPath: "assets/images/hr.png",
                                title: "Haircut",
                              ),
                            ),
                          ),
                          InkWell(
                             onTap:(){
                              Get.to(ServiceMenue());
                            },
                            child: Container(
                              child: const Services(
                                imgPath: "assets/images/nail.png",
                                title: "Nails",
                              ),
                            ),
                          ),
                          InkWell(
                             onTap:(){
                              Get.to(ServiceMenue());
                            },
                            child: Container(
                              child: const Services(
                                imgPath: "assets/images/facial.png",
                                title: "Facial",
                              ),
                            ),
                          ),
                          InkWell(
                             onTap:(){
                              Get.to(ServiceMenue());
                            },
                            child: Container(
                              child: const Services(
                                imgPath: "assets/images/coloring.png",
                                title: "Coloring",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                             onTap:(){
                              Get.to(ServiceMenue());
                            },
                            child: Container(
                              child: const Services(
                                imgPath: "assets/images/spa.png",
                                title: "Spa",
                              ),
                            ),
                          ),
                          InkWell(
                             onTap:(){
                              Get.to(ServiceMenue());
                            },
                            child: Container(
                              child: const Services(
                                imgPath: "assets/images/waxing.png",
                                title: "Waxing",
                              ),
                            ),
                          ),
                          InkWell(
                             onTap:(){
                              Get.to(ServiceMenue());
                            },
                            child: Container(
                              child: const Services(
                                imgPath: "assets/images/makeup.png",
                                title: "Makeup",
                              ),
                            ),
                          ),
                          InkWell(
                             onTap:(){
                              Get.to(ServiceMenue());
                            },
                            child: Container(
                              child: const Services(
                                imgPath: "assets/images/message.png",
                                title: "Message",
                              ),
                            ),
                          ),
                        ],
                      ),
              
              
              
                      const SizedBox(
                        height: 12,
                      ),
                      Text("Salon you follow",
                          style: GoogleFonts.manrope(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 12,
                      ),

                      const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Fellow(imgPath: "assets/images/salo1.png"),
                            SizedBox(
                              width: 14,
                            ),
                            Fellow(imgPath: "assets/images/salo2.png"),
                            SizedBox(
                              width: 14,
                            ),
                            Fellow(imgPath: "assets/images/salo3.png"),
                            SizedBox(
                              width: 14,
                            ),
                            Fellow(imgPath: "assets/images/salo4.png"),
                            SizedBox(
                              width: 14,
                            ),
                            Fellow(imgPath: "assets/images/salo3.png"),
                            SizedBox(
                              width: 14,
                            ),
                            Fellow(imgPath: "assets/images/salo2.png"),
                            SizedBox(
                              width: 14,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Featured Salon",
                              style: GoogleFonts.manrope(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          InkWell(
                            onTap: () {
                              Get.to(ServiceMenue());
                            },
                            child: Text("view all",
                                style: GoogleFonts.manrope(
                                    fontSize: 16,
                                    color: constant.primaryColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 228,
                  // color: Colors.black,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Get.to(const BookServiceView());
                          },
                          child: Feature(
                            image: "assets/images/f1.png",
                            title: "Salon de Elegance",
                            service: "Hair . Nails . Facial",
                            location: "360 Stillwater Rd. Palm City..",
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        InkWell(
                             onTap: (){
                            Get.to(const BookServiceView());
                          },
                          child: Feature(
                            image: "assets/images/f2.png",
                            service: "Hair . Nails . Facial",
                            title: "Salon de Elegance",
                            location: "2607  Haymond Rocks ..",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: 102,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Most Search Interest",
                                  style: GoogleFonts.manrope(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [

                              
                                InkWell(
                                  onTap:(){
                              Get.to(ServiceMenue());
                            },
                                  child: const SearchInterest(
                                    imgPath: "assets/images/hr.png",
                                    title: "Haircut",
                                  
                                    
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                        onTap:(){
                              Get.to(ServiceMenue());
                            },
                                  child: const SearchInterest(
                                    imgPath: "assets/images/facial.png",
                                    title: "Facial",
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                        onTap:(){
                              Get.to(ServiceMenue());
                            },
                                  child: const SearchInterest(
                                    imgPath: "assets/images/nail.png",
                                    title: "Nails",
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 222,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Nearby Offers",
                                style: GoogleFonts.manrope(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            InkWell(
                              onTap: () {
                                Get.to(const NearBySalonList());
                              },
                              child: Text("view all",
                                  style: GoogleFonts.manrope(
                                      fontSize: 16,
                                      color: constant.primaryColor,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              NearByOffer(
                                  image: "assets/images/f1.png",
                                  title: "Sophisticated Salon",
                                  service: "Hair . Facial",
                                  location: "360 Stillwater Rd. Palm City.."),
                              NearByOffer(
                                  image: "assets/images/nearby2.png",
                                  title: "Sophisticated Salon",
                                  service: "Hair . Facial",
                                  location: "360 Stillwater Rd. Palm City.."),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
