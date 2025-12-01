import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';
import '../models/user_model.dart';
import '../models/workout_model.dart';
import '../models/meal_model.dart';
import '../models/community_post_model.dart';
import '../services/database_helper.dart';

void seedDatabaseIsolate(String message) async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  await SeedData.seedDatabase();
}

class SeedData {
  static final DatabaseHelper _db = DatabaseHelper.instance;

  static Future<void> seedDatabase() async {
    final db = await DatabaseHelper.instance.database;
    
    final userCount = (await db.rawQuery('SELECT COUNT(*) FROM users')).first.values.first as int;
    if (userCount != null && userCount > 0) {
      if (kDebugMode) print('Database already seeded');
      return;
    }

    if (kDebugMode) print('Seeding database...');

    for (var user in _initialUsers) {
      await db.insert('users', user.toMap());
    }

    for (var workout in _initialWorkouts) {
      await db.insert('workouts', workout.toMap());
    }

    for (var meal in _initialMeals) {
      await db.insert('meals', meal.toMap());
    }

    for (var post in _initialCommunityPosts) {
      await db.insert('community_posts', post.toMap());
    }

    if (kDebugMode) print('Users, workouts, meals, and community posts seeded');
  }

  static final List<User> _initialUsers = List.generate(
    25,
    (i) => User(
      name: 'User ${i + 1}',
      email: 'user${i + 1}@example.com',
      password: 'password123',
      gender: i % 2 == 0 ? 'Male' : 'Female',
      age: 20 + i,
      weight: 60.0 + i,
      height: 160.0 + i,
      goal: i % 3 == 0 ? 'Lose Weight' : (i % 3 == 1 ? 'Gain Muscle' : 'Get Fit'),
      activityLevel: i % 3 == 0 ? 'Beginner' : (i % 3 == 1 ? 'Intermediate' : 'Advanced'),
    ),
  );

