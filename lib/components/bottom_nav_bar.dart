import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:gc_gallery/controllers/navigation_controller.dart';

import 'package:gc_gallery/pages/gallery_page.dart';
import 'package:gc_gallery/pages/home_page.dart';
import 'package:gc_gallery/pages/settings_page.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final NavigationController navController = Get.put(NavigationController());
  final List<Widget> _pages = [
    HomeScreen(),
    StudentGallery(),
    VideoScreen(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: _pages[navController.selectedIndex.value],
        );
      }),
      bottomNavigationBar: Obx(() {
        return AnimatedBottomNavigationBar(
          icons: [
            Icons.home,
            Icons.photo,
            Icons.video_library,
            Icons.settings,
          ],
          activeIndex: navController.selectedIndex.value,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.smoothEdge,
          onTap: (index) {
            navController.changeIndex(index);
          },
          backgroundColor: Colors.blueAccent,
          inactiveColor: Colors.white,
          activeColor: Colors.yellow,
        );
      }),
    );
  }
}

class VideoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildScreen('Video Screen', Color.fromARGB(255, 199, 183, 162));
  }
}

// class SettingsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return _buildScreen('Settings Screen', Color.fromARGB(255, 161, 140, 112));
//   }
// }

Widget _buildScreen(String title, Color color) {
  return Container(
    color: color,
    child: Center(
      child: Text(
        title,
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ),
  );
}
