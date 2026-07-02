import 'package:flutter/material.dart';
import '../services/theme_storage.dart';
import '../main.dart';
import '../services/medicine_storage.dart';
import '../services/streak_storage.dart';
import '../services/profile_storage.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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

  Future<void> resetAllData() async {
    await MedicineStorage.clearAllMedicines();
    await StreakStorage.resetStreak();
    await ProfileStorage.resetName();

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("All data has been reset.")));
  }

  Widget settingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),

      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            settingsTile(icon: Icons.person, title: "Edit Name", onTap: () {}),

            Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text(
                  "Dark Mode",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });

                    KinKeepApp.of(context)?.changeTheme(value);
                  },
                ),
              ),
            ),

            settingsTile(
              icon: Icons.delete,
              color: Colors.red,
              title: "Reset All Data",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Reset App"),
                    content: const Text(
                      "This will delete all medicines, streak and profile data. Continue?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () async {
                          await MedicineStorage.clearAllMedicines();
                          await StreakStorage.resetStreak();
                          await ProfileStorage.resetName();

                          if (!mounted) return;

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("All data has been reset."),
                            ),
                          );
                        },
                        child: const Text("Reset"),
                      ),
                    ],
                  ),
                );
              },
            ),

            settingsTile(
              icon: Icons.info_outline,
              title: "About KinKeep",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
