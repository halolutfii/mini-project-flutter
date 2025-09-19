import 'package:cloud_firestore/cloud_firestore.dart';

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

  // Menambahkan metode copyWith
  Attendance copyWith({
    String? id,
    String? user,
    DateTime? date,
    DateTime? clockIn,
    DateTime? clockOut,
    String? status,
  }) {
    return Attendance(
      id: id ?? this.id,
      user: user ?? this.user,
      date: date ?? this.date,
      clockIn: clockIn ?? this.clockIn,
      clockOut: clockOut ?? this.clockOut,
      status: status ?? this.status,
    );
  }

  factory Attendance.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Attendance(
      id: doc.id,
      user: data['user'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      clockIn: (data['clock_in'] as Timestamp).toDate(),
      clockOut: data['clock_out'] != null ? (data['clock_out'] as Timestamp).toDate() : null,
      status: data['status'] ?? 'Present',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'date': Timestamp.fromDate(date),
      'clock_in': Timestamp.fromDate(clockIn),
      'clock_out': clockOut != null ? Timestamp.fromDate(clockOut!) : null,
      'status': status,
    };
  }
}