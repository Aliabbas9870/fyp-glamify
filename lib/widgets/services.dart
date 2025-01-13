import 'package:flutter/material.dart';
import 'package:glamify/widgets/constant.dart';
// import 'package:fypapp/widgets/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class Services extends StatelessWidget {
  final String title;
  final String imgPath;

  const Services({super.key, required this.imgPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          // backgroundColor:   Color(0xff156778),
          // backgroundImage: AssetImage(imgPath),
          radius: 30.0,
          // backgroundColor:   Color(0xff156778),
          // backgroundImage: AssetImage(imgPath),
          child: Image.asset(imgPath), // Increase the radius to make the CircleAvatar larger
        ),
        const SizedBox(height: 8.0), // Add some space between the avatar and text
        Text(title, style: GoogleFonts.manrope(
                              fontSize: 14,
                              color: const Color(0xff156778),
                              fontWeight: FontWeight.w500)),
      ],
    );
  }
}




class ServicesA extends StatelessWidget {
  final String title;
  final String imgPath;
  final Function onTap;
  final bool isSelected; // Parameter to track selection

  const ServicesA({super.key, 
    required this.imgPath,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(), 
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          
          border: isSelected

              ? Border.all(
                
                color: Constant().primaryColor, width: 3.0) 
              : Border.all(color: Colors.transparent), 
          borderRadius: BorderRadius.circular(35.0), 
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 30.0, 
              child: Image.asset(imgPath),
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: GoogleFonts.manrope(
                fontSize: 14,
                color: isSelected ? const Color(0xff156778) : const Color(0xff156778), 
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
