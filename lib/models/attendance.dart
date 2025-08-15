class Attendance {
  final DateTime checkInTime;
  final DateTime? checkOutTime;
  final String date;
  final String status;

  Attendance({
    required this.checkInTime,
    this.checkOutTime,
    required this.date,
    required this.status,
  });
}