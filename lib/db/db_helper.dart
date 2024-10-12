import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'gallery.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            department TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE photos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            student_id INTEGER,
            photo_path TEXT NOT NULL,
            photo_number INTEGER NOT NULL,
            FOREIGN KEY (student_id) REFERENCES students (id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }

  // Insert a student
  Future<void> insertStudent(Map<String, dynamic> student) async {
    final db = await database;
    await db.insert('students', student);
  }

  // Insert a photo
  Future<void> insertPhoto(Map<String, dynamic> photo) async {
    final db = await database;
    await db.insert('photos', photo);
  }

  // Retrieve all students
  Future<List<Map<String, dynamic>>> getAllStudents() async {
    final db = await database;
    return await db.query('students');
  }

  // Retrieve students filtered by department
  Future<List<Map<String, dynamic>>> getStudentsByDepartment(
      String department) async {
    final db = await database;
    return await db
        .query('students', where: 'department = ?', whereArgs: [department]);
  }

  // Retrieve photos by student ID
  Future<List<Map<String, dynamic>>> getPhotosByStudentId(int studentId) async {
    final db = await database;
    return await db
        .query('photos', where: 'student_id = ?', whereArgs: [studentId]);
  }

  // Retrieve all photos
  Future<List<Map<String, dynamic>>> getAllPhotos() async {
    final db = await database;
    return await db.query('photos');
  }
}
