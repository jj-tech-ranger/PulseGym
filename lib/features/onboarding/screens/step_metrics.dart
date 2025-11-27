import 'package:flutter/material.dart';
import '../../../core/theme.dart';

/// StepMetrics - Height and Weight selection [Ref: Files 4.3 & 4.4]
class StepMetrics extends StatelessWidget {
  final double height;
  final double weight;
  final Function(double) onHeightChanged;
  final Function(double) onWeightChanged;

  const StepMetrics({
    super.key,
    required this.height,
    required this.weight,
    required this.onHeightChanged,
    required this.onWeightChanged,
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
            'Your Body Metrics',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.primaryNavy,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Help us calculate your fitness metrics',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textDarkSlate.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 40),
          // Height Section
          _MetricCard(
            title: 'Height',
            value: height.round(),
            unit: 'cm',
            min: 120,
            max: 220,
            onChanged: onHeightChanged,
            icon: Icons.height,
          ),
          const SizedBox(height: 24),
          // Weight Section
          _MetricCard(
            title: 'Weight',
            value: weight.round(),
            unit: 'kg',
            min: 30,
            max: 200,
            onChanged: onWeightChanged,
            icon: Icons.monitor_weight_outlined,
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final int value;
  final String unit;
  final double min;
  final double max;
  final Function(double) onChanged;
  final IconData icon;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.secondaryPastel.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primaryNavy, size: 24),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDarkSlate,
                ),
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$value',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryNavy,
                      ),
                    ),
                    TextSpan(
                      text: ' $unit',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textDarkSlate.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.primaryNavy,
              inactiveTrackColor: AppColors.secondaryPastel,
              thumbColor: AppColors.primaryNavy,
              overlayColor: AppColors.primaryNavy.withOpacity(0.2),
              trackHeight: 6,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            ),
            child: Slider(
              value: value.toDouble(),
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${min.round()} $unit',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textDarkSlate.withOpacity(0.5),
                ),
              ),
              Text(
                '${max.round()} $unit',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textDarkSlate.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
