import 'package:flutter/material.dart';
import 'package:glamify/views/near_by_salon_data.dart';




class NearByOffer extends StatefulWidget {
  final String service;
  final String image;
  final String location;
  final String title;

  const NearByOffer({super.key, 
    required this.image,
    required this.title,
    required this.service,
    required this.location,
  });

  @override
  _NearByOfferState createState() => _NearByOfferState();
}

class _NearByOfferState extends State<NearByOffer> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the Detail Page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NaerBySaloneData(
              image: widget.image,
              
              title: widget.title,
              service: widget.service,
              location: widget.location,
            ),
          ),
        );
      },
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width / 2.5,
              height: 140,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      child: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_outline_outlined,
                        color: isFavorite ? Colors.red : Colors.grey,
                        size: 44,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      height: 33,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                          color: Color(0xffFFF9E5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "1.2km",
                          style: TextStyle(color: Color(0xffF98600)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.service,
                      style: const TextStyle(fontSize: 14, color: Colors.black)),
                  const SizedBox(height: 8),
                  Text(widget.title,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  const SizedBox(height: 8),
                  Text(widget.location,
                      style: const TextStyle(fontSize: 14, color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
