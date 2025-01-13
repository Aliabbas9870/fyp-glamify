import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamify/controller/ServiceController.dart';
import 'package:glamify/widgets/service_menue_widget.dart';
import 'package:glamify/widgets/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceMenue extends StatelessWidget {
  final ServiceController controller = Get.put(ServiceController());

  ServiceMenue({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            // AppBar Section
            Padding(
              padding: const EdgeInsets.only(top: 45.0, left: 4.0, bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.teal),
                  ),
                  Text(
                    "Service Menu",
                    style: GoogleFonts.manrope(
                      fontSize: 18,
                      color: const Color(0xff156778),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
            ),
            const Divider(),
            // Horizontal Service Selector
            SizedBox(
              height: 102,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.services.map(
                    (service) {
                      return Row(
                        children: [
                          ServicesA(
                            imgPath: service["imgPath"]!,
                            title: service["title"]!,
                            onTap: () => controller.updateSelectedService(service["title"]!),
                            isSelected: controller.selectedService.value == service["title"],
                          ),
                          const SizedBox(width: 8),
                        ],
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            // Selected Service Details
            if (controller.selectedService.value.isNotEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${controller.selectedService.value} Services",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.serviceDetails[controller.selectedService.value]?["categories"]?.length ?? 0,
                          itemBuilder: (context, index) {
                            final service = controller.selectedService.value;
                            final categories = controller.serviceDetails[service]?["categories"] ?? [];
                            final images = controller.serviceDetails[service]?["images"] ?? [];
                            final prices = controller.serviceDetails[service]?["prices"] ?? [];
                            final description = controller.serviceDetails[service]?["description"] ?? "No description available";

                            final category = categories[index];
                            final imgPath = (index < images.length) ? images[index] : "assets/images/default.png";
                            final price = (index < prices.length) ? "PKR ${prices[index]}" : "PKR N/A";

                            return ServiceMenueWidget(
                              title: category,
                              img: imgPath,
                              price: price,
                              desc: description,
                            
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}