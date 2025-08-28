class Logs {
  final DateTime checkInTime;
  final DateTime? checkOutTime;
  final String date;
  final String status;

  Logs({
    required this.checkInTime,
    this.checkOutTime,
    required this.date,
    required this.status,
  });
}