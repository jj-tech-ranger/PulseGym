import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pulsegym.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // Create User table
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password_hash TEXT NOT NULL,
        gender TEXT,
        age INTEGER,
        weight REAL,
        height REAL,
        activity_level TEXT,
        goal TEXT,
        created_at TEXT NOT NULL
      )
    ''');

    // Create Reminders table
    await db.execute('''
      CREATE TABLE reminders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        time TEXT NOT NULL,
        is_active INTEGER NOT NULL DEFAULT 1,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    // Create Favorites table for saving workouts
    await db.execute('''
      CREATE TABLE favorites (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        workout_id TEXT NOT NULL,
        workout_name TEXT NOT NULL,
        created_at TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');
  }

  // User operations
  Future<int> createUser(Map<String, dynamic> user) async {
    final db = await database;
    user['password_hash'] = _hashPassword(user['password_hash']);
    user['created_at'] = DateTime.now().toIso8601String();
    return await db.insert('users', user);
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> getUserById(int id) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<bool> validateLogin(String email, String password) async {
    final db = await database;
    final hashedPassword = _hashPassword(password);
    final maps = await db.query(
      'users',
      where: 'email = ? AND password_hash = ?',
      whereArgs: [email, hashedPassword],
    );

    return maps.isNotEmpty;
  }

  // Reminder operations
  Future<int> createReminder(Map<String, dynamic> reminder) async {
    final db = await database;
    return await db.insert('reminders', reminder);
  }

  Future<List<Map<String, dynamic>>> getReminders(int userId) async {
    final db = await database;
    return await db.query(
      'reminders',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  Future<int> updateReminder(int id, Map<String, dynamic> reminder) async {
    final db = await database;
    return await db.update(
      'reminders',
      reminder,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteReminder(int id) async {
    final db = await database;
    return await db.delete(
      'reminders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Favorites operations
  Future<int> addFavorite(int userId, String workoutId, String workoutName) async {
    final db = await database;
    return await db.insert('favorites', {
      'user_id': userId,
      'workout_id': workoutId,
      'workout_name': workoutName,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getFavorites(int userId) async {
    final db = await database;
    return await db.query(
      'favorites',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  Future<int> removeFavorite(int userId, String workoutId) async {
    final db = await database;
    return await db.delete(
      'favorites',
      where: 'user_id = ? AND workout_id = ?',
      whereArgs: [userId, workoutId],
    );
  }

  // Helper methods
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  // Fix updateUser to accept Map instead of User object
  Future<int> updateUserData(int userId, Map<String, dynamic> data) async {
    final db = await database;
    return await db.update(
      'users',
      data,
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  // Debug: Print all users
  Future<void> debugPrintAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> users = await db.query('users');
    
    print('═══════════════════════════════════════');
    print('📊 DATABASE USERS (${users.length} total)');
    print('═══════════════════════════════════════');
    
    if (users.isEmpty) {
      print('⚠️  No users found in database');
    } else {
      for (var user in users) {
        print('');
        print('👤 USER ID: ${user['id']}');
        print('   Name: ${user['name']}');
        print('   Email: ${user['email']}');
        print('   Gender: ${user['gender']}');
        print('   Age: ${user['age']} years');
        print('   Weight: ${user['weight']} kg');
        print('   Height: ${user['height']} cm');
        print('   Goal: ${user['goal']}');
        print('   Activity Level: ${user['activity_level']}');
        print('   Created: ${user['created_at']}');
        print('   ─────────────────────────────────');
      }
    }
    
    print('═══════════════════════════════════════\n');
  }

  // Debug: Print all reminders
  Future<void> debugPrintAllReminders() async {
    final db = await database;
    final List<Map<String, dynamic>> reminders = await db.query('reminders');
    
    print('═══════════════════════════════════════');
    print('⏰ DATABASE REMINDERS (${reminders.length} total)');
    print('═══════════════════════════════════════');
    
    if (reminders.isEmpty) {
      print('⚠️  No reminders found in database');
    } else {
      for (var reminder in reminders) {
        print('');
        print('🔔 REMINDER ID: ${reminder['id']}');
        print('   User ID: ${reminder['user_id']}');
        print('   Title: ${reminder['title']}');
        print('   Time: ${reminder['time']}');
        print('   Active: ${reminder['is_active'] == 1 ? '✅ Yes' : '❌ No'}');
        print('   ─────────────────────────────────');
      }
    }
    
    print('═══════════════════════════════════════\n');
  }

  // Get database statistics
  Future<Map<String, dynamic>> getDatabaseStats() async {
    final db = await database;
    
    final userCount = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM users')
    ) ?? 0;
    
    final reminderCount = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM reminders')
    ) ?? 0;
    
    final activeReminders = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM reminders WHERE is_active = 1')
    ) ?? 0;
    
    return {
      'total_users': userCount,
      'total_reminders': reminderCount,
      'active_reminders': activeReminders,
    };
  }

  // Clear all users (for testing)
  Future<void> clearAllUsers() async {
    final db = await database;
    await db.delete('users');
    print('🗑️  All users cleared from database');
  }

  // Clear all reminders (for testing)
  Future<void> clearAllReminders() async {
    final db = await database;
    await db.delete('reminders');
    print('🗑️  All reminders cleared from database');
  }

  
  Future close() async {
    final db = await database;
    db.close();
  }
}
