import 'package:flutter/material.dart';
import 'package:glamify/widgets/constant.dart';
// import 'package:fypapp/widgets/constant.dart';

class Feature extends StatelessWidget {
  String service;
  String image;
  String location;
  String title;
  Feature(
      {super.key, required this.image,
      required this.title,
      required this.service,
      required this.location});
  final Constant constant = Constant();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width / 1.5,
            height: 160,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      image,
                    ),
                    fit: BoxFit.cover,
                    scale: 1.0),
                borderRadius: BorderRadius.circular(15)),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.favorite_outline_outlined,
                    color: Colors.red,
                    size: 44,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: Row(
              // mainAxisAlignment:
              // MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service,
                    style: TextStyle(fontSize: 14, color: constant.primaryColor))
              ],
            ),
          ),
          Padding(
           padding: const EdgeInsets.only(left: 6.0),
            child: Text(title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: constant.primaryColor)),
          ),
          Padding(
         padding: const EdgeInsets.only(left: 6.0),
            child: Text(location,
                style: TextStyle(fontSize: 14, color: constant.primaryColor)),
          ),
        ],
      ),
    );
  }
}
