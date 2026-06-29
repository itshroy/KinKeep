import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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

            settingsTile(
              icon: Icons.dark_mode,
              title: "Dark Mode",
              onTap: () {},
            ),

            settingsTile(
              icon: Icons.delete,
              color: Colors.red,
              title: "Reset All Data",
              onTap: () {},
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
