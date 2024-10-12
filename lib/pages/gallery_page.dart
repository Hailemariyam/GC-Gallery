import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class StudentController extends GetxController {
  RxList<Student> students = <Student>[
    Student(
      name: "John Doe",
      username: "john_doe",
      department: "Computer Science",
      quote: "Learning never stops",
      photos: {
        "passport": "assets/images/logo.jpeg",
        "fullscale": "assets/images/logo.jpeg",
      },
    ),
    // Add the new students here...
    Student(
      username: "jane_smith",
      name: "Jane Smith",
      department: "Mathematics",
      quote:
          "Mathematics is the language with which God has written the universe.",
      photos: {
        "passport": "assets/images/logo.jpeg",
        "fullscale": "assets/images/logo.jpeg",
      },
    ),
    Student(
      username: "mike_johnson",
      name: "Mike Johnson",
      department: "Physics",
      quote:
          "Physics is the science of matter, energy, and their interactions.",
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

class Student {
  final String name;
  final String username;
  final String department;
  final String quote;
  final Map<String, String> photos;

  Student({
    required this.name,
    required this.username,
    required this.department,
    required this.quote,
    required this.photos,
  });
}

class StudentGallery extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Gallery'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                studentController.filterStudents(value);
              },
              decoration: InputDecoration(
                labelText: 'Search by username, name, or department',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (studentController.isFullScreen.value) {
                // Full-screen view with swiping
                return GestureDetector(
                  onTap: () {
                    studentController.exitFullScreen();
                  },
                  child: PageView.builder(
                    itemCount: studentController.filteredStudents.length,
                    controller: PageController(
                      initialPage: studentController.currentIndex.value,
                    ),
                    onPageChanged: (index) {
                      studentController.currentIndex.value = index;
                    },
                    itemBuilder: (context, index) {
                      final student = studentController.filteredStudents[index];
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(student.photos['fullscale']!),
                            SizedBox(height: 10),
                            Text(student.name, style: TextStyle(fontSize: 24)),
                            SizedBox(height: 10), // Add some spacing
                            Center(
                              // Center the quote text
                              child: Text(
                                student.quote ?? '',
                                textAlign:
                                    TextAlign.center, // Center align text
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                // Grid view of student photos
                return GridView.builder(
                  itemCount: studentController.filteredStudents.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final student = studentController.filteredStudents[index];
                    return GestureDetector(
                      onTap: () {
                        studentController.setFullScreenStudent(index);
                      },
                      onLongPress: () {
                        studentController
                            .downloadImage(student.photos['passport']!);
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.asset(
                                student.photos['passport']!,
                                height: 100,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(student.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5), // Add some spacing
                                  Center(
                                    // Center the quote text
                                    child: Text(
                                      student.quote ?? '',
                                      textAlign:
                                          TextAlign.center, // Center align text
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
