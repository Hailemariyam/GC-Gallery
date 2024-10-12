import 'package:flutter/material.dart';
import 'package:gc_gallery/controllers/theme_controller.dart';
import 'package:gc_gallery/components/bottom_nav_bar.dart';
import 'package:get/get.dart';

void main() {
  // Register the ThemeController
  Get.put(ThemeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Use GetMaterialApp for GetX features
      title: 'GC Gallery',
      theme: ThemeData.light(), // Light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode:
          ThemeMode.system, // Automatically switch based on device settings
      home: HomePage(),
    );
  }
}
