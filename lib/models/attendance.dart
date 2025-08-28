class AttendanceRequest {
  final String id;
  final DateTime date;
  final String reason;
  final String request;
  String status; // Pending, Approved, Rejected

  AttendanceRequest({
    required this.id,
    required this.date,
    required this.reason,
    required this.request,
    this.status = "Pending",
  });
}