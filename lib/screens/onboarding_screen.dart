import 'login_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();

  int currentIndex = 0;

  final List<Map<String, String>> pages = [
    {
      "title": "Track Medicines Easily",
      "subtitle": "Manage daily medicines with smart tracking and reminders.",
    },

    {
      "title": "Never Miss a Dose",
      "subtitle": "Get timely notifications and stay healthy every day.",
    },

    {
      "title": "Care For Loved Ones",
      "subtitle": "Monitor medicine schedules for your family members.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,

                itemCount: pages.length,

                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },

                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        // Illustration Container
                        Container(
                          height: 220,
                          width: 220,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),

                            gradient: const LinearGradient(
                              colors: [Color(0xFF2563EB), Color(0xFF4F46E5)],

                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withValues(alpha: 0.3),

                                blurRadius: 30,
                                offset: const Offset(0, 15),
                              ),
                            ],
                          ),

                          child: const Icon(
                            Icons.favorite_rounded,

                            size: 120,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 60),

                        // Title
                        Text(
                          pages[index]["title"]!,

                          textAlign: TextAlign.center,

                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Subtitle
                        Text(
                          pages[index]["subtitle"]!,

                          textAlign: TextAlign.center,

                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white.withValues(alpha: 0.7),

                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: List.generate(pages.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),

                  margin: const EdgeInsets.symmetric(horizontal: 5),

                  height: 10,

                  width: currentIndex == index ? 28 : 10,

                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? Colors.white
                        : Colors.white38,

                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),

            const SizedBox(height: 40),

            // Button
            Padding(
              padding: const EdgeInsets.only(bottom: 40),

              child: Center(
                child: Container(
                  width: 170,
                  height: 52,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),

                    gradient: const LinearGradient(
                      colors: [Color(0xFF2563EB), Color(0xFF4F46E5)],
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.35),

                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),

                  child: Material(
                    color: Colors.transparent,

                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),

                      onTap: () {
                        if (currentIndex < pages.length - 1) {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),

                            curve: Curves.easeInOut,
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,

                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        }
                      },

                      child: Center(
                        child: Text(
                          currentIndex == pages.length - 1
                              ? "Get Started"
                              : "Next",

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
