import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme.dart';
import '../../../models/workout_model.dart';
import '../../../services/database_helper.dart';

class VideoPlayerScreen extends StatefulWidget {
  final int workoutId;

  const VideoPlayerScreen({super.key, required this.workoutId});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  Workout? _workout;
  bool _isLoading = true;
  bool _isPlaying = false;
  double _progress = 0.0;
  int _currentStep = 0;
  bool _workoutCompleted = false;

  final List<Map<String, dynamic>> _exerciseSteps = [
    {'name': 'Warm Up', 'duration': 300, 'instruction': 'Light cardio to prepare your muscles'},
    {'name': 'Exercise Set 1', 'duration': 180, 'instruction': '12 reps, focus on form'},
    {'name': 'Rest', 'duration': 60, 'instruction': 'Catch your breath'},
    {'name': 'Exercise Set 2', 'duration': 180, 'instruction': '10 reps, increase intensity'},
    {'name': 'Rest', 'duration': 60, 'instruction': 'Stay hydrated'},
    {'name': 'Exercise Set 3', 'duration': 180, 'instruction': '8 reps, give it your all'},
    {'name': 'Cool Down', 'duration': 300, 'instruction': 'Stretch and relax muscles'},
  ];

  @override
  void initState() {
    super.initState();
    _loadWorkout();
  }

  Future<void> _loadWorkout() async {
    final workout = await DatabaseHelper.instance.getWorkoutById(widget.workoutId);
    setState(() {
      _workout = workout;
      _isLoading = false;
    });
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    if (_isPlaying) {
      _simulateProgress();
    }
  }

  void _simulateProgress() async {
    while (_isPlaying && _progress < 1.0) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted && _isPlaying) {
        setState(() {
          _progress += 0.005;
          _currentStep = (_progress * _exerciseSteps.length).floor().clamp(0, _exerciseSteps.length - 1);
        });
      }
    }
    if (_progress >= 1.0) {
      _completeWorkout();
    }
  }

  void _completeWorkout() {
    setState(() {
      _workoutCompleted = true;
      _isPlaying = false;
    });
  }

  void _resetWorkout() {
    setState(() {
      _progress = 0.0;
      _currentStep = 0;
      _workoutCompleted = false;
      _isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.secondaryPastelBlue,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: _workoutCompleted ? _buildCompletionScreen() : _buildVideoArea(),
            ),
            _buildControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          Text(
            _workout?.title ?? 'Workout',
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildVideoArea() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Video placeholder
        Container(
          width: double.infinity,
          height: 250,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.primaryNavy,
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.secondaryPastelBlue.withOpacity(0.3),
                AppColors.primaryNavy,
              ],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                _isPlaying ? Icons.fitness_center : Icons.play_circle_outline,
                size: 80,
                color: Colors.white.withOpacity(0.5),
              ),
              if (_isPlaying)
                const Positioned(
                  bottom: 20,
                  child: Text(
                    'Exercise in progress...',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        // Current exercise info
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text(
                _exerciseSteps[_currentStep]['name'],
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _exerciseSteps[_currentStep]['instruction'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              // Progress indicator
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: _progress,
                  minHeight: 8,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.secondaryPastelBlue,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Step ${_currentStep + 1} of ${_exerciseSteps.length}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompletionScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.secondaryPastelBlue.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              size: 80,
              color: AppColors.secondaryPastelBlue,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Workout Complete!',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Great job finishing ${_workout?.title}',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatCard('Duration', '${_workout?.duration ?? 0} min'),
              const SizedBox(width: 24),
              _buildStatCard('Calories', '${_workout?.calories ?? 0}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: AppColors.secondaryPastelBlue,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white.withOpacity(0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: _workoutCompleted
          ? Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetWorkout,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Restart',
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.go('/home'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryPastelBlue,
                      foregroundColor: AppColors.primaryNavy,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.replay_10, color: Colors.white, size: 32),
                  onPressed: () {
                    setState(() {
                      _progress = (_progress - 0.1).clamp(0.0, 1.0);
                      _currentStep = (_progress * _exerciseSteps.length).floor().clamp(0, _exerciseSteps.length - 1);
                    });
                  },
                ),
                GestureDetector(
                  onTap: _togglePlayPause,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: AppColors.secondaryPastelBlue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: AppColors.primaryNavy,
                      size: 40,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.forward_10, color: Colors.white, size: 32),
                  onPressed: () {
                    setState(() {
                      _progress = (_progress + 0.1).clamp(0.0, 1.0);
                      _currentStep = (_progress * _exerciseSteps.length).floor().clamp(0, _exerciseSteps.length - 1);
                      if (_progress >= 1.0) _completeWorkout();
                    });
                  },
                ),
              ],
            ),
    );
  }
}