  static final List<Workout> _initialWorkouts = [
    Workout(title: 'Morning Stretch', category: 'Beginner', duration: '10, videoAssetPath: 'assets/videos/morning_stretch.mp4', isFavorite: 0, exercises: 'Neck Rolls, Shoulder Shrugs, Arm Circles, Side Bends, Leg Swings'),
    Workout(title: 'Basic Cardio', category: 'Beginner', duration: '15, videoAssetPath: 'assets/videos/basic_cardio.mp4', isFavorite: 0, exercises: 'Jumping Jacks, High Knees, Butt Kicks, Side Steps, Toe Touches'),
    Workout(title: 'Core Basics', category: 'Beginner', duration: '12, videoAssetPath: 'assets/videos/core_basics.mp4', isFavorite: 0, exercises: 'Plank, Crunches, Bicycle Crunches, Leg Raises, Russian Twists'),
    Workout(title: 'Lower Body Intro', category: 'Beginner', duration: '15, videoAssetPath: 'assets/videos/lower_body_intro.mp4', isFavorite: 0, exercises: 'Squats, Lunges, Glute Bridges, Calf Raises, Wall Sits'),
    Workout(title: 'Upper Body Basics', category: 'Beginner', duration: '15, videoAssetPath: 'assets/videos/upper_body_basics.mp4', isFavorite: 0, exercises: 'Push-ups, Tricep Dips, Arm Circles, Shoulder Press, Bicep Curls'),
    Workout(title: 'Full Body Beginner', category: 'Beginner', duration: '20, videoAssetPath: 'assets/videos/full_body_beginner.mp4', isFavorite: 0, exercises: 'Squats, Push-ups, Lunges, Plank, Jumping Jacks'),
    Workout(title: 'Power Cardio', category: 'Intermediate', duration: '25, videoAssetPath: 'assets/videos/power_cardio.mp4', isFavorite: 0, exercises: 'Burpees, Mountain Climbers, Jump Squats, High Knees, Box Jumps'),
    Workout(title: 'Core Strength', category: 'Intermediate', duration: '20, videoAssetPath: 'assets/videos/core_strength.mp4', isFavorite: 0, exercises: 'Plank Variations, V-Ups, Hollow Body Hold, Dead Bug, Bird Dog'),
    Workout(title: 'Leg Power', category: 'Intermediate', duration: '30, videoAssetPath: 'assets/videos/leg_power.mp4', isFavorite: 0, exercises: 'Jump Squats, Bulgarian Split Squats, Pistol Squats, Step-Ups, Lunges'),
    Workout(title: 'Upper Body Strength', category: 'Intermediate', duration: '25, videoAssetPath: 'assets/videos/upper_strength.mp4', isFavorite: 0, exercises: 'Diamond Push-ups, Pike Push-ups, Dips, Pull-ups, Rows'),
    Workout(title: 'HIIT Session', category: 'Intermediate', duration: '20, videoAssetPath: 'assets/videos/hiit_session.mp4', isFavorite: 0, exercises: 'Burpees, Jump Lunges, Plank Jacks, Mountain Climbers, Star Jumps'),
    Workout(title: 'Full Body Blast', category: 'Intermediate', duration: '35, videoAssetPath: 'assets/videos/full_body_blast.mp4', isFavorite: 0, exercises: 'Burpees, Push-ups, Squats, Lunges, Plank, Mountain Climbers'),
    Workout(title: 'Elite Cardio', category: 'Advanced', duration: '40, videoAssetPath: 'assets/videos/elite_cardio.mp4', isFavorite: 0, exercises: 'Sprint Intervals, Box Jumps, Burpee Broad Jumps, Tuck Jumps, Lateral Bounds'),
    Workout(title: 'Core Mastery', category: 'Advanced', duration: '30, videoAssetPath: 'assets/videos/core_mastery.mp4', isFavorite: 0, exercises: 'Dragon Flags, L-Sits, Ab Wheel Rollouts, Windshield Wipers, Hanging Leg Raises'),
    Workout(title: 'Leg Destroyer', category: 'Advanced', duration: '45, videoAssetPath: 'assets/videos/leg_destroyer.mp4', isFavorite: 0, exercises: 'Pistol Squats, Jump Lunges, Single Leg Deadlifts, Box Jumps, Wall Sits'),
    Workout(title: 'Upper Body Elite', category: 'Advanced', duration: '40, videoAssetPath: 'assets/videos/upper_elite.mp4', isFavorite: 0, exercises: 'Muscle-ups, Handstand Push-ups, One-Arm Push-ups, Archer Pull-ups, Dips'),
    Workout(title: 'Extreme HIIT', category: 'Advanced', duration: '30, videoAssetPath: 'assets/videos/extreme_hiit.mp4', isFavorite: 0, exercises: 'Burpee Box Jumps, Tuck Jumps, Plyo Push-ups, Jump Lunges, Sprints'),
    Workout(title: 'Complete Warrior', category: 'Advanced', duration: '50, videoAssetPath: 'assets/videos/complete_warrior.mp4', isFavorite: 0, exercises: 'Burpees, Muscle-ups, Pistol Squats, Handstand Push-ups, Sprint Intervals'),
  ];

  static final List<Meal> _initialMeals = [
    Meal(name: 'Greek Yogurt Parfait', calories: 280, type: 'Breakfast', goal: 'Weight Loss', imageAssetPath: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=400'5, protein: 20, carbs: 35, fats: 6),
    Meal(name: 'Veggie Omelette', calories: 220, type: 'Breakfast', goal: 'Weight Loss', imageAssetPath: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400'10, protein: 18, carbs: 8, fats: 14),
    Meal(name: 'Oatmeal with Berries', calories: 250, type: 'Breakfast', goal: 'Weight Loss', imageAssetPath: 'https://images.unsplash.com/photo-1517673132405-a56a62b18caf?w=400'8, protein: 8, carbs: 45, fats: 5),
    Meal(name: 'Avocado Toast', calories: 290, type: 'Breakfast', goal: 'Weight Loss', imageAssetPath: 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=400'7, protein: 10, carbs: 32, fats: 15),
    Meal(name: 'Protein Smoothie Bowl', calories: 260, type: 'Breakfast', goal: 'Weight Loss', imageAssetPath: 'https://images.unsplash.com/photo-1590301157890-4810ed352733?w=400'5, protein: 25, carbs: 30, fats: 7),
    Meal(name: 'Power Pancakes', calories: 520, type: 'Breakfast', goal: 'Muscle Gain', imageAssetPath: 'https://images.unsplash.com/photo-1528207776546-365bb710ee93?w=400'15, protein: 30, carbs: 65, fats: 15),
    Meal(name: 'Muscle Builder Omelette', calories: 480, type: 'Breakfast', goal: 'Muscle Gain', imageAssetPath: 'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?w=400'12, protein: 42, carbs: 12, fats: 28),
    Meal(name: 'Banana Peanut Butter Toast', calories: 450, type: 'Breakfast', goal: 'Muscle Gain', imageAssetPath: 'https://images.unsplash.com/photo-1484723091739-30a097e8f929?w=400'5, protein: 18, carbs: 58, fats: 18),
    Meal(name: 'Protein-Packed Burrito', calories: 550, type: 'Breakfast', goal: 'Muscle Gain', imageAssetPath: 'https://images.unsplash.com/photo-1626700051175-6818013e1314?w=400'15, protein: 35, carbs: 55, fats: 20),
    Meal(name: 'Mass Gainer Shake', calories: 600, type: 'Breakfast', goal: 'Muscle Gain', imageAssetPath: 'https://images.unsplash.com/photo-1553530666-15b4f7f9c5fe?w=400'5, protein: 50, carbs: 70, fats: 15),
    Meal(name: 'Grilled Chicken Salad', calories: 320, type: 'Lunch', goal: 'Weight Loss', imageAssetPath: 'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=400'20, protein: 35, carbs: 18, fats: 12),
    Meal(name: 'Tuna Wrap', calories: 300, type: 'Lunch', goal: 'Weight Loss', imageAssetPath: 'https://images.unsplash.com/photo-1626700051175-6818013e1314?w=400'10, protein: 28, carbs: 30, fats: 8),
    Meal(name: 'Quinoa Buddha Bowl', calories: 350, type: 'Lunch', goal: 'Weight Loss', imageAssetPath: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400'25, protein: 15, carbs: 48, fats: 12),
    Meal(name: 'Turkey Sandwich', calories: 280, type: 'Lunch', goal: 'Weight Loss', imageAssetPath: 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=400'5, protein: 24, carbs: 32, fats: 6),
    Meal(name: 'Veggie Stir Fry', calories: 270, type: 'Lunch', goal: 'Weight Loss', imageAssetPath: 'https://images.unsplash.com/photo-1559847844-d9e8c48ffa7e?w=400'18, protein: 12, carbs: 42, fats: 8),
    Meal(name: 'Chicken Rice Bowl', calories: 550, type: 'Lunch', goal: 'Muscle Gain', imageAssetPath: 'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=400'25, protein: 45, carbs: 60, fats: 15),
    Meal(name: 'Steak & Sweet Potato', calories: 600, type: 'Lunch', goal: 'Muscle Gain', imageAssetPath: 'https://images.unsplash.com/photo-1558030006-450675393462?w=400'30, protein: 48, carbs: 55, fats: 20),
    Meal(name: 'Salmon Pasta', calories: 580, type: 'Lunch', goal: 'Muscle Gain', imageAssetPath: 'https://images.unsplash.com/photo-1563379926898-05f4575a45d8?w=400'22, protein: 40, carbs: 58, fats: 18),
    Meal(name: 'Beef Burrito Bowl', calories: 620, type: 'Lunch', goal: 'Muscle Gain', imageAssetPath: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400'20, protein: 42, carbs: 65, fats: 22),
    Meal(name: 'Power Chicken Wrap', calories: 540, type: 'Lunch', goal: 'Muscle Gain', imageAssetPath: 'https://images.unsplash.com/photo-1599020792689-9fde458e7e17?w=400'15, protein: 38, carbs: 52, fats: 18),
    Meal(name: 'Baked Salmon & Veggies', calories: 340, type: 'Dinner', goal: 'Weight Loss', imageAssetPath: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=400'25, protein: 32, carbs: 22, fats: 15),
    Meal(name: 'Chicken Breast & Broccoli', calories: 310, type: 'Dinner', goal: 'Weight Loss', imageAssetPath: 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=400'20, protein: 38, carbs: 18, fats: 10),
    Meal(name: 'Turkey Meatballs & Zucchini', calories: 290, type: 'Dinner', goal: 'Weight Loss', imageAssetPath: 'https://images.unsplash.com/photo-1529042410759-befb1204b468?w=400'30, protein: 30, carbs: 20, fats: 12),
    Meal(name: 'Shrimp Cauliflower Rice', calories: 260, type: 'Dinner', goal: 'Weight Loss', imageAssetPath: 'https://images.unsplash.com/photo-1553621042-f6e147245754?w=400'18, protein: 28, carbs: 15, fats: 10),
    Meal(name: 'Grilled Tilapia & Asparagus', calories: 280, type: 'Dinner', goal: 'Weight Loss', imageAssetPath: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=400'22, protein: 35, carbs: 12, fats: 11),
    Meal(name: 'Ribeye Steak & Potatoes', calories: 650, type: 'Dinner', goal: 'Muscle Gain', imageAssetPath: 'https://images.unsplash.com/photo-1558030006-450675393462?w=400'28, protein: 52, carbs: 48, fats: 28),
    Meal(name: 'Chicken Alfredo Pasta', calories: 620, type: 'Dinner', goal: 'Muscle Gain', imageAssetPath: 'https://images.unsplash.com/photo-1645112411341-6c4fd023714a?w=400'25, protein: 45, carbs: 58, fats: 22),
    Meal(name: 'BBQ Ribs & Mac Cheese', calories: 700, type: 'Dinner', goal: 'Muscle Gain', imageAssetPath: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=400'35, protein: 48, carbs: 62, fats: 30),
    Meal(name: 'Grilled Salmon & Rice', calories: 590, type: 'Dinner', goal: 'Muscle Gain', imageAssetPath: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=400'22, protein: 46, carbs: 54, fats: 18),
    Meal(name: 'Beef Stir Fry & Noodles', calories: 610, type: 'Dinner', goal: 'Muscle Gain', imageAssetPath: 'https://images.unsplash.com/photo-1552611052-33e04de081de?w=400'20, protein: 40, carbs: 60, fats: 20),
  ];

  static final List<CommunityPost> _initialCommunityPosts = List.generate(
    15,
    (i) => CommunityPost(
      userId: 'User ${(i % 25) + 1}',
      content: i % 3 == 0 ? 'Just finished a great workout! Feeling energized. #fitness #motivation' : (i % 3 == 1 ? 'Hit a new personal record today! Hard work pays off!' : 'Loving my fitness journey. Keep pushing everyone!'),
      likes: i * 10,
      timestamp: DateTime.now().subtract(Duration(minutes: i * 30)),
    ),
  );
}
