import 'package:flutter/material.dart';
import 'screens/onboarding_screen.dart';
import 'services/theme_storage.dart';

void main() {
  runApp(const KinKeepApp());
}

class KinKeepApp extends StatefulWidget {
  const KinKeepApp({super.key});

  static _KinKeepAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_KinKeepAppState>();
  }

  @override
  State<KinKeepApp> createState() => _KinKeepAppState();
}

class _KinKeepAppState extends State<KinKeepApp> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  Future<void> loadTheme() async {
    isDarkMode = await ThemeStorage.getTheme();
    setState(() {});
  }

  void changeTheme(bool value) async {
    await ThemeStorage.saveTheme(value);

    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.light(),

      darkTheme: ThemeData.dark(),

      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      home: const OnboardingScreen(),
    );
  }
}
