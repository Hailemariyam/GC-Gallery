import 'package:flutter/material.dart';
import 'package:gc_gallery/controllers/student_controller.dart';
import 'package:gc_gallery/models/student.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StudentPage extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());
  final TextEditingController _searchController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>(); // Key for the form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Gallery')),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: (value) {
              studentController.filterStudents(value);
            },
            decoration: InputDecoration(labelText: 'Search'),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: studentController.filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = studentController.filteredStudents[index];
                  return ListTile(
                    title: Text(student.name),
                    subtitle: Text(student.email),
                    onTap: () {
                      _showUpdateStudentDialog(student);
                    },
                  );
                },
              );
            }),
          ),
          ElevatedButton(
            onPressed: _showAddStudentDialog,
            child: Text('Add Student'),
          ),
        ],
      ),
    );
  }

  void _showAddStudentDialog() {
    final usernameController = TextEditingController();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final departmentController = TextEditingController();
    final quoteController = TextEditingController(); // Added for quote input
    List<String> photos = []; // List to store selected photo paths

    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Student'),
          content: Form(
            key: _formKey, // Attach form key
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null; // Validation passed
                  },
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null; // Validation passed
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null; // Validation passed
                  },
                ),
                TextFormField(
                  controller: departmentController,
                  decoration: InputDecoration(labelText: 'Department'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a department';
                    }
                    return null; // Validation passed
                  },
                ),
                TextFormField(
                  controller: quoteController, // New text field for quote
                  decoration: InputDecoration(labelText: 'Quote'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _pickImageForNewStudent(photos),
                  child: Text('Upload Photo'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Validate form
                  final newStudent = Student(
                    username: usernameController.text,
                    name: nameController.text,
                    email: emailController.text,
                    department: departmentController.text,
                    photos: photos, // Store selected photo paths
                    quote: quoteController.text, // Add quote
                  );
                  studentController.addStudent(newStudent);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateStudentDialog(Student student) {
    final usernameController = TextEditingController(text: student.username);
    final nameController = TextEditingController(text: student.name);
    final emailController = TextEditingController(text: student.email);
    final departmentController =
        TextEditingController(text: student.department);
    final quoteController = TextEditingController(
        text: student.quote ?? ''); // New controller for quote
    List<String> updatedPhotos =
        List.from(student.photos); // Create a mutable copy

    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Student'),
          content: Form(
            key: _formKey, // Attach form key
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null; // Validation passed
                  },
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null; // Validation passed
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null; // Validation passed
                  },
                ),
                TextFormField(
                  controller: departmentController,
                  decoration: InputDecoration(labelText: 'Department'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a department';
                    }
                    return null; // Validation passed
                  },
                ),
                TextFormField(
                  controller: quoteController, // New text field for quote
                  decoration: InputDecoration(labelText: 'Quote'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _pickImageForUpdate(updatedPhotos),
                  child: Text('Upload New Photo'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Validate form
                  final updatedStudent = Student(
                    username: usernameController.text,
                    name: nameController.text,
                    email: emailController.text,
                    department: departmentController.text,
                    photos: updatedPhotos, // Use updated photos list
                    quote: quoteController.text, // Update quote
                  );
                  studentController.updateStudentInfo(
                      student.username, updatedStudent);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImageForNewStudent(List<String> photos) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photos.add(pickedFile.path); // Add photo path to the list
      Get.snackbar('Success', 'Photo uploaded: ${pickedFile.path}',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _pickImageForUpdate(List<String> photos) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photos.add(pickedFile.path); // Add photo path to the list
      Get.snackbar('Success', 'Photo uploaded: ${pickedFile.path}',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
