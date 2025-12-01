# PulseGym - Image Assets & Database Guide

## Current Image Status

### ✅ What's Working Now
The app currently uses **network images** from Unsplash, which will work immediately without any downloads:
- Meal images load from Unsplash URLs
- Profile pictures can use default avatars or initials

### 📥 To Use Local Images (Optional Enhancement)

**If you want to use local images instead:**

#### Folder Structure
```
assets/
  images/
    meals/
      breakfast/
        yogurt_parfait.jpg
        omelette.jpg
        oatmeal.jpg
        avocado_toast.jpg
        smoothie_bowl.jpg
        (5 more for muscle gain)
      lunch/
        chicken_salad.jpg
        tuna_wrap.jpg
        buddha_bowl.jpg
        (7 more meals)
      dinner/
        salmon_veggies.jpg
        chicken_broccoli.jpg
        (8 more meals)
    profiles/
      default_male.png
      default_female.png
```

#### Update pubspec.yaml
```yaml
flutter:
  assets:
    - assets/images/meals/breakfast/
    - assets/images/meals/lunch/
    - assets/images/meals/dinner/
    - assets/images/profiles/
```

#### Update seed_data.dart
Change from:
```dart
imageAssetPath: 'https://images.unsplash.com/photo-xxx'
```
To:
```dart
imageAssetPath: 'assets/images/meals/breakfast/yogurt_parfait.jpg'
```

---

## 🗄️ Database Viewer Solutions

### Option 1: Use VS Code Extension (Recommended)
1. Install "SQLite Viewer" extension in VS Code
2. Run your Flutter app once to create the database
3. Find database file:
   - **Android**: Use Device File Explorer in Android Studio
   - **iOS**: `~/Library/Developer/CoreSimulator/Devices/[DEVICE-ID]/data/Containers/Data/Application/[APP-ID]/Documents/pulsegym.db`
4. Open `.db` file in VS Code

### Option 2: Use DB Browser for SQLite (Desktop App)
1. Download from: https://sqlitebrowser.org/
2. Extract database file from device
3. Open in DB Browser
4. View/Edit all tables directly

### Option 3: Add In-App Database Viewer (Development Only)
Add this to your Flutter app (in debug mode only):

```dart
// lib/utils/db_viewer_screen.dart
import 'package:flutter/material.dart';
import '../services/database_helper.dart';

class DatabaseViewerScreen extends StatefulWidget {
  @override
  _DatabaseViewerScreenState createState() => _DatabaseViewerScreenState();
}

class _DatabaseViewerScreenState extends State<DatabaseViewerScreen> {
  String selectedTable = 'users';
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    _loadTableData();
  }

  Future<void> _loadTableData() async {
    final db = await DatabaseHelper.instance.database;
    final data = await db.query(selectedTable);
    setState(() {
      tableData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Database Viewer - $selectedTable')),
      body: Column(
        children: [
          // Table selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _tableButton('users'),
              _tableButton('workouts'),
              _tableButton('meals'),
              _tableButton('community_posts'),
            ],
          ),
          // Data display
          Expanded(
            child: ListView.builder(
              itemCount: tableData.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(tableData[index].toString()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableButton(String table) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedTable = table;
          _loadTableData();
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedTable == table ? Colors.blue : Colors.grey,
      ),
      child: Text(table),
    );
  }
}
```

Add navigation to this screen in debug builds:
```dart
// In your main.dart or settings screen
if (kDebugMode) {
  ElevatedButton(
    onPressed: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DatabaseViewerScreen()),
    ),
    child: Text('View Database'),
  ),
}
```

### Option 4: Use Flutter DevTools
1. Run `flutter run` in terminal
2. Open DevTools URL shown in console
3. Not ideal for SQLite but can inspect app state

---

## ✅ Pre-Launch Checklist

### Critical Checks Before Running:

- [ ] All CRUD operations added to database_helper.dart ✅
- [ ] Seed data includes 25 users, 30 meals, 18 workouts, 15 posts ✅
- [ ] User model has height and goal fields ✅
- [ ] Database schema includes all columns ✅
- [ ] Routing configured (splash → signup → home) ✅
- [ ] Network images will load (or local images added)
- [ ] pubspec.yaml includes all dependencies

### Common Errors to Check:

1. **Missing await keywords** - All database operations should be async
2. **Null safety** - Check for nullable fields in models
3. **Image loading errors** - Network images need internet permission
4. **Database version** - Currently v3, upgrade migrations in place
5. **Import statements** - All relative paths correct

---

## 🚀 Running the App

```bash
# Clean build
flutter clean
flutter pub get

# Run on device
flutter run

# For Android permissions (if needed)
# Add to android/app/src/main/AndroidManifest.xml:
<uses-permission android:name="android.permission.INTERNET"/>
```

---

## 📝 Notes

- Current implementation uses **network images** - app will work immediately
- Profile icons currently not implemented - can add CircleAvatar with initials
- Database auto-seeds on first launch
- All CRUD operations are ready to use
- Community posts can be added/liked/deleted
