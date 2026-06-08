class Medicine {
  String name;
  String dosage;
  String time;
  bool isTaken;

  Medicine({
    required this.name,
    required this.dosage,
    required this.time,
    this.isTaken = false,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'dosage': dosage, 'time': time, 'isTaken': isTaken};
  }

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      name: json['name'],
      dosage: json['dosage'],
      time: json['time'],
      isTaken: json['isTaken'] ?? false,
    );
  }
}
