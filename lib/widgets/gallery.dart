

import 'package:flutter/material.dart';

class GalleryWidget extends StatelessWidget {
  final String imgPath;

  const GalleryWidget({super.key, 
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 153,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect( 
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imgPath,
            fit: BoxFit.cover,
            height: 140,
            width: 126,
          ),
        ),
        // SizedBox(width: 5,),
      ),
    );
  }
}
