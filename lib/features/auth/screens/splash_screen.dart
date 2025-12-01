import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme.dart';
import '../../../services/auth_service.dart';
import '../../../services/database_helper.dart';
import '../../../data/seed_data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeAndNavigate();
  }

  Future<void> _initializeAndNavigate() async {
    final dbHelper = DatabaseHelper.instance;
    final authService = AuthService();

    // Check if the database needs to be seeded with workouts/meals/posts.
    // This is now independent of the user authentication flow.
    final isSeedingNeeded = await dbHelper.isDatabaseEmpty();
    if (isSeedingNeeded) {
      // This runs in a background isolate so it doesn't block the UI.
      seedDatabaseIsolate('Seed Initial Data');
    }

    // Check for an active user session in SharedPreferences.
    final user = await authService.getLoggedInUser();

    // Add a small delay to ensure the splash screen is visible briefly.
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    if (user != null) {
      // If a user session exists, go to the home screen.
      context.go('/home');
    } else {
      // If no user session exists, this is a new or logged-out user.
      // Direct them to the signup screen as the entry point.
      context.go('/signup');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center, size: 100, color: AppColors.primaryNavy),
            SizedBox(height: 20),
            Text('PulseGym', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primaryNavy)),
            SizedBox(height: 40),
            CircularProgressIndicator(color: AppColors.primaryNavy),
          ],
        ),
      ),
    );
  }
}
