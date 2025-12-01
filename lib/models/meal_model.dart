/// Meal Model for PulseGym
/// Matches SQLite Meals Table Schema
class Meal {
  final int? id;
  final String name;
  final int calories;
  final String type; // Breakfast, Lunch, Dinner, Snack
  final String? goal; // Weight Loss or Muscle Gain
  final int? protein;
  final int? carbs;
  final int? fats;
  final String? imageAssetPath;
  final String? description;
  final int? prepTime; // in minutes
  final List<String>? ingredients;
  final String? instructions;

  Meal({
    this.id,
    required this.name,
    required this.calories,
    required this.type,
    this.imageAssetPath,
    this.description,
    this.prepTime,
    this.ingredients,
    this.instructions,
    this.goal,
    this.protein,
    this.carbs,
    this.fats,
  });

  /// Convert Meal to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
      'type': type,
      'image_asset_path': imageAssetPath,
      'description': description,
      'prep_time': prepTime,
      'ingredients': ingredients?.join('|'),
      'instructions': instructions,
      'goal': goal,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
    };
  }

  /// Create Meal from SQLite Map
  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'] as int?,
      name: map['name'] as String,
      calories: map['calories'] as int,
      type: map['type'] as String,
      imageAssetPath: map['image_asset_path'] as String?,
      description: map['description'] as String?,
      prepTime: map['prep_time'] as int?,
      ingredients: (map['ingredients'] as String?)?.split('|'),
      instructions: map['instructions'] as String?,
      goal: map['goal'] as String?,
      protein: map['protein'] as int?,
      carbs: map['carbs'] as int?,
      fats: map['fats'] as int?,
    );
  }

  /// Create a copy with updated fields
  Meal copyWith({
    int? id,
    String? name,
    int? calories,
    String? type,
    String? imageAssetPath,
    String? description,
    int? prepTime,
    List<String>? ingredients,
    String? instructions,
    String? goal,
    int? protein,
    int? carbs,
    int? fats,
  }) {
    return Meal(
      id: id ?? this.id,
      name: name ?? this.name,
      calories: calories ?? this.calories,
      type: type ?? this.type,
      imageAssetPath: imageAssetPath ?? this.imageAssetPath,
      description: description ?? this.description,
      prepTime: prepTime ?? this.prepTime,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      goal: goal ?? this.goal,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
    );
  }

  /// Get calorie category
  String get calorieCategory {
    if (calories < 200) return 'Low';
    if (calories < 400) return 'Medium';
    return 'High';
  }

  /// Get formatted prep time
  String get formattedPrepTime {
    if (prepTime == null) return 'N/A';
    if (prepTime! < 60) return '$prepTime min';
    final hours = prepTime! ~/ 60;
    final mins = prepTime! % 60;
    return mins > 0 ? '${hours}h ${mins}m' : '${hours}h';
  }

  @override
  String toString() {
    return 'Meal(id: $id, name: $name, calories: $calories, type: $type)';
  }
}
