class Shift {
  final String id;
  final DateTime date;
  final String type; // contoh: Morning, Evening, dll
  String status; // Pending / Approved

  Shift({
    required this.id,
    required this.date,
    required this.type,
    this.status = "Pending",
  });
}