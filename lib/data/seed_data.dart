import '../models/workout_model.dart';
import '../models/meal_model.dart';
import '../services/database_helper.dart';

/// SeedData class to populate initial data on first app launch
class SeedData {
  static final DatabaseHelper _db = DatabaseHelper.instance;

  /// Seeds the database with initial workout and meal data
  static Future<void> seedDatabase() async {
    final isEmpty = await _db.isDatabaseEmpty();
    if (!isEmpty) return;

    // Seed Workouts
    for (final workout in _initialWorkouts) {
      await _db.insertWorkout(workout);
    }

    // Seed Meals
    for (final meal in _initialMeals) {
      await _db.insertMeal(meal);
    }
  }

  // ==================== WORKOUTS ====================
  static final List<Workout> _initialWorkouts = [
    // Beginner Workouts
    Workout(
      title: 'Morning Stretch',
      category: 'Beginner',
      duration: '10 min',
      description: 'Start your day with gentle stretches',
      calories: 50,
      targetMuscle: 'Full Body',
    ),
    Workout(
      title: 'Basic Cardio',
      category: 'Beginner',
      duration: '15 min',
      description: 'Light cardio to get your heart pumping',
      calories: 100,
      targetMuscle: 'Cardio',
    ),
    Workout(
      title: 'Core Basics',
      category: 'Beginner',
      duration: '12 min',
      description: 'Build core strength with basic exercises',
      calories: 80,
      targetMuscle: 'Core',
    ),
    Workout(
      title: 'Leg Day Starter',
      category: 'Beginner',
      duration: '15 min',
      description: 'Strengthen your legs with squats and lunges',
      calories: 120,
      targetMuscle: 'Legs',
    ),
    // Intermediate Workouts
    Workout(
      title: 'HIIT Blast',
      category: 'Intermediate',
      duration: '20 min',
      description: 'High-intensity interval training',
      calories: 250,
      targetMuscle: 'Full Body',
    ),
    Workout(
      title: 'Upper Body Power',
      category: 'Intermediate',
      duration: '25 min',
      description: 'Build upper body strength',
      calories: 200,
      targetMuscle: 'Upper Body',
    ),
    Workout(
      title: 'Core Crusher',
      category: 'Intermediate',
      duration: '18 min',
      description: 'Intensive core workout',
      calories: 150,
      targetMuscle: 'Core',
    ),
    Workout(
      title: 'Cardio Burn',
      category: 'Intermediate',
      duration: '30 min',
      description: 'Sustained cardio for fat burning',
      calories: 300,
      targetMuscle: 'Cardio',
    ),
    // Advanced Workouts
    Workout(
      title: 'Ultimate HIIT',
      category: 'Advanced',
      duration: '35 min',
      description: 'Extreme high-intensity workout',
      calories: 450,
      targetMuscle: 'Full Body',
    ),
    Workout(
      title: 'Strength Master',
      category: 'Advanced',
      duration: '45 min',
      description: 'Advanced strength training',
      calories: 400,
      targetMuscle: 'Full Body',
    ),
    Workout(
      title: 'Plyo Power',
      category: 'Advanced',
      duration: '30 min',
      description: 'Plyometric exercises for explosiveness',
      calories: 350,
      targetMuscle: 'Legs',
    ),
    Workout(
      title: 'Endurance Challenge',
      category: 'Advanced',
      duration: '50 min',
      description: 'Test your limits with this endurance workout',
      calories: 500,
      targetMuscle: 'Cardio',
    ),
  ];

  // ==================== MEALS ====================
  static final List<Meal> _initialMeals = [
    // Breakfast
    Meal(
      name: 'Oatmeal with Berries',
      calories: 320,
      type: 'Breakfast',
      description: 'Hearty oatmeal topped with fresh berries',
      prepTime: 10,
      ingredients: ['Oats', 'Milk', 'Blueberries', 'Strawberries', 'Honey'],
    ),
    Meal(
      name: 'Protein Pancakes',
      calories: 450,
      type: 'Breakfast',
      description: 'Fluffy pancakes with protein powder',
      prepTime: 20,
      ingredients: ['Protein powder', 'Eggs', 'Banana', 'Oats'],
    ),
    Meal(
      name: 'Avocado Toast',
      calories: 280,
      type: 'Breakfast',
      description: 'Whole grain toast with smashed avocado',
      prepTime: 5,
      ingredients: ['Bread', 'Avocado', 'Salt', 'Pepper', 'Lemon'],
    ),
    Meal(
      name: 'Greek Yogurt Bowl',
      calories: 250,
      type: 'Breakfast',
      description: 'Protein-rich yogurt with granola',
      prepTime: 5,
      ingredients: ['Greek yogurt', 'Granola', 'Honey', 'Nuts'],
    ),
    // Lunch
    Meal(
      name: 'Grilled Chicken Salad',
      calories: 380,
      type: 'Lunch',
      description: 'Fresh salad with grilled chicken breast',
      prepTime: 25,
      ingredients: ['Chicken', 'Lettuce', 'Tomatoes', 'Cucumber', 'Olive oil'],
    ),
    Meal(
      name: 'Quinoa Buddha Bowl',
      calories: 420,
      type: 'Lunch',
      description: 'Nutritious bowl with quinoa and vegetables',
      prepTime: 30,
      ingredients: ['Quinoa', 'Chickpeas', 'Avocado', 'Kale', 'Tahini'],
    ),
    Meal(
      name: 'Turkey Wrap',
      calories: 350,
      type: 'Lunch',
      description: 'Lean turkey in a whole wheat wrap',
      prepTime: 10,
      ingredients: ['Turkey', 'Whole wheat wrap', 'Lettuce', 'Tomato', 'Mustard'],
    ),
    Meal(
      name: 'Salmon Poke Bowl',
      calories: 480,
      type: 'Lunch',
      description: 'Fresh salmon with rice and vegetables',
      prepTime: 20,
      ingredients: ['Salmon', 'Rice', 'Edamame', 'Avocado', 'Soy sauce'],
    ),
    // Dinner
    Meal(
      name: 'Baked Salmon',
      calories: 450,
      type: 'Dinner',
      description: 'Oven-baked salmon with herbs',
      prepTime: 35,
      ingredients: ['Salmon', 'Lemon', 'Dill', 'Garlic', 'Olive oil'],
    ),
    Meal(
      name: 'Chicken Stir Fry',
      calories: 400,
      type: 'Dinner',
      description: 'Quick stir fry with vegetables',
      prepTime: 25,
      ingredients: ['Chicken', 'Broccoli', 'Bell peppers', 'Soy sauce', 'Ginger'],
    ),
    Meal(
      name: 'Lean Beef Tacos',
      calories: 520,
      type: 'Dinner',
      description: 'Healthy tacos with lean ground beef',
      prepTime: 30,
      ingredients: ['Ground beef', 'Corn tortillas', 'Lettuce', 'Salsa', 'Cheese'],
    ),
    Meal(
      name: 'Vegetable Curry',
      calories: 380,
      type: 'Dinner',
      description: 'Aromatic curry with mixed vegetables',
      prepTime: 40,
      ingredients: ['Mixed vegetables', 'Coconut milk', 'Curry paste', 'Rice'],
    ),
  ];
}
