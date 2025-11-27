import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme.dart';
import 'data/seed_data.dart';
import 'services/database_helper.dart';
import 'features/onboarding/screens/onboarding_wrapper.dart';
import 'features/home/screens/home_screen.dart';
import 'features/workouts/screens/category_list_screen.dart';
import 'features/workouts/screens/exercise_list_screen.dart';
import 'features/workouts/screens/video_player_screen.dart';
import 'features/nutrition/screens/meal_plan_screen.dart';
import 'features/profile/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database
  await DatabaseHelper.instance.database;
  
  // Check if database needs seeding
  final isEmpty = await DatabaseHelper.instance.isDatabaseEmpty();
  if (isEmpty) {
    await SeedData.seedDatabase();
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
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryNavy,
          primary: AppColors.primaryNavy,
          secondary: AppColors.secondaryPastelBlue,
          background: AppColors.backgroundWhite,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryNavy,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryNavy,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.secondaryPastelBlue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primaryNavy, width: 2),
          ),
        ),
      ),
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
      builder: (context, state) => const _InitialRouteHandler(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingWrapper(),
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
  ],
);

// Initial route handler that checks for existing user
class _InitialRouteHandler extends StatefulWidget {
  const _InitialRouteHandler();

  @override
  State<_InitialRouteHandler> createState() => _InitialRouteHandlerState();
}

class _InitialRouteHandlerState extends State<_InitialRouteHandler> {
  @override
  void initState() {
    super.initState();
    _checkUserAndNavigate();
  }

  Future<void> _checkUserAndNavigate() async {
    final users = await DatabaseHelper.instance.getAllUsers();
    if (!mounted) return;
    
    if (users.isEmpty) {
      context.go('/onboarding');
    } else {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.secondaryPastelBlue.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.fitness_center,
                size: 64,
                color: AppColors.primaryNavy,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'PulseGym',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavy,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Loading...',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.textDarkSlate,
              ),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(
              color: AppColors.primaryNavy,
            ),
          ],
        ),
      ),
    );
  }
}
