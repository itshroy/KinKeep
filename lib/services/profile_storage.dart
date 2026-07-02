import 'package:shared_preferences/shared_preferences.dart';

class ProfileStorage {
  static const String nameKey = "userName";

  static Future<void> saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(nameKey, name);
  }

  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(nameKey) ?? "Himanshi";
  }

  static Future<void> resetName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("username");
  }
}
