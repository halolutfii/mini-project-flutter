class Attendance {
  final String id;
  final String user;
  final DateTime date;
  final DateTime clockIn;
  final DateTime? clockOut; 
  final String status;

  Attendance({
    required this.id,
    required this.user,
    required this.date,
    required this.clockIn,
    this.clockOut,
    required this.status,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['_id'] ?? "",
      user: json['user'] ?? "",
      date: DateTime.parse(json['date']),
      clockIn: DateTime.parse(json['clock_in']),
      clockOut: json['clock_out'] != null ? DateTime.parse(json['clock_out']) : null,
      status: json['status'] ?? "Present",
    );
  }
}