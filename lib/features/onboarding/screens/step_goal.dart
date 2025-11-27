import 'package:flutter/material.dart';
import '../../../core/theme.dart';

/// StepGoal - Fitness goal selection [Ref: File 4.5]
/// Grid of selectable cards for fitness goals
class StepGoal extends StatelessWidget {
  final String? selectedGoal;
  final Function(String) onGoalSelected;

  const StepGoal({
    super.key,
    required this.selectedGoal,
    required this.onGoalSelected,
  });

  static const List<Map<String, dynamic>> _goals = [
    {
      'title': 'Lose Weight',
      'icon': Icons.trending_down,
      'description': 'Burn fat and get lean',
    },
    {
      'title': 'Gain Muscle',
      'icon': Icons.fitness_center,
      'description': 'Build strength and mass',
    },
    {
      'title': 'Stay Fit',
      'icon': Icons.favorite,
      'description': 'Maintain current fitness',
    },
    {
      'title': 'Build Endurance',
      'icon': Icons.speed,
      'description': 'Improve stamina',
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
            'What is your goal?',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.primaryNavy,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We\'ll customize your plan based on your goal',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textDarkSlate.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemCount: _goals.length,
              itemBuilder: (context, index) {
                final goal = _goals[index];
                final isSelected = selectedGoal == goal['title'];
                return _GoalCard(
                  title: goal['title'],
                  icon: goal['icon'],
                  description: goal['description'],
                  isSelected: isSelected,
                  onTap: () => onGoalSelected(goal['title']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _GoalCard({
    required this.title,
    required this.icon,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryNavy : AppColors.secondaryPastel,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: isSelected ? Colors.white : AppColors.primaryNavy,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primaryNavy : AppColors.textDarkSlate,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textDarkSlate.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
