import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:glamify/controller/themeController.dart';
import 'package:glamify/widgets/constant.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; // For timestamp

class AssistantBotMan extends StatefulWidget {
  const AssistantBotMan({super.key});

  // final String message;
  // const AssistantBot({required this.message});

  @override
  _AssistantBotManState createState() => _AssistantBotManState();
}

class _AssistantBotManState extends State<AssistantBotMan> {
  final ThemeController themeController = Get.put(ThemeController());
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;
  final Constant constant = Constant();

  final List<Map<String, dynamic>> _initialMessages = [
    {
      'message': 'Hello! How can I assist you?',
      'isBot': true,
      'time': DateTime.now(),
    },
    {
      'message': 'What do you need help with?',
      'isBot': true,
      'time': DateTime.now(),
    },
    {
      'message': 'Ask me anything about salons, services, or bookings.',
      'isBot': true,
      'time': DateTime.now(),
    },
  ];
  @override
  void initState() {
    super.initState();
    _messages.addAll(_initialMessages);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _messages.add({
          'message': 'Image selected',
          'isBot': false,
          'imagePath': pickedFile.path,
          'time': DateTime.now(),
        });
        _isLoading = true;
      });
      _scrollToBottom();

      // Call image processing function
      await _processImage(File(pickedFile.path));
    }
  }

   String _detectGender(Face face) {
    // gender detection logic or API 
    return 'male' ; 
  }
String _analyzeFace(Face face) {
  double aspectRatio = face.boundingBox.width / face.boundingBox.height;
  String faceShape;
  
 if (aspectRatio > 1.0) {
    faceShape = 'round';
  } else if (aspectRatio <= 1.0) {
    faceShape = 'oblong';
  } else if (aspectRatio > 1.1 && aspectRatio <= 1.9) {
    faceShape = 'oval';
  } else {
    faceShape = 'undefined'; 
  }

  String gender = _detectGender(face);

  String additionalInfo = '';
  if (face.smilingProbability != null) {
    additionalInfo +=
        'Smile detected: ${(face.smilingProbability! * 100).toStringAsFixed(1)}%\n';
  }
  if (face.leftEyeOpenProbability != null &&
      face.rightEyeOpenProbability != null) {
    additionalInfo +=
        'Left eye open: ${(face.leftEyeOpenProbability! * 100).toStringAsFixed(1)}%\n';
    additionalInfo +=
        'Right eye open: ${(face.rightEyeOpenProbability! * 100).toStringAsFixed(1)}%\n';
  }

  // Provide beauty tips based on face type and gender
  String tips = _getBeautyTips(faceShape, gender);

  return 'Your face type appears to be $faceShape.\n$additionalInfo$tips';
}



