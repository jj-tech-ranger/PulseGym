# PulseGym SQLite Database Setup Guide

## Overview
This guide will help you integrate the SQLite database with your PulseGym screens in Android Studio.

## ✅ What's Already Done

1. **pubspec.yaml** - All dependencies are configured
2. **database_helper.dart** - Database schema and basic operations
3. **session_manager.dart** - User session management
4. **notification_service.dart** - Local notifications

## 🚀 Quick Setup Steps

### Step 1: Install Dependencies

Open terminal in Android Studio (Alt+F12) and run:

```bash
flutter pub get
```

### Step 2: Integrate Authentication Screens

#### Update Login Screen (`lib/screens/auth/login_screen.dart`)

Add these imports at the top:

```dart
import '../../services/database_helper.dart';
import '../../services/session_manager.dart';
```

Replace your login button `onPressed` with:

```dart
onPressed: () async {
  if (_formKey.currentState!.validate()) {
    final dbHelper = DatabaseHelper();
    
    // Get user by email
    final user = await dbHelper.getUserByEmail(_emailController.text);
    
    if (user != null) {
      // Validate password
      final isValid = await dbHelper.validatePassword(
        user['password_hash'],
        _passwordController.text,
      );
      
      if (isValid) {
        // Save session
        await SessionManager.saveSession(user);
        
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid password'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not found. Please sign up.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
},
```

#### Update Signup Screen (`lib/screens/auth/signup_screen.dart`)

Add imports:

```dart
import '../../services/database_helper.dart';
import '../../services/session_manager.dart';
```

Replace signup button `onPressed` with:

```dart
onPressed: () async {
  if (_formKey.currentState!.validate()) {
    final dbHelper = DatabaseHelper();
    
    try {
      // Create user
      final userData = {
        'name': _nameController.text,
        'email': _emailController.text,
        'password_hash': _passwordController.text,
        'created_at': DateTime.now().toIso8601String(),
      };
      
      final userId = await dbHelper.createUser(userData);
      
      // Save session
      await SessionManager.saveSession({
        'id': userId,
        'name': _nameController.text,
        'email': _emailController.text,
      });
      
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/onboarding/gender');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
},
```

### Step 3: Update Profile Screen with Real Data

Convert `ProfileScreen` to StatefulWidget and load user data:

```dart
import '../services/database_helper.dart';
import '../services/session_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  Map<String, dynamic>? workoutStats;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userId = await SessionManager.getCurrentUserId();
    if (userId != null) {
      final dbHelper = DatabaseHelper();
      final user = await dbHelper.getUserById(userId);
      final stats = await dbHelper.getWorkoutStats(userId);
      
      setState(() {
        userData = user;
        workoutStats = stats;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Use userData['name'], userData['email'], etc. in your UI
    return Scaffold(
      // ... your existing UI
    );
  }
}
```

### Step 4: Save Onboarding Data

In your final onboarding screen (`activity_level_screen.dart`), save the onboarding data:

```dart
onPressed: () async {
  final userId = await SessionManager.getCurrentUserId();
  if (userId != null) {
    final dbHelper = DatabaseHelper();
    
    // Update user profile with onboarding data
    await dbHelper.updateUser(userId, {
      'gender': selectedGender,
      'age': selectedAge,
      'height': selectedHeight,
      'weight': selectedWeight,
      'goal': selectedGoal,
      'activity_level': selectedActivityLevel,
    });
  }
  
  Navigator.pushReplacementNamed(context, '/home');
},
```

### Step 5: Log Workouts

When a workout is completed:

```dart
Future<void> _logWorkout() async {
  final userId = await SessionManager.getCurrentUserId();
  if (userId != null) {
    final dbHelper = DatabaseHelper();
    
    await dbHelper.addWorkout({
      'user_id': userId,
      'workout_name': workoutName,
      'created_at': DateTime.now().toIso8601String(),
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Workout logged!')),
    );
  }
}
```

### Step 6: Log Meals

When a meal is added:

