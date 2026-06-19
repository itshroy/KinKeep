import 'package:flutter/material.dart';
import '../services/streak_storage.dart';
import '../services/medicine_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

Widget profileCard(IconData icon, String title, String value, Color color) {
  return Container(
    padding: const EdgeInsets.all(20),

    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),

      boxShadow: [
        BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10),
      ],
    ),

    child: Row(
      children: [
        Icon(icon, color: color, size: 30),

        const SizedBox(width: 15),

        Expanded(child: Text(title, style: const TextStyle(fontSize: 18))),

        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

class _ProfileScreenState extends State<ProfileScreen> {
  int streak = 0;
  int takenCount = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    streak = await StreakStorage.getStreak();

    final medicines = await MedicineStorage.getMedicines();

    takenCount = medicines.where((m) => m.isTaken).length;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),

            const SizedBox(height: 16),

            const Text(
              "Himanshi",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            profileCard(
              Icons.local_fire_department,
              "Current Streak",
              "$streak Days",
              Colors.orange,
            ),

            const SizedBox(height: 15),

            profileCard(
              Icons.medication,
              "Medicines Taken",
              "$takenCount",
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