String _getBeautyTips(String faceShape, String gender) {
  String tips = '\nBeauty tips for $faceShape face:\n';

  Random random = Random();
  int percentageOval = random.nextInt(20) + 18; 
  int percentageOblong = random.nextInt(20) + 14;
  int percentageRound = random.nextInt(20) + 15; // Percentage for round face

  if (gender == 'male') {
    if (faceShape == 'oval') {
      // Oval face tips for males
      List<String> ovalTips = [
        '- Highlight your cheekbones to emphasize balance and symmetry.\n',
        '- Layered cuts or side parts can add a modern, stylish touch.\n',
        '- Use wavy hairstyles to balance out face length and width.\n',
        '- A well-groomed beard can add definition and balance to the oval face shape.\n',
        '- Consider a short, neatly trimmed beard to highlight your face shape.\n',
        '- Keep the beard clean and neat to maintain a sharp appearance.\n',
      ];
      tips += ovalTips[random.nextInt(ovalTips.length)];
      tips += ovalTips[random.nextInt(ovalTips.length)];
      tips += ovalTips[random.nextInt(ovalTips.length)];
      tips += 'Your face needs $percentageOval% improvement to bring out its natural symmetry.\n';
    } else if (faceShape == 'oblong') {
      // Oblong face tips for males
      List<String> oblongTips = [
        '- Shoulder-length wavy cuts can soften face length.\n',
        '- Use blush to add width and balance your cheeks.\n',
        '- Bangs can create the illusion of a shorter face.\n',
        '- Horizontal waves add volume and proportion to your hair.\n',
        '- A full beard with volume on the sides can help balance the length of your face.\n',
        '- Avoid a long beard that extends too far down; a more sculpted beard suits oblong faces.\n',
        '- A beard with sharp edges can bring out the angularity of your face.\n',
      ];
      tips += oblongTips[random.nextInt(oblongTips.length)];
      tips += oblongTips[random.nextInt(oblongTips.length)];
      tips += oblongTips[random.nextInt(oblongTips.length)];
      tips += 'Your face needs $percentageOblong% focus to balance its elongated features.\n';
    } else if (faceShape == 'round') {
      // Round face tips for males
      List<String> roundTips = [
        '- Try hairstyles that add height, like pompadours, to elongate your face.\n',
        '- Avoid hairstyles with rounded edges or too much volume on the sides.\n',
        '- A well-trimmed beard with sharp lines can add definition to your jawline.\n',
        '- Angular and sculpted beard styles help create a more defined look.\n',
        '- Avoid full beards that add extra roundness to your face.\n',
        '- Glasses with rectangular or angular frames balance out round features.\n',
        '- Opt for high fades or undercuts to add structure to your appearance.\n',
        '- Highlight your jawline with contouring techniques for a sharper look.\n',
      ];
      tips += roundTips[random.nextInt(roundTips.length)];
      tips += roundTips[random.nextInt(roundTips.length)];
      tips += roundTips[random.nextInt(roundTips.length)];
      tips += 'Your face needs $percentageRound% focus to emphasize its best features.\n';
    }
  }

  return tips;
}

  Future<void> _processImage(File imageFile) async {
    final GoogleVisionImage visionImage = GoogleVisionImage.fromFile(imageFile);
    final FaceDetector faceDetector = GoogleVision.instance.faceDetector();
    final List<Face> faces = await faceDetector.processImage(visionImage);

    String response = 'Could not detect any faces in the image.';

    if (faces.isNotEmpty) {
    
      Face face = faces.first;
      response = _analyzeFace(face);

      // Add suggestions based on the detected face
      // response += '\nSuggested haircuts and beauty tips based on your face type!';
    }

    setState(() {
      _messages.add({
        'message': response,
        'isBot': true,
        'time': DateTime.now(),
      });
      _isLoading = false;
    });

    _scrollToBottom();
  }



  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Image Source"),
          actions: [
            Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.camera),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                      child: const Text("Camera"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.photo_library),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                      child: const Text("Gallery"),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _getResponse() async {
    String query = _controller.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _messages.add({
        'message': query,
        'isBot': false,
        'time': DateTime.now(),
      });
      _isLoading = true;
      _controller.clear();
    });
    _scrollToBottom();

    try {
      final gemini = Gemini.instance;

     
      final value = await gemini.text(query);
      String response =
          value?.output ?? 'Sorry, I could not process your request.';

      // Update state with the response message
      setState(() {
        _messages.add({
          'message': response,
          'isBot': true,
          'time': DateTime.now(),
        });
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _messages.add({
          'message': 'Error fetching response: ${e.toString()}',
          'isBot': true,
          'time': DateTime.now(),
        });
        _isLoading = false;
      });
    }

    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(right: 11.0, left: 4),
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios, color: constant.primaryColor)),
                const SizedBox(width: 6),
                const CircleAvatar(child: Icon(Icons.person)),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Assistant',
                      style: TextStyle(
                          color: constant.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'online',
                      style: TextStyle(
                          color: constant.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          elevation: 5,
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert_sharp, size: 30, color: Colors.blue),
              onSelected: (value) {
                if (value == 'Change Theme') {
                  themeController
                      .toggleTheme(); // Call GetX method to change theme
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Change Theme',
                  child: Text('Change Theme'),
                ),
              ],
            ),
          ]),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isBot = message['isBot'] as bool;
                final timestamp = DateFormat('hh:mm a').format(message['time']);

                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Delete Message"),
                        content: const Text(
                            "Are you sure you want to delete this message?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _messages.removeAt(index);
                              });
                              Navigator.pop(context);
                            },
                            child: const Text("Delete"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Align(
                    alignment:
                        isBot ? Alignment.centerLeft : Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: isBot
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      children: [
                        if (message.containsKey('imagePath'))
                          Align(
                            alignment: isBot
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(message['imagePath']),
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        else
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10),
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: isBot
                                  ? const Color.fromARGB(255, 231, 229, 229)
                                  : constant.primaryColor,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message['message'] ?? '',
                                  style: TextStyle(
                                      color:
                                          isBot ? Colors.black : Colors.white),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  timestamp,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isBot
                                        ? const Color.fromARGB(255, 99, 96, 96)
                                        : const Color.fromARGB(255, 203, 199, 199),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            SpinKitThreeBounce(color: constant.primaryColor, size: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: _showImageSourceDialog,
                  icon: Icon(Icons.image, color: constant.primaryColor),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _getResponse(),
                    decoration: InputDecoration(
                      hintText: "Ask your question",
                      hintStyle: TextStyle(
                        color: constant.primaryColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: constant.primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: constant.primaryColor),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _getResponse,
                  icon: Icon(Icons.send, color: constant.primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
