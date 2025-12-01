import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';
import 'core/theme.dart';
import 'features/auth/screens/signup_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/splash_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'features/workouts/screens/category_list_screen.dart';
import 'features/workouts/screens/exercise_list_screen.dart';
import 'features/workouts/screens/video_player_screen.dart';
import 'features/nutrition/screens/meal_plan_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'features/community/screens/community_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const PulseGymApp());
}

class PulseGymApp extends StatelessWidget {
  const PulseGymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PulseGym',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: _router,
    );
  }
}

// GoRouter configuration
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/workouts',
      builder: (context, state) => const CategoryListScreen(),
    ),
    GoRoute(
      path: '/workout/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
        return ExerciseListScreen(workoutId: id);
      },
    ),
    GoRoute(
      path: '/video/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
        return VideoPlayerScreen(workoutId: id);
      },
    ),
    GoRoute(
      path: '/nutrition',
      builder: (context, state) => const MealPlanScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/community',
      builder: (context, state) => const CommunityScreen(),
    ),
  ],
);
