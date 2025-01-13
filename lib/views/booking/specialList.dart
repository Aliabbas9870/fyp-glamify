import 'package:flutter/material.dart';
import 'package:glamify/widgets/constant.dart';
// import 'package:fypapp/widgets/constant.dart';

class SpecialListWidgetBok extends StatefulWidget {
  final String imgPath;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SpecialListWidgetBok({super.key, 
    required this.imgPath,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  _SpecialListWidgetBokState createState() => _SpecialListWidgetBokState();
}

class _SpecialListWidgetBokState extends State<SpecialListWidgetBok> {
  final Constant constant = Constant();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, // Call the passed onTap function
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          width: 133,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(75),
            border: widget.isSelected
                ? Border.all(color: constant.primaryColor, width: 3)
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 90,
                    height: 89,
                    child: Stack(
                      children: [
                        ColorFiltered(
                          colorFilter: widget.isSelected
                              ? ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.srcATop)
                              : const ColorFilter.mode(
                                  Colors.transparent, BlendMode.multiply),
                          child: Image.asset(widget.imgPath,
                              height: 89, width: 80, fit: BoxFit.cover),
                        ),
                        if (widget.isSelected)
                          const Positioned(
                            right: 8,
                            top: 8,
                            child: Icon(Icons.check_circle,
                                color: Colors.green, size: 24),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 120,
                  child: Text(
                    widget.title,
                    style: const TextStyle(fontSize: 17),
                    textAlign: TextAlign.center,
                    softWrap: true,
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
