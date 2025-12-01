import 'package:flutter/material.dart';
import '../core/theme.dart';

/// A reusable avatar widget that displays user profile pictures
/// Supports three modes:
/// 1. Gender-based icons (Male/Female icons)
/// 2. Initials from name
/// 3. Custom image path
class UserAvatar extends StatelessWidget {
  final String? name;
  final String? gender; // 'Male' or 'Female'
  final String? imageUrl;
  final double size;
  final Color? backgroundColor;
  final Color? textColor;

  const UserAvatar({
    super.key,
    this.name,
    this.gender,
    this.imageUrl,
    this.size = 40,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    // If image URL is provided, use it
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: size / 2,
        backgroundImage: NetworkImage(imageUrl!),
        backgroundColor: backgroundColor ?? AppColors.secondaryPastelBlue,
        onBackgroundImageError: (_, __) {
          // Fallback handled by child
        },
        child: _buildFallbackContent(),
      );
    }

    // Otherwise use gender icon or initials
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: backgroundColor ?? _getGenderColor(),
      child: _buildFallbackContent(),
    );
  }

  Widget _buildFallbackContent() {
    // Priority 1: Gender-based icon
    if (gender != null) {
      return Icon(
        _getGenderIcon(),
        size: size * 0.6,
        color: textColor ?? Colors.white,
      );
    }

    // Priority 2: Initials from name
    if (name != null && name!.isNotEmpty) {
      return Text(
        _getInitials(name!),
        style: TextStyle(
          fontSize: size * 0.4,
          fontWeight: FontWeight.bold,
          color: textColor ?? Colors.white,
        ),
      );
    }

    // Fallback: Generic person icon
    return Icon(
      Icons.person,
      size: size * 0.6,
      color: textColor ?? Colors.white,
    );
  }

  IconData _getGenderIcon() {
    if (gender?.toLowerCase() == 'male') {
      return Icons.man; // Male icon
    } else if (gender?.toLowerCase() == 'female') {
      return Icons.woman; // Female icon
    }
    return Icons.person; // Default
  }

  Color _getGenderColor() {
    if (gender?.toLowerCase() == 'male') {
      return AppColors.primaryNavy; // Navy blue for male
    } else if (gender?.toLowerCase() == 'female') {
      return AppColors.secondaryPastelBlue; // Pastel blue for female
    }
    return AppColors.textDarkGrey; // Default gray
  }

  String _getInitials(String name) {
    final words = name.trim().split(' ');
    if (words.isEmpty) return '?';
    
    if (words.length == 1) {
      return words[0][0].toUpperCase();
    }
    
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }
}

/// Example usage:
/// 
/// UserAvatar(
///   name: 'John Doe',
///   gender: 'Male',
///   size: 50,
/// )
/// 
/// UserAvatar(
///   name: 'Jane Smith',
///   gender: 'Female',
///   imageUrl: 'https://example.com/photo.jpg',
///   size: 60,
/// )
