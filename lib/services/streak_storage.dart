import 'package:shared_preferences/shared_preferences.dart';

class StreakStorage {
  static const String streakKey = "streak";
  static const String lastCompletedDateKey = "lastCompletedDate";

  static Future<void> saveStreak(int streak) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(streakKey, streak);
  }

  static Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(streakKey) ?? 0;
  }

  static Future<void> saveLastCompletedDate(String date) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(lastCompletedDateKey, date);
  }

  static Future<String?> getLastCompletedDate() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(lastCompletedDateKey);
  }
}
