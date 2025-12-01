import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme.dart';
import '../../../models/meal_model.dart';
import '../../../services/database_helper.dart';

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({super.key});

  @override
  _MealPlanScreenState createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  late Future<Map<String, List<Meal>>> _mealsFuture;

  @override
  void initState() {
    super.initState();
    _mealsFuture = _loadMeals();
  }

  Future<Map<String, List<Meal>>> _loadMeals() async {
    final db = DatabaseHelper.instance;
    final meals = await db.getAllMeals();
    
    final mealMap = <String, List<Meal>>{
      'Breakfast': [],
      'Lunch': [],
      'Dinner': [],
      'Snack': [],
    };

    for (final meal in meals) {
      mealMap[meal.type]?.add(meal);
    }
    
    return mealMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        title: Text('Meal Plan', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, List<Meal>>>(
        future: _mealsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No meals found.'));
          }

          final mealMap = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: mealMap.keys.map((mealType) {
              final meals = mealMap[mealType]!;
              if (meals.isEmpty) {
                return const SizedBox.shrink();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Text(
                      mealType,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryNavy,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: meals.length,
                      itemBuilder: (context, index) {
                        return _buildMealCard(meals[index]);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildMealCard(Meal meal) {
    return Container(
      width: 180,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: meal.imageAssetPath != null
                ? Image.asset(
                    meal.imageAssetPath!,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        color: AppColors.secondaryPastelBlue.withOpacity(0.3),
                        child: const Center(
                          child: Icon(Icons.image_not_supported, color: AppColors.primaryNavy, size: 40),
                        ),
                      );
                    },
                  )
                : Container(
                    height: 120,
                    color: AppColors.secondaryPastelBlue.withOpacity(0.3),
                    child: const Center(
                      child: Icon(Icons.restaurant, color: AppColors.primaryNavy, size: 40),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.name,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryNavy,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${meal.calories} kcal',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.textDarkSlate.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
