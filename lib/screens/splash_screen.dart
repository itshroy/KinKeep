import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(controller);

    scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutBack));

    controller.forward();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,

        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 900),

          pageBuilder: (_, _, _) => const LoginScreen(),

          transitionsBuilder: (_, animation, _, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [Color(0xFF0F172A), Color(0xFF1E3A8A), Color(0xFF2563EB)],
          ),
        ),

        child: Stack(
          children: [
            // Background Glow
            Positioned(
              top: -100,
              left: -50,

              child: Container(
                width: 250,
                height: 250,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),

            Positioned(
              bottom: -120,
              right: -60,

              child: Container(
                width: 300,
                height: 300,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),

            // Main Content
            Center(
              child: FadeTransition(
                opacity: fadeAnimation,

                child: ScaleTransition(
                  scale: scaleAnimation,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      // Glassmorphism Logo Card
                      Container(
                        padding: const EdgeInsets.all(30),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),

                          color: Colors.white.withValues(alpha: 0.12),

                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),

                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),

                        child: const Icon(
                          Icons.favorite_rounded,

                          size: 90,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 35),

                      // App Name
                      const Text(
                        'KinKeep',

                        style: TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Tagline
                      const Text(
                        'Care Beyond Reminders',

                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w300,
                        ),
                      ),

                      const SizedBox(height: 60),

                      // Premium Loader
                      SizedBox(
                        width: 28,
                        height: 28,

                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
