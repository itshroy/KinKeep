import 'add_medicine_screen.dart';
import 'package:flutter/material.dart';
import '../models/medicine.dart';
import '../services/medicine_storage.dart';
import '../services/streak_storage.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Medicine> medicines = [];

  int streak = 0;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMedicines();
  }

  Future<void> loadMedicines() async {
    medicines = await MedicineStorage.getMedicines();

    streak = await StreakStorage.getStreak();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalMedicines = medicines.length;

    int takenMedicines = medicines.where((medicine) => medicine.isTaken).length;

    double progress = totalMedicines == 0 ? 0 : takenMedicines / totalMedicines;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      floatingActionButton: Container(
        width: 70,
        height: 70,

        decoration: BoxDecoration(
          shape: BoxShape.circle,

          gradient: const LinearGradient(
            colors: [Color(0xFF2563EB), Color(0xFF4F46E5)],
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.35),

              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),

        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,

          onPressed: () async {
            await Navigator.push(
              context,

              MaterialPageRoute(
                builder: (context) => const AddMedicineScreen(),
              ),
            );
            loadMedicines();
          },

          child: const Icon(Icons.add, size: 34, color: Colors.white),
        ),
      ),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(28),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),

              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),

        child: BottomNavigationBar(
          currentIndex: 0,

          backgroundColor: Colors.transparent,

          elevation: 0,

          selectedItemColor: const Color(0xFF2563EB),

          unselectedItemColor: Colors.grey,

          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: "Schedule",
            ),

            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: const [
                      Text(
                        "Hello, Himanshi 👋",

                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 6),

                      Text(
                        "Stay healthy, stay happy!",

                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),

                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(20),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),

                              blurRadius: 10,
                            ),
                          ],
                        ),

                        child: const Icon(Icons.notifications_none, size: 28),
                      ),

                      Positioned(
                        right: 0,
                        top: 0,

                        child: Container(
                          width: 20,
                          height: 20,

                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),

                          child: const Center(
                            child: Text(
                              "3",

                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Progress Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),

                  gradient: const LinearGradient(
                    colors: [Color(0xFF2563EB), Color(0xFF6D5DF6)],
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      "Today's Progress",

                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      "$takenMedicines / $totalMedicines Medicines",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),

                      child: LinearProgressIndicator(
                        value: progress,

                        minHeight: 10,

                        backgroundColor: Colors.white24,

                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "${(progress * 100).toInt()}% Completed",

                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Stats
              Row(
                children: [
                  Expanded(
                    child: statCard(
                      icon: Icons.medication,
                      title: "Medicines",
                      value: "$totalMedicines",
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: statCard(
                      icon: Icons.local_fire_department,
                      title: "Streak",
                      value: "$streak",
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: const [
                  Text(
                    "Upcoming Medicines",

                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  Text(
                    "View all",

                    style: TextStyle(
                      color: Color(0xFF2563EB),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (medicines.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "No medicines added yet",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              else
                Column(
                  children: List.generate(medicines.length, (index) {
                    final medicine = medicines[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),

                      child: GestureDetector(
                        child: medicineCard(
                          name: medicine.name,
                          time: medicine.time,
                          subtitle: medicine.dosage,
                          color: Colors.blue,
                          index: index,
                          medicine: medicine,
                        ),
                      ),
                    );
                  }),
                ),

              const SizedBox(height: 28),

              // Health Tip Card
              Container(
                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),

                  gradient: LinearGradient(
                    colors: [Colors.green.shade50, Colors.blue.shade50],
                  ),
                ),

                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,

                      decoration: BoxDecoration(
                        color: Colors.green.shade100,

                        borderRadius: BorderRadius.circular(18),
                      ),

                      child: const Icon(
                        Icons.health_and_safety,
                        color: Colors.green,
                        size: 32,
                      ),
                    ),

                    const SizedBox(width: 16),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Health Tip",

                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            "Drink plenty of water and stay hydrated throughout the day.",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget statCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),

            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            width: 52,
            height: 52,

            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),

              borderRadius: BorderRadius.circular(16),
            ),

            child: Icon(icon, color: color),
          ),

          const SizedBox(height: 18),

          Text(
            value,

            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 5),

          Text(title, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget medicineCard({
    required String name,
    required String time,
    required String subtitle,
    required Color color,
    required int index,
    required Medicine medicine,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),

            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,

            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),

              borderRadius: BorderRadius.circular(22),
            ),

            child: Icon(Icons.medication, color: color, size: 34),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  name,

                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(time, style: const TextStyle(color: Colors.grey)),

                const SizedBox(height: 5),

                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          Column(
            children: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),

                onSelected: (value) async {
                  if (value == "edit") {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddMedicineScreen(medicine: medicine, index: index),
                      ),
                    );

                    loadMedicines();
                  } else if (value == "delete") {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Delete Medicine"),
                        content: const Text(
                          "Are you sure you want to delete this medicine?",
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
                              await MedicineStorage.deleteMedicine(index);

                              if (!context.mounted) return;

                              Navigator.of(context).pop();

                              loadMedicines();
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      ),
                    );
                  }
                },

                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "edit",
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 10),
                        Text("Edit"),
                      ],
                    ),
                  ),

                  const PopupMenuItem(
                    value: "delete",
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 10),
                        Text("Delete"),
                      ],
                    ),
                  ),
                ],
              ),

              GestureDetector(
                onTap: () async {
                  medicine.isTaken = true;

                  await MedicineStorage.updateMedicine(index, medicine);

                  bool allTaken = medicines.every((m) => m.isTaken);

                  if (allTaken) {
                    String today = DateTime.now().toString().split(' ')[0];

                    String? lastDate =
                        await StreakStorage.getLastCompletedDate();

                    if (lastDate != today) {
                      streak++;

                      await StreakStorage.saveStreak(streak);

                      await StreakStorage.saveLastCompletedDate(today);

                      print("New Streak = $streak");
                    } else {
                      print("Streak already counted today");
                    }
                  }

                  loadMedicines();
                },

                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(30),
                  ),

                  child: Text(
                    medicine.isTaken ? "Taken" : "Take",
                    style: TextStyle(
                      color: medicine.isTaken ? Colors.green : Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
