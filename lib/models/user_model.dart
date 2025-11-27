/// User Model for PulseGym
/// Matches SQLite User Table Schema
class User {
  final int? id;
  final String name;
  final String? gender;
  final int? age;
  final double? weight;
  final double? height;
  final String? goal;
  final String? activityLevel;

  User({
    this.id,
    required this.name,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.goal,
    this.activityLevel,
  });

  /// Convert User to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'age': age,
      'weight': weight,
      'height': height,
      'goal': goal,
      'activity_level': activityLevel,
    };
  }

  /// Create User from SQLite Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      name: map['name'] as String,
      gender: map['gender'] as String?,
      age: map['age'] as int?,
      weight: map['weight'] as double?,
      height: map['height'] as double?,
      goal: map['goal'] as String?,
      activityLevel: map['activity_level'] as String?,
    );
  }

  /// Create a copy with updated fields
  User copyWith({
    int? id,
    String? name,
    String? gender,
    int? age,
    double? weight,
    double? height,
    String? goal,
    String? activityLevel,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      goal: goal ?? this.goal,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }

  /// Calculate BMI
  double? get bmi {
    if (weight != null && height != null && height! > 0) {
      final heightInMeters = height! / 100;
      return weight! / (heightInMeters * heightInMeters);
    }
    return null;
  }

  /// Get BMI Category
  String? get bmiCategory {
    final bmiValue = bmi;
    if (bmiValue == null) return null;
    if (bmiValue < 18.5) return 'Underweight';
    if (bmiValue < 25) return 'Normal';
    if (bmiValue < 30) return 'Overweight';
    return 'Obese';
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, gender: $gender, age: $age, weight: $weight, height: $height, goal: $goal, activityLevel: $activityLevel)';
  }
}
