import 'package:flutter/material.dart';
import '../models/medicine.dart';
import '../services/medicine_storage.dart';

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
                  margin: const EdgeInsets.only(bottom: 12),

                  child: ListTile(
                    leading: const Icon(Icons.medication, color: Colors.blue),

                    title: Text(medicine.name),

                    subtitle: Text(medicine.dosage),

                    trailing: Text(
                      medicine.time,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
