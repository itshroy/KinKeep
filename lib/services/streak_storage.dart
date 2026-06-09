import 'package:shared_preferences/shared_preferences.dart';

class StreakStorage {
  static const String streakKey = "streak";

  static Future<void> saveStreak(int streak) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(streakKey, streak);
  }

  static Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(streakKey) ?? 0;
  }
}
