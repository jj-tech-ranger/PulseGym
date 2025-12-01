/// Workout Model for PulseGym
/// Matches SQLite Workouts Table Schema
class Workout {
  final int? id;
  final String title;
  final String category; // Beginner, Intermediate, Advanced
  final String duration;
  final String? videoAssetPath;
  final bool isFavorite;
  final String? description;
  final int? calories;
  final String? targetMuscle;
    final String? exercises;

  Workout({
    this.id,
    required this.title,
    required this.category,
    required this.duration,
    this.videoAssetPath,
    this.isFavorite = false,
    this.description,
    this.calories,
    this.targetMuscle,
        this.exercises,
  });

  /// Convert Workout to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'duration': duration,
      'video_asset_path': videoAssetPath,
      'is_favorite': isFavorite ? 1 : 0,
      'description': description,
      'calories': calories,
      'target_muscle': targetMuscle,
            'exercises': exercises,
    };
  }

  /// Create Workout from SQLite Map
  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'] as int?,
      title: map['title'] as String,
      category: map['category'] as String,
      duration: map['duration'] as String,
      videoAssetPath: map['video_asset_path'] as String?,
      isFavorite: (map['is_favorite'] as int?) == 1,
      description: map['description'] as String?,
      calories: map['calories'] as int?,
      targetMuscle: map['target_muscle'] as String?,
            exercises: map['exercises'] as String?,
    );
  }

  /// Create a copy with updated fields
  Workout copyWith({
    int? id,
    String? title,
    String? category,
    String? duration,
    String? videoAssetPath,
    bool? isFavorite,
    String? description,
    int? calories,
    String? targetMuscle,
        String? exercises,
  }) {
    return Workout(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      duration: duration ?? this.duration,
      videoAssetPath: videoAssetPath ?? this.videoAssetPath,
      isFavorite: isFavorite ?? this.isFavorite,
      description: description ?? this.description,
      calories: calories ?? this.calories,
      targetMuscle: targetMuscle ?? this.targetMuscle,
            exercises: exercises ?? this.exercises,
    );
  }

  /// Get difficulty level as integer (1-3)
  int get difficultyLevel {
    switch (category.toLowerCase()) {
      case 'beginner':
        return 1;
      case 'intermediate':
        return 2;
      case 'advanced':
        return 3;
      default:
        return 1;
    }
  }

  @override
  String toString() {
    return 'Workout(id: $id, title: $title, category: $category, duration: $duration, isFavorite: $isFavorite)';
  }
}
