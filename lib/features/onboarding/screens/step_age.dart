import 'package:flutter/material.dart';
import '../../../core/theme.dart';

/// StepAge - Age selection screen [Ref: File 4.2]
/// Slider widget with dynamic age display
class StepAge extends StatelessWidget {
  final int age;
  final Function(int) onAgeChanged;

  const StepAge({
    super.key,
    required this.age,
    required this.onAgeChanged,
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
            'How old are you?',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.primaryNavy,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This helps us create age-appropriate workouts',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textDarkSlate.withOpacity(0.7),
            ),
          ),
          const Spacer(),
          // Large Age Display
          Center(
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.secondaryPastel.withOpacity(0.3),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryNavy,
                  width: 4,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$age',
                    style: const TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                  const Text(
                    'years',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.textDarkSlate,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          // Slider
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '14',
                    style: TextStyle(
                      color: AppColors.textDarkSlate.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '80',
                    style: TextStyle(
                      color: AppColors.textDarkSlate.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: AppColors.primaryNavy,
                  inactiveTrackColor: AppColors.secondaryPastel,
                  thumbColor: AppColors.primaryNavy,
                  overlayColor: AppColors.primaryNavy.withOpacity(0.2),
                  trackHeight: 8,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 14,
                  ),
                ),
                child: Slider(
                  value: age.toDouble(),
                  min: 14,
                  max: 80,
                  divisions: 66,
                  onChanged: (value) => onAgeChanged(value.round()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
