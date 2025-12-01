import 'package:flutter/foundation.dart';

/// User Model for PulseGym
/// Represents a user's profile and fitness-related data.
@immutable
class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String? gender;
  final int? age;
  final double? weight;
  final double? height;
  final String? goal;
  final String? activityLevel;

  const User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.goal,
    this.activityLevel,
  });

  // BMI Calculation (Body Mass Index)
  // Formula: weight (kg) / (height (m))^2
  double calculateBMI() {
    if (height == null || height! <= 0 || weight == null || weight! <= 0) {
      return 0.0;
    }
    // Convert height from cm to meters
    final heightInMeters = height! / 100;
    return weight! / (heightInMeters * heightInMeters);
  }

  // Convert User to a Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'gender': gender,
      'age': age,
      'weight': weight,
      'height': height,
      'goal': goal,
      'activity_level': activityLevel,
    };
  }

  // Create User from a Map from the database
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      gender: map['gender'],
      age: map['age'],
      weight: map['weight'],
      height: map['height'],
      goal: map['goal'],
      activityLevel: map['activity_level'],
    );
  }

  // Create a copy of the User with updated values
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
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
      email: email ?? this.email,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      goal: goal ?? this.goal,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }
}
