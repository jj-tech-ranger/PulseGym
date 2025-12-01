import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme.dart';
import '../../../models/user_model.dart';
import '../../../services/database_helper.dart';
import '../../../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  String? _selectedGender;
  String? _selectedGoal;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedGender == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a gender')),
        );
        return;
      }
      if (_selectedGoal == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a fitness goal')),
        );
        return;
      }

      final newUser = User(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text, // In a real app, hash this!
        gender: _selectedGender,
        age: int.tryParse(_ageController.text),
        weight: double.tryParse(_weightController.text),
        height: double.tryParse(_heightController.text),
        goal: _selectedGoal,
      );

      final userId = await DatabaseHelper.instance.insertUser(newUser);
      final createdUser = newUser.copyWith(id: userId);

      await AuthService().login(createdUser);

      if (mounted) {
        context.go('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        title: Text('Create Account', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => value!.length < 6 ? 'Password must be at least 6 characters' : null,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _ageController,
                      decoration: const InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? 'Please enter your age' : null,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: _weightController,
                      decoration: const InputDecoration(labelText: 'Weight (kg)'),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? 'Please enter your weight' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: 'Height (cm)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter your height' : null,
              ),
              const SizedBox(height: 30),
              Text('Gender', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 10),
              _buildGenderSelector(),
              const SizedBox(height: 30),
              Text('Fitness Goal', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 10),
              _buildGoalSelector(),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _signup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNavy,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Sign Up', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => context.go('/login'),
                child: Text(
                  'Already have an account? Login',
                  style: GoogleFonts.poppins(color: AppColors.primaryNavy),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Row(
      children: [
        _genderCard('Male', Icons.male),
        const SizedBox(width: 16),
        _genderCard('Female', Icons.female),
      ],
    );
  }

  Widget _genderCard(String gender, IconData icon) {
    final isSelected = _selectedGender == gender;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedGender = gender),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryNavy : AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primaryNavy : Colors.grey[300]!,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? Colors.white : AppColors.primaryNavy),
              const SizedBox(width: 10),
              Text(
                gender,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.primaryNavy,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoalSelector() {
    return Column(
      children: [
        _goalCard('Weight Loss', Icons.trending_down),
        const SizedBox(height: 12),
        _goalCard('Muscle Gain', Icons.fitness_center),
      ],
    );
  }

  Widget _goalCard(String goal, IconData icon) {
    final isSelected = _selectedGoal == goal;
    return GestureDetector(
      onTap: () => setState(() => _selectedGoal = goal),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryNavy : AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryNavy : Colors.grey[300]!,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : AppColors.primaryNavy, size: 30),
            const SizedBox(width: 16),
            Text(
              goal,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.primaryNavy,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
