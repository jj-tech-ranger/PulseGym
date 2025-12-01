import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';
import '../models/user_model.dart';
import '../models/workout_model.dart';
import '../models/meal_model.dart';
import '../models/community_post_model.dart';
import '../services/database_helper.dart';

/// Top-level function to run the database seeding in a separate isolate.
void seedDatabaseIsolate(String message) async {
  // Since this runs in a separate isolate, we need to initialize
  // the FFI bindings for sqflite on desktop platforms.
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  await SeedData.seedDatabase();
}

/// SeedData class to populate initial data on first app launch
class SeedData {
  static final DatabaseHelper _db = DatabaseHelper.instance;

  /// Seeds the database with initial workout and meal data in batches
  static Future<void> seedDatabase() async {
    final db = await _db.database;

    // Use batch processing for large datasets
    final userBatch = db.batch();
    for (final user in _initialUsers) {
      userBatch.insert('users', user.toMap());
    }
    await userBatch.commit(noResult: true);

    final postBatch = db.batch();
    for (final post in _initialCommunityPosts) {
      postBatch.insert('community_posts', post.toMap());
    }
    await postBatch.commit(noResult: true);

    if (kDebugMode) {
      print('Users and community posts seeded');
    }
  }

  // ==================== USERS ====================
  static final List<User> _initialUsers = List.generate(
    25,
    (i) => User(
      name: 'User $i',
      email: 'user$i@example.com',
      password: 'password123',
      gender: i % 2 == 0 ? 'Male' : 'Female',
      age: 20 + i,
      weight: 60.0 + i,
      height: 160.0 + i,
      goal: 'Get Fit',
      activityLevel: 'Moderate',
    ),
  );

  // ==================== COMMUNITY POSTS ====================
  static final List<CommunityPost> _initialCommunityPosts = List.generate(
    25,
    (i) => CommunityPost(
      userId: 'User $i',
      content: 'Just finished a great workout! Feeling energized. #fitness #motivation',
      likes: i * 10,
      timestamp: DateTime.now().subtract(Duration(minutes: i * 30)),
    ),
  );
}
