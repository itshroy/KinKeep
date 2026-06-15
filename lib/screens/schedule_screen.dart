import 'package:flutter/material.dart';
import '../models/medicine.dart';
import '../services/medicine_storage.dart';
import 'package:intl/intl.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<Medicine> medicines = [];

  @override
  void initState() {
    super.initState();
    loadMedicines();
  }

  Future<void> loadMedicines() async {
    medicines = await MedicineStorage.getMedicines();
    medicines.sort((a, b) {
      DateTime timeA = DateFormat.jm().parse(a.time);
      DateTime timeB = DateFormat.jm().parse(b.time);

      return timeA.compareTo(timeB);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Today's Schedule")),

      body: medicines.isEmpty
          ? const Center(child: Text("No medicines added"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                final medicine = medicines[index];

                return Card(
                  elevation: 3,

                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: ListTile(
                    leading: Icon(
                      Icons.medication,
                      color: medicine.isTaken ? Colors.green : Colors.blue,
                      size: 30,
                    ),

                    title: Text(
                      medicine.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    subtitle: Text(
                      medicine.dosage,
                      style: const TextStyle(fontSize: 14),
                    ),

                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          medicine.time,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          medicine.isTaken ? "Taken" : "Pending",
                          style: TextStyle(
                            color: medicine.isTaken
                                ? Colors.green
                                : Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
