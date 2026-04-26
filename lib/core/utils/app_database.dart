import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _database;

  Future<Database?> get db async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "plantshop.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Users table
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');

    // Extra data table
    await db.execute('''
      CREATE TABLE extra_data(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        age TEXT,
        bio TEXT
      )
    ''');

    // Profile image table
    await db.execute('''
      CREATE TABLE profile_images(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        image_path TEXT
      )
    ''');
  }

  // ========== USER OPERATIONS ==========

  Future<int> insertUser({
    required String name,
    required String email,
    required String password,
  }) async {
    Database? database = await db;
    return await database!.insert('users', {
      'name': name,
      'email': email,
      'password': password,
    });
  }

  Future<Map<String, dynamic>?> getUser() async {
    Database? database = await db;
    List<Map<String, dynamic>> result = await database!.query('users', limit: 1);
    if (result.isNotEmpty) return result.first;
    return null;
  }

  Future<bool> validateCredentials({
    required String email,
    required String password,
  }) async {
    Database? database = await db;
    List<Map<String, dynamic>> result = await database!.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty;
  }

  Future<int> deleteAllUsers() async {
    Database? database = await db;
    return await database!.delete('users');
  }

  // ========== EXTRA DATA OPERATIONS ==========

  Future<int> insertOrUpdateExtraData({
    required String age,
    required String bio,
  }) async {
    Database? database = await db;
    // Check if data exists
    List<Map<String, dynamic>> existing = await database!.query('extra_data', limit: 1);
    if (existing.isNotEmpty) {
      // Update
      return await database.update(
        'extra_data',
        {'age': age, 'bio': bio},
        where: 'id = ?',
        whereArgs: [existing.first['id']],
      );
    } else {
      // Insert
      return await database.insert('extra_data', {
        'age': age,
        'bio': bio,
      });
    }
  }

  Future<Map<String, dynamic>?> getExtraData() async {
    Database? database = await db;
    List<Map<String, dynamic>> result = await database!.query('extra_data', limit: 1);
    if (result.isNotEmpty) return result.first;
    return null;
  }

  // ========== PROFILE IMAGE OPERATIONS ==========

  Future<int> insertOrUpdateProfileImage(String imagePath) async {
    Database? database = await db;
    List<Map<String, dynamic>> existing = await database!.query('profile_images', limit: 1);
    if (existing.isNotEmpty) {
      return await database.update(
        'profile_images',
        {'image_path': imagePath},
        where: 'id = ?',
        whereArgs: [existing.first['id']],
      );
    } else {
      return await database.insert('profile_images', {
        'image_path': imagePath,
      });
    }
  }

  Future<String?> getProfileImage() async {
    Database? database = await db;
    List<Map<String, dynamic>> result = await database!.query('profile_images', limit: 1);
    if (result.isNotEmpty) return result.first['image_path'] as String?;
    return null;
  }

  // ========== CLEAR ALL ==========

  Future<void> clearAll() async {
    Database? database = await db;
    await database!.delete('users');
    await database.delete('extra_data');
    await database.delete('profile_images');
  }
}
