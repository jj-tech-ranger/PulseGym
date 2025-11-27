import 'package:flutter/material.dart';
import '../../../core/theme.dart';

/// StepGender - Gender selection screen [Ref: File 4.1]
/// Two large cards (Male/Female) with Navy Blue border on selection
class StepGender extends StatelessWidget {
  final String? selectedGender;
  final Function(String) onGenderSelected;

  const StepGender({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'What is your gender?',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.primaryNavy,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This helps us personalize your workout plan',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textDarkSlate.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _GenderCard(
                    gender: 'Male',
                    icon: Icons.male,
                    isSelected: selectedGender == 'Male',
                    onTap: () => onGenderSelected('Male'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _GenderCard(
                    gender: 'Female',
                    icon: Icons.female,
                    isSelected: selectedGender == 'Female',
                    onTap: () => onGenderSelected('Female'),
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

class _GenderCard extends StatelessWidget {
  final String gender;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderCard({
    required this.gender,
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
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondaryPastel.withOpacity(0.3) : AppColors.cardBackground,
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
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryNavy : AppColors.secondaryPastel,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 50,
                color: isSelected ? Colors.white : AppColors.primaryNavy,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              gender,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primaryNavy : AppColors.textDarkSlate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
