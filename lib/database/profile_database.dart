import 'package:firstdemo/database/user_data.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'profile.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE profiles(employeeId TEXT PRIMARY KEY, name TEXT, position TEXT, contactNo TEXT, emergencyContact TEXT, dob TEXT, bloodType TEXT, appointedDate TEXT, panNo TEXT, imageUrl TEXT)',
        );
      },
    );
  }

  Future<void> insertProfile(Profile profile) async {
    final db = await database;
    await db.insert(
      'profiles',
      profile.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Profile?> getProfile(String employeeId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'profiles',
      where: 'employeeId = ?',
      whereArgs: [employeeId],
    );

    if (maps.isNotEmpty) {
      return Profile.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updateProfile(Profile profile) async {
    final db = await database;
    await db.update(
      'profiles',
      profile.toMap(),
      where: 'employeeId = ?',
      whereArgs: [profile.employeeId],
    );
  }

  Future<void> deleteProfile(String employeeId) async {
    final db = await database;
    await db.delete(
      'profiles',
      where: 'employeeId = ?',
      whereArgs: [employeeId],
    );
  }
}
