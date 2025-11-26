import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import 'goal_screen.dart';

class HeightScreen extends StatefulWidget {
  final String name;
  final String gender;
  final int age;
  final int weight;

  const HeightScreen({
    Key? key,
    required this.name,
    required this.gender,
    required this.age,
    required this.weight,
  }) : super(key: key);

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  double _height = 170.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What\'s your height?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'This helps us create your perfect plan',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 60),
              Center(
                child: Column(
                  children: [
                    Text(
                      '${_height.toInt()}',
                      style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      'cm',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: AppColors.secondary.withOpacity(0.3),
                  thumbColor: AppColors.primary,
                  overlayColor: AppColors.primary.withOpacity(0.2),
                  trackHeight: 4,
                ),
                child: Slider(
                  value: _height,
                  min: 100,
                  max: 250,
                  divisions: 150,
                  onChanged: (value) {
                    setState(() {
                      _height = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '100 cm',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  Text(
                    '250 cm',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoalScreen(
                          name: widget.name,
                          gender: widget.gender,
                          age: widget.age,
                          weight: widget.weight,
                          height: _height.toInt(),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
