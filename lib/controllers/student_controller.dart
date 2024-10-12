import 'package:gc_gallery/models/student.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StudentController extends GetxController {
  var students = <Student>[].obs;
  var filteredStudents = <Student>[].obs; // To store filtered results

  @override
  void onInit() {
    super.onInit();
    loadStudents();
  }

  Future<void> loadStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final studentData = prefs.getString('students') ?? '[]';
    List<dynamic> studentList = json.decode(studentData);
    students.assignAll(
        studentList.map((student) => Student.fromMap(student)).toList());
    filteredStudents.assignAll(students);
  }

  void filterStudents(String query) {
    if (query.isEmpty) {
      // If no query, show all students
      filteredStudents.assignAll(students);
    } else {
      filteredStudents.assignAll(students.where((student) {
        return student.username.toLowerCase().contains(query.toLowerCase()) ||
            student.name.toLowerCase().contains(query.toLowerCase()) ||
            student.email.toLowerCase().contains(query.toLowerCase()) ||
            student.department.toLowerCase().contains(query.toLowerCase()) ||
            (student.quote != null &&
                student.quote!.toLowerCase().contains(
                    query.toLowerCase())); // Filter by quote if provided
      }).toList());
    }
  }

  void filterPhotos(String username) {
    filteredStudents.assignAll(
        students.where((student) => student.username == username).toList());
  }

  void addStudent(Student student) {
    students.add(student);
    _saveStudents();
    filterStudents(""); // Refresh the filter
  }

  void updateStudentInfo(String username, Student updatedStudent) {
    final studentIndex = students.indexWhere((s) => s.username == username);
    if (studentIndex != -1) {
      students[studentIndex] = updatedStudent; // Update student info
      _saveStudents();
      filterStudents(""); // Refresh the filter
    }
  }

  void updateStudentPhotos(String username, List<String> newPhotos) {
    final studentIndex = students.indexWhere((s) => s.username == username);
    if (studentIndex != -1) {
      students[studentIndex].photos = newPhotos; // Update photos
      _saveStudents();
      filterStudents(""); // Refresh the filter
    }
  }

  Future<void> _saveStudents() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonStudents = students
        .map((student) =>
            json.encode(student.toMap())) // Encode using toMap method
        .toList();
    await prefs.setString('students', json.encode(jsonStudents));
  }
}
