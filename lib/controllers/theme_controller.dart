import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs; // Observable variable to track dark mode

  @override
  void onInit() {
    super.onInit();
    loadTheme(); // Load the saved theme when the controller initializes
  }

  void toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(isDarkMode.value ? ThemeData.dark() : ThemeData.light());
    await saveTheme(isDarkMode.value); // Save the theme preference
  }

  Future<void> saveTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDark);
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
    Get.changeTheme(isDarkMode.value ? ThemeData.dark() : ThemeData.light());
  }
}
