import 'screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const KinKeepApp());
}

class KinKeepApp extends StatelessWidget {
  const KinKeepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OnboardingScreen(),
    );
  }
}
