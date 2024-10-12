class Student {
  String username;
  String name;
  String email;
  String department;
  List<String> photos; // Store paths to photos (optional)
  String? quote; // Optional quote field

  Student({
    required this.username,
    required this.name,
    required this.email,
    required this.department,
    List<String>? photos, // Make photos optional
    this.quote, // Optional quote
  }) : photos = photos ?? []; // Initialize with an empty list if not provided

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'name': name,
      'email': email,
      'department': department,
      'photos': photos,
      'quote': quote, // Add quote to map
    };
  }

  static Student fromMap(Map<String, dynamic> map) {
    return Student(
      username: map['username'],
      name: map['name'],
      email: map['email'],
      department: map['department'],
      photos: List<String>.from(map['photos'] ?? []), // Handle empty case
      quote: map['quote'], // Add quote from map
    );
  }
}
