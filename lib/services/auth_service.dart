import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'database_helper.dart';

class AuthService {
  static const String _userKey = 'currentUser';

  Future<User?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt(_userKey);
    if (userId != null) {
      return await DatabaseHelper.instance.getUserById(userId);
    }
    return null;
  }

  Future<void> login(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userKey, user.id!);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
