import 'package:flutter/material.dart';
import 'package:glamify/widgets/constant.dart';


class SearchInterest extends StatelessWidget {
  final String imgPath;
  final String title;

  const SearchInterest({super.key, required this.imgPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 133,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: const Color(0xffE1F5FA)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(imgPath),
            // SizedBox(width: 5,),
            Text(title)
          ],
        ),
      ),
    );
  }
}




class ServiceMenueWidF extends StatefulWidget {
  final String imgPath;
  final String title;
  final VoidCallback onTap;  // Add the onTap callback

  const ServiceMenueWidF({super.key, required this.imgPath, required this.title, required this.onTap});  // Constructor updated

  @override
  _ServiceMenueWidFState createState() => _ServiceMenueWidFState();
}

class _ServiceMenueWidFState extends State<ServiceMenueWidF> {
  final Constant constant = Constant();

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onTap();  // Call the onTap callback passed from the parent widget
      },
      child: Container(
        width: 133,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? constant.whiteC : const Color(0xffE1F5FA),
          border: isSelected ? Border.all(color: constant.primaryColor, width: 2) : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(widget.imgPath),
              Text(widget.title),
            ],
          ),
        ),
      ),
    );
  }
}



class ServiceMenueWid extends StatefulWidget {
  final String imgPath;
  final String title;

  const ServiceMenueWid({super.key, required this.imgPath, required this.title});

  @override
  _ServiceMenueWidState createState() => _ServiceMenueWidState();
}

class _ServiceMenueWidState extends State<ServiceMenueWid> {
  final Constant constant = Constant();

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        width: 133,
      decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  color: isSelected ? constant.whiteC : const Color(0xffE1F5FA),
  border: isSelected ? Border.all(color: constant.primaryColor, width: 2) : null, // Add border when selected
),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(widget.imgPath),
              Text(widget.title),
            ],
          ),
        ),
      ),
    );
  }
}
