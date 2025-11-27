import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme.dart';
import '../../../models/user_model.dart';
import '../../../services/database_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _user;
  bool _isLoading = true;
  bool _isEditing = false;

  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  String _selectedGender = 'Male';
  String _selectedGoal = 'Stay Fit';
  String _selectedActivity = 'Intermediate';

  final List<String> _goals = ['Lose Weight', 'Gain Muscle', 'Stay Fit', 'Build Endurance'];
  final List<String> _activityLevels = ['Beginner', 'Intermediate', 'Advanced'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _weightController = TextEditingController();
    _heightController = TextEditingController();
    _loadUser();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  Future<void> _loadUser() async {
    final users = await DatabaseHelper.instance.getAllUsers();
    if (users.isNotEmpty) {
      setState(() {
        _user = users.first;
        _nameController.text = _user!.name;
        _ageController.text = _user!.age.toString();
        _weightController.text = _user!.weight.toString();
        _heightController.text = _user!.height.toString();
        _selectedGender = _user!.gender;
        _selectedGoal = _user!.goal;
        _selectedActivity = _user!.activityLevel;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveProfile() async {
    if (_user == null) return;
    final updatedUser = _user!.copyWith(
      name: _nameController.text,
      age: int.tryParse(_ageController.text) ?? _user!.age,
      weight: double.tryParse(_weightController.text) ?? _user!.weight,
      height: double.tryParse(_heightController.text) ?? _user!.height,
      gender: _selectedGender,
      goal: _selectedGoal,
      activityLevel: _selectedActivity,
    );
    await DatabaseHelper.instance.updateUser(updatedUser);
    setState(() {
      _user = updatedUser;
      _isEditing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated!'), backgroundColor: AppColors.primaryNavy),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.backgroundWhite,
        body: Center(child: CircularProgressIndicator(color: AppColors.primaryNavy)),
      );
    }
    if (_user == null) {
      return Scaffold(
        backgroundColor: AppColors.backgroundWhite,
        appBar: AppBar(backgroundColor: AppColors.primaryNavy, foregroundColor: Colors.white, title: const Text('Profile')),
        body: const Center(child: Text('No profile found.')),
      );
    }
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primaryNavy,
        foregroundColor: Colors.white,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text('Profile', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            onPressed: () => setState(() => _isEditing = !_isEditing),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildCard('Personal', [_buildRow('Gender', _user!.gender), _buildRow('Age', '${_user!.age} years')]),
            const SizedBox(height: 16),
            _buildCard('Body Metrics', [_buildRow('Weight', '${_user!.weight.toStringAsFixed(1)} kg'), _buildRow('Height', '${_user!.height.toStringAsFixed(0)} cm'), _buildRow('BMI', '${_user!.calculateBMI().toStringAsFixed(1)}')]),
            const SizedBox(height: 16),
            _buildCard('Fitness', [_buildRow('Goal', _user!.goal), _buildRow('Activity', _user!.activityLevel)]),
            if (_isEditing) ...[const SizedBox(height: 24), _buildSaveBtn()],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 100, height: 100,
          decoration: BoxDecoration(color: AppColors.secondaryPastelBlue, shape: BoxShape.circle, border: Border.all(color: AppColors.primaryNavy, width: 3)),
          child: const Icon(Icons.person, size: 50, color: AppColors.primaryNavy),
        ),
        const SizedBox(height: 16),
        Text(_user!.name, style: const TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryNavy)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(color: AppColors.secondaryPastelBlue.withOpacity(0.3), borderRadius: BorderRadius.circular(20)),
          child: Text(_user!.goal, style: const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: AppColors.primaryNavy)),
        ),
      ],
    );
  }

  Widget _buildCard(String title, List<Widget> rows) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.primaryNavy)),
          const SizedBox(height: 16),
          ...rows,
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: AppColors.textDarkSlate.withOpacity(0.7))),
          Text(value, style: const TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryNavy)),
        ],
      ),
    );
  }

  Widget _buildSaveBtn() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryNavy,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Save Changes', style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
