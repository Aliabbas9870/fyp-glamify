import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamify/widgets/constant.dart';
import 'package:glamify/widgets/near_by_offer.dart';
import 'package:glamify/widgets/search_interest.dart';
import 'package:google_fonts/google_fonts.dart';

class NearBySalonList extends StatefulWidget {
  const NearBySalonList({super.key});

  @override
  State<NearBySalonList> createState() => _NearBySalonListState();
}

class _NearBySalonListState extends State<NearBySalonList> {
  final Constant constant = Constant();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 5.0,bottom: 2.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Services Section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back_ios_new, color: Color(0xff156778),size: 28,)),
                    const SizedBox(width: 8,),
                    Text("Nearby Salon List",                  style: GoogleFonts.manrope(
                                      fontSize: 20,
                                      color: const Color(0xff156778),
                                      fontWeight: FontWeight.bold
                                      )),
                  ],
                ),
              ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 88,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ServiceMenueWid (
                                    imgPath: "assets/images/hr.png",
                                    title: "Fair",
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                 ServiceMenueWid (
                                    imgPath: "assets/images/facial.png",
                                    title: "Facial",
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  ServiceMenueWid (
                                    imgPath: "assets/images/nail.png",
                                    title: "Nails",
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
             
              //  SizedBox(height: 5,),
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0,bottom: 5),
                            child: Column(
                              children: [
                                NearByOffer(
                                    image: "assets/images/nearby3.png",
                                    title: "Sophisticated Salon",
                                    service: "Hair . Facial",
                                    location: "360 Stillwater Rd. Palm City.."),


               const SizedBox(height: 12,),

                                NearByOffer(
                                    image: "assets/images/nearby1.png",
                                    title: "Lovely Lather",
                                    service: "Hair . Facial",
                                    location: "360 Stillwater Rd. Palm City.."),
                                             const SizedBox(height: 12,),

                                NearByOffer(
                                    image: "assets/images/nearby2.png",
                                    title: "Cute Stuff Salon",
                                    service: "Hair . Facial",
                                    location: "360 Stillwater Rd. Palm City.."),
                                             const SizedBox(height: 12,),

                                NearByOffer(
                                    image: "assets/images/nearby4.png",
                                    title: "Love Live Salon",
                                    service: "Hair . Facial",
                                    location: "360 Stillwater Rd. Palm City.."),
                                             const SizedBox(height: 12,),

                                NearByOffer(
                                    image: "assets/images/nearby1.png",
                                    title: "Sophisticated Salon",
                                    service: "Hair . Facial",
                                    location: "360 Stillwater Rd. Palm City.."),
                                             const SizedBox(height: 12,),

                                NearByOffer(
                                    image: "assets/images/nearby3.png",
                                    title: "Sophisticated Salon",
                                    service: "Hair . Facial",
                                    location: "360 Stillwater Rd. Palm City.."),
                              ],
                            ),
                          ),
                        )
            
            ],
          ),
        ),
      ),
    );
  }
}
