import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme.dart';
import '../../../models/user_model.dart';
import '../../../services/database_helper.dart';
import 'step_gender.dart';
import 'step_age.dart';
import 'step_metrics.dart';
import 'step_goal.dart';
import 'step_activity.dart';

/// OnboardingWrapper - PageView that holds all onboarding steps
class OnboardingWrapper extends StatefulWidget {
  const OnboardingWrapper({super.key});

  @override
  State<OnboardingWrapper> createState() => _OnboardingWrapperState();
}

class _OnboardingWrapperState extends State<OnboardingWrapper> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  // User data collected during onboarding
  String? _gender;
  int _age = 25;
  double _height = 170;
  double _weight = 70;
  String? _goal;
  String? _activityLevel;
  String _name = '';

  final List<String> _stepTitles = [
    'Gender',
    'Age',
    'Body Metrics',
    'Fitness Goal',
    'Activity Level',
  ];

  void _nextPage() {
    if (_currentPage < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    final user = User(
      name: _name.isEmpty ? 'User' : _name,
      gender: _gender,
      age: _age,
      height: _height,
      weight: _weight,
      goal: _goal,
      activityLevel: _activityLevel,
    );

    await DatabaseHelper.instance.insertUser(user);
    
    if (mounted) {
      context.go('/home');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: _currentPage > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.primaryNavy),
                onPressed: _previousPage,
              )
            : null,
        title: Text(
          _stepTitles[_currentPage],
          style: const TextStyle(
            color: AppColors.primaryNavy,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              children: List.generate(5, (index) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 4,
                    decoration: BoxDecoration(
                      color: index <= _currentPage
                          ? AppColors.primaryNavy
                          : AppColors.secondaryPastelBlue,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
          // PageView
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                StepGender(
                  selectedGender: _gender,
                  onGenderSelected: (gender) {
                    setState(() => _gender = gender);
                  },
                ),
                StepAge(
                  age: _age,
                  onAgeChanged: (age) {
                    setState(() => _age = age);
                  },
                ),
                StepMetrics(
                  height: _height,
                  weight: _weight,
                  onHeightChanged: (h) => setState(() => _height = h),
                  onWeightChanged: (w) => setState(() => _weight = w),
                ),
                StepGoal(
                  selectedGoal: _goal,
                  onGoalSelected: (goal) {
                    setState(() => _goal = goal);
                  },
                ),
                StepActivity(
                  selectedLevel: _activityLevel,
                  onLevelSelected: (level) {
                    setState(() => _activityLevel = level);
                  },
                ),
              ],
            ),
          ),
          // Next Button
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _canProceed() ? _nextPage : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNavy,
                  disabledBackgroundColor: AppColors.secondaryPastelBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  _currentPage == 4 ? 'Get Started' : 'Continue',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _canProceed() {
    switch (_currentPage) {
      case 0:
        return _gender != null;
      case 1:
        return _age > 0;
      case 2:
        return _height > 0 && _weight > 0;
      case 3:
        return _goal != null;
      case 4:
        return _activityLevel != null;
      default:
        return true;
    }
  }
}