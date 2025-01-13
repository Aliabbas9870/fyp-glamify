import 'package:get/get.dart';

class ServiceController extends GetxController {
  var selectedService = "Haircut".obs;

  // Updated data structure for detailed categories
  final Map<String, Map<String, dynamic>> serviceDetails = {
    "Haircut": {
      "categories": ["Nikkah Haircut", "Party Haircut", "Uni Haircut"],
      "images": [
        "assets/images/service/hr1.jpg",
        "assets/images/service/hr2.jpg",
        "assets/images/service/hr7.jpg",
      ],
      "prices": [500, 600, 700],
      "description": "Professional haircut styles tailored to your preference.",
    },
    "Facial": {
      "categories": ["Gold Facial", "Silver Facial", "Charcoal Facial"],
      "images": [
        "assets/images/service/fac4.jpg",
        "assets/images/service/fac3.jpg",
        "assets/images/service/fac1.jpg",
      ],
      "prices": [1500, 1600, 1800],
      "description": "Relaxing facial treatments for glowing skin.",
    },
    "Nails": {
      "categories": ["French Manicure", "Gel Polish", "Classic Pedicure"],
      "images": [
        "assets/images/service/nn1.jpg",
        "assets/images/service/nn2.jpg",
        "assets/images/service/nn3.jpg",
      ],
      "prices": [800, 900, 1100],
      "description": "Manicure and pedicure services for beautiful nails.",
    },
     "Waxing": {
      "categories": ["Gold Waxing", "Silver Waxing", "Charcoal Waxing"],
      "images": [
        "assets/images/service/fac4.jpg",
        "assets/images/service/fac3.jpg",
        "assets/images/service/fac1.jpg",
      ],
      "prices": [1500, 1600, 1800],
      "description": "Relaxing facial treatments for glowing skin.",
    },


  };

  final List<Map<String, String>> services = [
    {"title": "Haircut", "imgPath": "assets/images/hr.png"},
    {"title": "Facial", "imgPath": "assets/images/facial.png"},
    {"title": "Nails", "imgPath": "assets/images/nail.png"},
    {"title": "Waxing", "imgPath": "assets/images/facial.png"},
    // {"title": "Nails", "imgPath": "assets/images/nail.png"},
  ];

  void updateSelectedService(String service) {
    selectedService.value = service;
  }
}
