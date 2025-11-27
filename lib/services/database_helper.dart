import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';
import '../models/workout_model.dart';
import '../models/meal_model.dart';

/// DatabaseHelper Singleton for PulseGym
/// Manages SQLite database operations for Users, Workouts, and Meals
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
        gender TEXT,
        age INTEGER,
        weight REAL,
        height REAL,
        goal TEXT,
        activity_level TEXT
      )
    ''');

    // Create Workouts table
    await db.execute('''
      CREATE TABLE workouts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        category TEXT NOT NULL,
        duration TEXT NOT NULL,
        video_asset_path TEXT,
        is_favorite INTEGER DEFAULT 0,
        description TEXT,
        calories INTEGER,
        target_muscle TEXT
      )
    ''');

    // Create Meals table
    await db.execute('''
      CREATE TABLE meals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        calories INTEGER NOT NULL,
        type TEXT NOT NULL,
        image_asset_path TEXT,
        description TEXT,
        prep_time INTEGER,
        ingredients TEXT,
        instructions TEXT
      )
    ''');
  }

  // ==================== USER OPERATIONS ====================

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> getUser(int id) async {
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

  Future<User?> getFirstUser() async {
    final db = await database;
    final maps = await db.query('users', limit: 1);
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

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ==================== WORKOUT OPERATIONS ====================

  Future<int> insertWorkout(Workout workout) async {
    final db = await database;
    return await db.insert('workouts', workout.toMap());
  }

  Future<List<Workout>> getAllWorkouts() async {
    final db = await database;
    final maps = await db.query('workouts');
    return maps.map((map) => Workout.fromMap(map)).toList();
  }

  Future<List<Workout>> getWorkoutsByCategory(String category) async {
    final db = await database;
    final maps = await db.query(
      'workouts',
      where: 'category = ?',
      whereArgs: [category],
    );
    return maps.map((map) => Workout.fromMap(map)).toList();
  }

  Future<List<Workout>> getFavoriteWorkouts() async {
    final db = await database;
    final maps = await db.query(
      'workouts',
      where: 'is_favorite = ?',
      whereArgs: [1],
    );
    return maps.map((map) => Workout.fromMap(map)).toList();
  }

  Future<int> updateWorkout(Workout workout) async {
    final db = await database;
    return await db.update(
      'workouts',
      workout.toMap(),
      where: 'id = ?',
      whereArgs: [workout.id],
    );
  }

  Future<int> toggleWorkoutFavorite(int id, bool isFavorite) async {
    final db = await database;
    return await db.update(
      'workouts',
      {'is_favorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ==================== MEAL OPERATIONS ====================

  Future<int> insertMeal(Meal meal) async {
    final db = await database;
    return await db.insert('meals', meal.toMap());
  }

  Future<List<Meal>> getAllMeals() async {
    final db = await database;
    final maps = await db.query('meals');
    return maps.map((map) => Meal.fromMap(map)).toList();
  }

  Future<List<Meal>> getMealsByType(String type) async {
    final db = await database;
    final maps = await db.query(
      'meals',
      where: 'type = ?',
      whereArgs: [type],
    );
    return maps.map((map) => Meal.fromMap(map)).toList();
  }

  Future<int> updateMeal(Meal meal) async {
    final db = await database;
    return await db.update(
      'meals',
      meal.toMap(),
      where: 'id = ?',
      whereArgs: [meal.id],
    );
  }

  Future<int> deleteMeal(int id) async {
    final db = await database;
    return await db.delete(
      'meals',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ==================== UTILITY ====================

  Future close() async {
    final db = await database;
    db.close();
  }

  Future<bool> isDatabaseEmpty() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM workouts');
    final count = Sqflite.firstIntValue(result) ?? 0;
    return count == 0;
  }
}
