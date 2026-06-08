import 'dashboard_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              // Main Login Card
              Container(
                width: 350,

                padding: const EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 40,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,

                  border: Border.all(color: Colors.grey.shade300),
                ),

                child: Column(
                  children: [
                    // Logo Text
                    const Text(
                      "KinKeep",

                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'cursive',
                      ),
                    ),

                    const SizedBox(height: 35),

                    // Email Field
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Email or Username",

                        filled: true,

                        fillColor: const Color(0xFFFAFAFA),

                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),

                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),

                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Password Field
                    TextField(
                      obscureText: true,

                      decoration: InputDecoration(
                        hintText: "Password",

                        filled: true,

                        fillColor: const Color(0xFFFAFAFA),

                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),

                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),

                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 45,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0095F6),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),

                        onPressed: () {
                          Navigator.pushReplacement(
                            context,

                            MaterialPageRoute(
                              builder: (context) => const DashboardScreen(),
                            ),
                          );
                        },

                        child: const Text(
                          "Log In",

                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // OR Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade400)),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),

                          child: Text(
                            "OR",

                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(child: Divider(color: Colors.grey.shade400)),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // Google Login
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Icon(Icons.g_mobiledata, color: Colors.blue, size: 32),

                        SizedBox(width: 5),

                        Text(
                          "Login with Google",

                          style: TextStyle(
                            color: Color(0xFF385185),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // Forgot Password
                    const Text(
                      "Forgot password?",

                      style: TextStyle(color: Color(0xFF00376B), fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // Signup Card
              Container(
                width: 350,
                padding: const EdgeInsets.symmetric(vertical: 22),

                decoration: BoxDecoration(
                  color: Colors.white,

                  border: Border.all(color: Colors.grey.shade300),
                ),

                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text("Don't have an account? "),

                    Text(
                      "Sign up",

                      style: TextStyle(
                        color: Color(0xFF0095F6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
