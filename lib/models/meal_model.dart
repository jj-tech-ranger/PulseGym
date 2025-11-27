/// Meal Model for PulseGym
/// Matches SQLite Meals Table Schema
class Meal {
  final int? id;
  final String name;
  final int calories;
  final String type; // Breakfast, Lunch, Dinner, Snack
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
