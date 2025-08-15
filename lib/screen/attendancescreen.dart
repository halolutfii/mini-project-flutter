import 'package:flutter/material.dart';
import 'package:hr_attendance_tracker_app/widgets/footer.dart';
import 'package:provider/provider.dart';
import '../providers/attendance_provider.dart';
import '../models/attendance.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  String _formatTime(DateTime? time) {
    if (time == null) return "-";
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  String _formatDate(dynamic date) {
  if (date == null) return "-";

  if (date is String) {
      try {
        final parsed = DateTime.parse(date);
        return "${parsed.day.toString().padLeft(2, '0')}-${parsed.month.toString().padLeft(2, '0')}-${parsed.year}";
      } catch (_) {
        return date; 
      }
    } else if (date is DateTime) {
      return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
    }

    return "-";
  }

  IconData _getStatusIcon(String? status) {
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

  Color _getStatusColor(String? status) {
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

  @override
  Widget build(BuildContext context) {
    final attendanceProvider = Provider.of<AttendanceProvider>(context);
    final List<Attendance> records = attendanceProvider.records;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              final date = _formatDate(record.date);
              final checkIn = _formatTime(record.checkInTime);
              final checkOut = _formatTime(record.checkOutTime);
              final status = record.status ?? "Unknown";

              return Card(
                color: Colors.white,
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(
                    _getStatusIcon(status),
                    color: _getStatusColor(status),
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
                      color: _getStatusColor(status),
                    ),
                  ),
                  isThreeLine: true,
                ),
              );
            },
          ),
        ),

        Footer()
      ],
      ),
    );
  }
}