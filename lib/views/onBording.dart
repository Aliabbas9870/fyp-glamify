import 'package:flutter/material.dart';
import 'package:glamify/auth/login_auth.dart';
import 'package:glamify/views/onBording_what.dart';
import 'package:glamify/widgets/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBording extends StatefulWidget {
  const OnBording({super.key});

  @override
  _OnBordingStartState createState() => _OnBordingStartState();
}

class _OnBordingStartState extends State<OnBording> {
  final Constant constant = Constant();

  int _currentIndex = 0;
  final List<String> _images = [
    'assets/images/on00.png',
    'assets/images/on11.png',
    'assets/images/on31.png',
  ];

  void _nextImage() {
    setState(() {
      if (_currentIndex < _images.length - 1) {
        _currentIndex = (_currentIndex + 1) % _images.length;
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (c) => const OnBordingwhat()));
      }
    });
  }

  void _previousImage() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex = (_currentIndex - 1) % _images.length;
      } else {
        _currentIndex = _images.length - 1; 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
          // User swiped left
          _nextImage();
        } else if (details.primaryVelocity != null &&
            details.primaryVelocity! > 0) {
          // User swiped right
          _previousImage();
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_images[_currentIndex]),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Colors.black87.withOpacity(0.5),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 142,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 110,
                    ),
                    const Text(
                      "Beauty Redefined",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "Discover a new level of beauty with our products.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                // Indicator
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_images.length, (index) {
                    bool isSelected = _currentIndex == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      width: isSelected ? 24.0 : 12.0,
                      height: 12.0,
                      decoration: BoxDecoration(
                        shape:
                            isSelected ? BoxShape.rectangle : BoxShape.circle,

                          //  isSelected  ? BorderRadius.circular(6.0)
                          //   : null,
                        color: isSelected
                            ? constant.secondColor
                            : Colors.white.withOpacity(0.5),
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 57,
                ),
                ElevatedButton(
                  onPressed: _nextImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: constant.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    _currentIndex == _images.length - 1
                        ? 'Get Started'
                        : 'Next ',
                    style: GoogleFonts.manrope(
                      color: constant.whiteC,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
                        style: GoogleFonts.manrope(
                          color: constant.whiteC,
                          fontSize: 16,
                        )),
                    TextButton(
                      onPressed: () {
                        
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (c) => const LoginAuth()));
                      },
                      child: Text(
                        "Sign in",
                        style: GoogleFonts.manrope(
                            color: constant.secondColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
