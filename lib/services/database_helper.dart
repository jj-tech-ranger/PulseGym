import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';
import '../models/workout_model.dart';
import '../models/meal_model.dart';
import '../models/community_post_model.dart';

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
      version: 3,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future _createDB(Database db, int version) async {
    await _createUsersTable(db);
    await _createWorkoutsTable(db);
    await _createMealsTable(db);
    await _createCommunityPostsTable(db);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE users ADD COLUMN email TEXT');
      await db.execute('ALTER TABLE users ADD COLUMN password TEXT');
    }
    if (oldVersion < 3) {
      await _createCommunityPostsTable(db);
    }
  }

  Future<void> _createUsersTable(Database db) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        gender TEXT,
        age INTEGER,
        weight REAL,
        height REAL,
        goal TEXT,
        activity_level TEXT
      )
    ''');
  }

  Future<void> _createWorkoutsTable(Database db) async {
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
  }

  Future<void> _createMealsTable(Database db) async {
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
        instructions TEXT,
        goal TEXT,
        protein INTEGER,
        carbs INTEGER,
        fats INTEGER
      )
    ''');
  }

  Future<void> _createCommunityPostsTable(Database db) async {
    await db.execute('''
      CREATE TABLE community_posts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        content TEXT NOT NULL,
        likes INTEGER NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');
  }

  // ==================== USER OPERATIONS ====================

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
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

  Future<List<User>> getAllUsers() async {
    final db = await database;
    final maps = await db.query('users');
    return maps.map((map) => User.fromMap(map)).toList();
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

  // ==================== WORKOUT OPERATIONS ====================

  Future<List<Workout>> getAllWorkouts() async {
    final db = await database;
    final maps = await db.query('workouts');
    return maps.map((map) => Workout.fromMap(map)).toList();
  }

  Future<Workout?> getWorkoutById(int id) async {
    final db = await database;
    final maps = await db.query(
      'workouts',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Workout.fromMap(maps.first);
    }
    return null;
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

  // ==================== MEAL OPERATIONS ====================

  Future<List<Meal>> getAllMeals() async {
    final db = await database;
    final maps = await db.query('meals');
    return maps.map((map) => Meal.fromMap(map)).toList();
  }

  // ==================== COMMUNITY POSTS OPERATIONS ====================

  Future<int> insertPost(CommunityPost post) async {
    final db = await database;
    return await db.insert('community_posts', post.toMap());
  }

  Future<List<CommunityPost>> getAllPosts() async {
    final db = await database;
    final maps = await db.query('community_posts', orderBy: 'timestamp DESC');
    return maps.map((map) => CommunityPost.fromMap(map)).toList();
  }

  // ==================== UTILITY ====================

  Future<bool> isDatabaseEmpty() async {
    final db = await database;
    // Check workout table to decide if seeding is needed.
    final result = await db.rawQuery('SELECT COUNT(*) FROM workouts');
    final count = Sqflite.firstIntValue(result) ?? 0;
    return count == 0;

  // ==================== INSERT OPERATIONS ====================
  
  Future<int> insertWorkout(Workout workout) async {
    final db = await database;
    return await db.insert('workouts', workout.toMap());
  }

  Future<int> insertMeal(Meal meal) async {
    final db = await database;
    return await db.insert('meals', meal.toMap());
  }

  // ==================== UPDATE OPERATIONS ====================

  Future<int> updatePost(CommunityPost post) async {
    final db = await database;
    return await db.update(
      'community_posts',
      post.toMap(),
      where: 'id = ?',
      whereArgs: [post.id],
    );
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

  // ==================== DELETE OPERATIONS ====================

  Future<int> deletePost(int id) async {
    final db = await database;
    return await db.delete(
      'community_posts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteWorkout(int id) async {
    final db = await database;
    return await db.delete(
      'workouts',
      where: 'id = ?',
      whereArgs: [id],
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

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ==================== QUERY HELPERS ====================

  Future<List<Meal>> getMealsByGoal(String goal) async {
    final db = await database;
    final maps = await db.query(
      'meals',
      where: 'goal = ?',
      whereArgs: [goal],
    );
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

  }
}
