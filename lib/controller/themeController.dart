import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs; //us

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(
      isDarkMode.value ? ThemeData.dark() : ThemeData.light(),
    );
  }
}