```dart
Future<void> _logMeal(MealItem meal) async {
  final userId = await SessionManager.getCurrentUserId();
  if (userId != null) {
    final dbHelper = DatabaseHelper();
    
    await dbHelper.insertMeal({
      'user_id': userId,
      'meal_name': meal.name,
      'meal_type': 'breakfast', // or lunch, dinner, snack
      'calories': meal.calories,
      'protein': meal.protein,
      'carbs': meal.carbs,
      'fat': meal.fat,
      'date': DateTime.now().toIso8601String().split('T')[0],
    });
  }
}
```

### Step 7: Track Progress

Save weight updates:

```dart
Future<void> _saveProgress(double weight) async {
  final userId = await SessionManager.getCurrentUserId();
  if (userId != null) {
    final dbHelper = DatabaseHelper();
    
    await dbHelper.insertProgress({
      'user_id': userId,
      'weight': weight,
      'date': DateTime.now().toIso8601String(),
      'notes': notesController.text,
    });
  }
}
```

### Step 8: Implement Logout

In your Profile screen logout button:

```dart
onPressed: () async {
  await SessionManager.clearSession();
  Navigator.pushNamedAndRemoveUntil(
    context,
    '/login',
    (route) => false,
  );
},
```

## 📱 Testing the Database

### View Database in Android Studio

1. Run your app on emulator/device
2. Open **Device File Explorer**: View → Tool Windows → Device File Explorer
3. Navigate to: `/data/data/com.yourpackage.pulsegym/databases/pulsegym.db`
4. Right-click and download to view with SQLite browser

### Using ADB to Query Database

```bash
adb shell
cd /data/data/com.yourpackage.pulsegym/databases
sqlite3 pulsegym.db

# View tables
.tables

# Query users
SELECT * FROM users;

# Query workouts
SELECT * FROM workouts;

# Exit
.quit
```

## 🔧 Common Issues & Solutions

### Issue 1: MissingPluginException

**Solution**: Stop the app completely and restart (not hot reload)

```bash
flutter clean
flutter pub get
# Then run again
```

### Issue 2: Database Not Found

**Solution**: The database is created on first access. Make sure you're calling database operations after user signup.

### Issue 3: Duplicate Email Error

**Solution**: The email field has a UNIQUE constraint. Check if user exists before signup:

```dart
final existing = await dbHelper.getUserByEmail(email);
if (existing != null) {
  // Show error: Email already exists
}
```

### Issue 4: Session Not Persisting

**Solution**: Make sure `SharedPreferences` is saving properly:

```dart
final prefs = await SharedPreferences.getInstance();
print(prefs.getInt('user_id')); // Debug print
```

## 🎯 Next Steps

1. ✅ Run `flutter pub get`
2. ✅ Update login/signup screens with database code
3. ✅ Test user registration and login
4. ✅ Integrate onboarding data saving
5. ✅ Add workout and meal logging
6. ✅ Test on physical device or emulator

## 📚 Additional Resources

- [SQLite Flutter Documentation](https://pub.dev/packages/sqflite)
- [SharedPreferences Documentation](https://pub.dev/packages/shared_preferences)
- [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications)

## ✨ Your App Structure

```
PulseGym/
├── lib/
│   ├── data/
│   │   ├── meal_data.dart
│   │   └── workout_data.dart
│   ├── models/
│   │   └── user_model.dart
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── login_screen.dart ← Update this
│   │   │   └── signup_screen.dart ← Update this
│   │   ├── home_screen.dart
│   │   ├── profile_screen.dart ← Update this
│   │   └── ...
│   ├── services/
│   │   ├── database_helper.dart ✅ Ready
│   │   ├── session_manager.dart ✅ Ready
│   │   └── notification_service.dart ✅ Ready
│   ├── utils/
│   │   ├── app_colors.dart
│   │   └── theme.dart
│   └── main.dart
└── pubspec.yaml
```

---

**Happy Coding! 🚀** Your PulseGym app now has full database support!
