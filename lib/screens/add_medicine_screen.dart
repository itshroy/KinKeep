import 'package:flutter/material.dart';
import '../models/medicine.dart';
import '../services/medicine_storage.dart';

class AddMedicineScreen extends StatefulWidget {
  final Medicine? medicine;
  final int? index;

  const AddMedicineScreen({super.key, this.medicine, this.index});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final TextEditingController medicineController = TextEditingController();

  final TextEditingController dosageController = TextEditingController();

  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  void initState() {
    super.initState();

    if (widget.medicine != null) {
      medicineController.text = widget.medicine!.name;
      dosageController.text = widget.medicine!.dosage;

      final parts = widget.medicine!.time.split(' ');

      final timeParts = parts[0].split(':');

      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);

      if (parts[1] == "PM" && hour != 12) {
        hour += 12;
      }

      if (parts[1] == "AM" && hour == 12) {
        hour = 0;
      }

      selectedTime = TimeOfDay(hour: hour, minute: minute);
    }
  }

  Future<void> pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,

      initialTime: selectedTime,
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),

        title: const Text(
          "Add Medicine",

          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Top Illustration
            Container(
              width: double.infinity,
              height: 180,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),

                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF6D5DF6)],
                ),
              ),

              child: const Center(
                child: Icon(
                  Icons.medication_rounded,

                  size: 90,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              "Medicine Name",

              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 12),

            buildTextField(
              controller: medicineController,
              hint: "Enter medicine name",
            ),

            const SizedBox(height: 28),

            const Text(
              "Dosage",

              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 12),

            buildTextField(
              controller: dosageController,
              hint: "Example: 500mg",
            ),

            const SizedBox(height: 28),

            const Text(
              "Reminder Time",

              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 12),

            GestureDetector(
              onTap: pickTime,

              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(20),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),

                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      selectedTime.format(context),

                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const Icon(Icons.access_time, color: Colors.blue),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 45),

            // Save Button
            Container(
              width: double.infinity,
              height: 60,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),

                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF6D5DF6)],
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.3),

                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),

              child: ElevatedButton(
                onPressed: () async {
                  Medicine medicine = Medicine(
                    name: medicineController.text,
                    dosage: dosageController.text,
                    time: selectedTime.format(context),
                  );

                  if (widget.medicine == null) {
                    // ADD NEW
                    await MedicineStorage.saveMedicine(medicine);
                  } else {
                    // UPDATE EXISTING
                    await MedicineStorage.updateMedicine(
                      widget.index!,
                      medicine,
                    );
                  }

                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        widget.medicine == null
                            ? "Medicine Saved!"
                            : "Medicine Updated!",
                      ),
                    ),
                  );

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,

                  shadowColor: Colors.transparent,
                ),

                child: Text(
                  widget.medicine == null ? "Save Medicine" : "Update Medicine",

                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,

                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,

    required String hint,
  }) {
    return TextField(
      controller: controller,

      decoration: InputDecoration(
        hintText: hint,

        filled: true,

        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
