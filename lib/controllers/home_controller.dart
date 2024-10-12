import 'package:get/get.dart';

class HomeController extends GetxController {
  // Class Photos
  var classPhotos = [].obs;

  // Achievements
  var achievements = [].obs;

  // Events
  var events = [].obs;

  // Message from Faculty
  var facultyMessage = "Congratulations to the Class of 2024!".obs;

  @override
  void onInit() {
    super.onInit();
    // Load data here (e.g., fetch from a server or local storage)
    loadClassPhotos();
    loadAchievements();
    loadEvents();
    loadFacultyMessage();
  }

  void loadClassPhotos() {
    // Add sample photos
    classPhotos.value = [
      'assets/images/logo.jpeg',
      'assets/images/splash_bg.jpeg',
      'assets/images/logo.jpeg',
      // Add more paths to images
    ];
  }

  void loadAchievements() {
    achievements.value = [
      'Excellence in Research and Innovation',
    ];
  }

  void loadEvents() {
    events.value = [
      'Class Sports Event',
    ];
  }

  void loadFacultyMessage() {
    facultyMessage.value =
        "Congratulations to the Class of 2024! You've demonstrated resilience, excellence, and dedication in your academic journey. We're proud to have you as graduates of Wollo University!";
  }
}
