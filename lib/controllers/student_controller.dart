import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:gc_gallery/models/student.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class StudentController extends GetxController {
  RxList<Student> students = <Student>[
    Student(
      name: "Hailemariyam Kebede",
      username: "WOUR/1000/12",
      department: "Software Engineering",
      quote: "Learning never stops",
      photos: {
        "passport": "assets/images/logo.jpeg",
        "fullscale": "assets/images/splash_bg.jpeg",
      },
    ),
    // Add the new students here...
    Student(
      username: "WOUR/1028/12",
      name: "Haregewoyn Menberu",
      department: "Software Engineering",
      quote: "ድንግልን ይዞ እረጅም ጉዞ።",
      photos: {
        "passport": "assets/images/logo.jpeg",
        "fullscale": "assets/images/logo.jpeg",
      },
    ),
    Student(
      username: "WOUR/1746/12",
      name: "Sewmehon Engda",
      department: "Software Engineering",
      quote: "ፍለጋው ንጹህ ለሆነ ለእግዚአብሔር ምስጋና ይገባል።",
      photos: {
        "passport": "assets/images/logo.jpeg",
        "fullscale": "assets/images/logo.jpeg",
      },
    ),
  ].obs;

  RxBool isFullScreen = false.obs;
  RxInt currentIndex = 0.obs; // To keep track of the selected image index
  Student? selectedStudent;
  RxList<Student> filteredStudents = <Student>[].obs;

  @override
  void onInit() {
    filteredStudents.assignAll(students);
    super.onInit();
  }

  void filterStudents(String query) {
    if (query.isEmpty) {
      filteredStudents.assignAll(students);
    } else {
      filteredStudents.assignAll(students.where((student) {
        return student.name.toLowerCase().contains(query.toLowerCase()) ||
            student.username.toLowerCase().contains(query.toLowerCase()) ||
            student.department.toLowerCase().contains(query.toLowerCase());
      }).toList());
    }
  }

  void setFullScreenStudent(int index) {
    currentIndex.value = index; // Set the selected index
    isFullScreen.value = true; // Enable full-screen mode
  }

  void exitFullScreen() {
    isFullScreen.value = false;
  }

  Future<void> downloadImage(String assetPath) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        final ByteData byteData = await rootBundle.load(assetPath);
        final Uint8List bytes = byteData.buffer.asUint8List();
        final result = await ImageGallerySaver.saveImage(bytes);
        if (result != null) {
          Get.snackbar('Download Complete', 'Image saved to your device.');
        } else {
          Get.snackbar('Error', 'Failed to save image.');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to load or save the image.');
      }
    } else {
      Get.snackbar('Permission Denied', 'Storage permission is required.');
    }
  }
}
