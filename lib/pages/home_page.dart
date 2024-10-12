import 'dart:ui'; // For the ImageFilter class
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gc_gallery/controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
        
          Container(
            height: MediaQuery.of(context).size.height *
                0.35, // 25% of screen height
            decoration: BoxDecoration(
              color: Color.fromRGBO(200, 50, 34, 0.3),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
              ),
            ),
            child: PageView.builder(
              itemCount: homeController.classPhotos.length,
              controller: PageController(viewportFraction: 0.8),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Handle card click action
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 5), // Shadow position
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage(homeController.classPhotos[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // Remaining part of the screen with glassmorphic container
          Expanded(
            child: SingleChildScrollView(
              // This allows scrolling to prevent overflow
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Apply blur
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2), // Glassmorphic effect
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(32),
                    ),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCardSectionWithTopButton(
                        context,
                        title: 'Faculty Message',
                        content: homeController.facultyMessage.value,
                        onViewAllPressed: () {
                          // Handle View All press for Faculty Message
                        },
                      ),
                      // const SizedBox(height: 5),

                      // Two-column grid for Achievements and Events
                      GridView.builder(
                        shrinkWrap: true, // Allows it to fit inside the scroll
                        physics:
                            const NeverScrollableScrollPhysics(), // Disable scrolling for GridView
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Two columns
                          // crossAxisSpacing: 0, // Spacing between columns
                          // mainAxisSpacing: 0, // Spacing between rows
                          childAspectRatio: 1, // Adjust as per your design
                        ),
                        itemCount: 2, // Two items: Achievements and Events
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return _buildCardSectionWithBottomButton(
                              context,
                              title: 'Achievements',
                              content: homeController.achievements.join(', '),
                              onViewAllPressed: () {
                                // Handle View All press for Achievements
                              },
                            );
                          } else {
                            return _buildCardSectionWithBottomButton(
                              context,
                              title: 'Events',
                              content: homeController.events.join(', '),
                              onViewAllPressed: () {
                                // Handle View All press for Events
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Card section with View All button at the top-right for Faculty Message
  Widget _buildCardSectionWithTopButton(
    BuildContext context, {
    required String title,
    required String content,
    required VoidCallback onViewAllPressed,
  }) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16, // Smaller font size for the title
                    fontWeight: FontWeight.bold, // Optional: bold for emphasis
                  ),
                ),
                TextButton(
                  onPressed: onViewAllPressed,
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              content,
              style: const TextStyle(
                fontSize: 12, // Content font size
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Card section with View All button at the bottom-right for Achievements and Events
  Widget _buildCardSectionWithBottomButton(
    BuildContext context, {
    required String title,
    required String content,
    required VoidCallback onViewAllPressed,
  }) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14, // Smaller font size for the title
                fontWeight: FontWeight.bold, // Optional: bold for emphasis
              ),
            ),
            // const SizedBox(height: 5),
            Text(
              content,
              style: const TextStyle(
                fontSize: 12, // Content font size
              ),
            ),
            const Spacer(), // Push the button to the bottom
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: onViewAllPressed,
                child: const Text('View All'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
