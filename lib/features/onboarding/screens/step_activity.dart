import 'package:flutter/material.dart';
import '../../../core/theme.dart';

/// StepActivity - Activity level selection [Ref: File 4.6]
class StepActivity extends StatelessWidget {
  final String? selectedLevel;
  final Function(String) onLevelSelected;

  const StepActivity({
    super.key,
    required this.selectedLevel,
    required this.onLevelSelected,
  });

  static const List<Map<String, dynamic>> _levels = [
    {
      'title': 'Beginner',
      'description': 'New to exercise or returning after a long break',
      'icon': Icons.directions_walk,
    },
    {
      'title': 'Intermediate',
      'description': 'Exercise 2-3 times per week regularly',
      'icon': Icons.directions_run,
    },
    {
      'title': 'Advanced',
      'description': 'Exercise 4+ times per week with high intensity',
      'icon': Icons.sports_gymnastics,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'Your Activity Level',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.primaryNavy,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'How would you describe your current fitness level?',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textDarkSlate.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.separated(
              itemCount: _levels.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final level = _levels[index];
                final isSelected = selectedLevel == level['title'];
                return _ActivityCard(
                  title: level['title'],
                  description: level['description'],
                  icon: level['icon'],
                  isSelected: isSelected,
                  onTap: () => onLevelSelected(level['title']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ActivityCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.secondaryPastel.withOpacity(0.3)
              : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryNavy : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryNavy : AppColors.secondaryPastel,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                size: 32,
                color: isSelected ? Colors.white : AppColors.primaryNavy,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? AppColors.primaryNavy : AppColors.textDarkSlate,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textDarkSlate.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.primaryNavy,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
