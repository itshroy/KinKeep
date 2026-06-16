import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/medicine.dart';

class MedicineStorage {
  static const String key = "medicines";

  static Future<void> saveMedicine(Medicine medicine) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> medicines = prefs.getStringList(key) ?? [];

    medicines.add(jsonEncode(medicine.toJson()));

    await prefs.setStringList(key, medicines);
  }

  static Future<List<Medicine>> getMedicines() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> medicines = prefs.getStringList(key) ?? [];

    print("Medicine count = ${medicines.length}");
    print(medicines);

    return medicines.map((e) => Medicine.fromJson(jsonDecode(e))).toList();
  }

  static Future<void> deleteMedicine(int index) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> medicines = prefs.getStringList(key) ?? [];

    medicines.removeAt(index);

    await prefs.setStringList(key, medicines);
  }

  static Future<void> updateMedicine(int index, Medicine medicine) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> medicines = prefs.getStringList(key) ?? [];

    print("Index = $index");
    print("Length = ${medicines.length}");

    medicines[index] = jsonEncode(medicine.toJson());

    await prefs.setStringList(key, medicines);
  }

  static Future<void> resetAllMedicines() async {
    List<Medicine> medicines = await getMedicines();

    for (var medicine in medicines) {
      medicine.isTaken = false;
    }

    final prefs = await SharedPreferences.getInstance();

    List<String> updatedMedicines = medicines
        .map((medicine) => jsonEncode(medicine.toJson()))
        .toList();

    await prefs.setStringList(key, updatedMedicines);
  }
}
