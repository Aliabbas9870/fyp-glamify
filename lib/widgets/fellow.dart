import 'package:flutter/material.dart';

class Fellow extends StatelessWidget {
  final String imgPath;

  const Fellow({super.key, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
        // child: Image.asset(imag),
        foregroundImage: AssetImage(imgPath),
          backgroundImage: AssetImage(imgPath),
          radius: 35.0, // Increase the radius to make the CircleAvatar larger
        ),
        
      ],
    );
  }
}
