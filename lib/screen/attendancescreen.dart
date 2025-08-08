import 'package:flutter/material.dart';
import 'package:hr_attendance_tracker_app/components/footer.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  AttendanceHistoryScreen({super.key});

  // Dummy data
  final List<Map<String, String>> attendanceRecords = [
    {
      "date": "2025-08-01",
      "checkIn": "08:00 AM",
      "checkOut": "05:00 PM",
      "status": "Present",
    },
    {
      "date": "2025-08-02",
      "checkIn": "08:15 AM",
      "checkOut": "05:05 PM",
      "status": "Present",
    },
    {
      "date": "2025-08-03",
      "checkIn": "-",
      "checkOut": "-",
      "status": "Absent",
    },
    {
      "date": "2025-08-04",
      "checkIn": "08:05 AM",
      "checkOut": "04:55 PM",
      "status": "Present",
    },
    {
      "date": "2025-08-05",
      "checkIn": "08:20 AM",
      "checkOut": "05:10 PM",
      "status": "Late",
    },
    {
      "date": "2025-08-06",
      "checkIn": "08:00 AM",
      "checkOut": "05:00 PM",
      "status": "Present",
    },
  ];

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // daftar attendance
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: attendanceRecords.length,
              itemBuilder: (context, index) {
                final record = attendanceRecords[index];
                return AttendanceRecordItem(
                  date: record["date"]!,
                  checkIn: record["checkIn"]!,
                  checkOut: record["checkOut"]!,
                  status: record["status"]!,
                );
              },
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
}

// Reusable widget untuk item record
class AttendanceRecordItem extends StatelessWidget {
  final String date;
  final String checkIn;
  final String checkOut;
  final String status;

  const AttendanceRecordItem({
    super.key,
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.status,
  });

  Color _getStatusColor() {
    switch (status) {
      case "Present":
        return Colors.green;
      case "Late":
        return Colors.orange;
      case "Absent":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon() {
    switch (status) {
      case "Present":
        return Icons.check_circle;
      case "Late":
        return Icons.access_time;
      case "Absent":
        return Icons.cancel;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // biar kontras sama background
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          _getStatusIcon(),
          color: _getStatusColor(),
          size: 32,
        ),
        title: Text(
          date,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Check-in: $checkIn\nCheck-out: $checkOut"),
        trailing: Text(
          status,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _getStatusColor(),
          ),
        ),
        isThreeLine: true,
      ),
    );
  }
}