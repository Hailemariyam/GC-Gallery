import 'package:flutter/material.dart';
import 'package:gc_gallery/controllers/student_controller.dart';
import 'package:get/get.dart';

class StudentGallery extends StatefulWidget {
  @override
  _StudentGalleryState createState() => _StudentGalleryState();
}

class _StudentGalleryState extends State<StudentGallery>
    with SingleTickerProviderStateMixin {
  final StudentController studentController = Get.put(StudentController());
  final TextEditingController searchController = TextEditingController();

  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController and the SlideTransition animation.
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from bottom
      end: Offset.zero, // End at its original position
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    // Start the animation
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Gallery'),
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
              decoration: const InputDecoration(
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
                            Hero(
                              tag: 'student-photo-${student.username}',
                              child: Image.asset(student.photos['fullscale']!,
                                  width: 300, height: 300, fit: BoxFit.cover),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              student.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              student.department,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Text(
                                student.quote,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontFamily: 'RobotoItalic',
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                // Grid view of student photos with Slide Animation
                return GridView.builder(
                    itemCount: studentController.filteredStudents.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.8,
                    ),
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
                        child: SlideTransition(
                          position:
                              _slideAnimation, // Apply the slide animation
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            elevation:
                                5, // Adds a shadow effect for better separation
                            child: Stack(
                              children: [
                                // Positioned widget behind the passport image
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                          color: Colors.white,
                                          width: 2), // Add border
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        student.photos['fullscale']!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),

                                // Passport image is on top
                                Column(
                                  children: [
                                    Expanded(
                                      child: Hero(
                                        tag:
                                            'student-photo-${student.username}',
                                        child: Image.asset(
                                          student.photos['passport']!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(student.name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 18)),
                                          const SizedBox(height: 5),
                                          Text(student.department,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey)),
                                          const SizedBox(height: 5),
                                          Center(
                                            child: Text(
                                              student.quote,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontFamily: 'RobotoItalic',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            }),
          ),
        ],
      ),
    );
  }
}
