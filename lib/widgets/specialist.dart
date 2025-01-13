import 'package:flutter/material.dart';

class SpecialListWidget extends StatelessWidget {
  final String imgPath;
  final String title;
  final VoidCallback? onTap; // Callback for onTap event

  const SpecialListWidget({super.key, 
    required this.imgPath,
    required this.title,
     this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Assign the callback to the onTap property
      child: Container(
        width: 133,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(
                imgPath,
                height: 99,
                width: 120,
                scale: 0.5,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
