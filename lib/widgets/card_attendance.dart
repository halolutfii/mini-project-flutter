import 'dart:async';
import 'package:flutter/material.dart';

import 'attendance.dart';

class CardAttendance extends StatefulWidget {
  @override
  _CardAttendanceState createState() => _CardAttendanceState();
}

class _CardAttendanceState extends State<CardAttendance> {
  late DateTime now;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        "${getDayName(now.weekday)}, ${now.day} ${getMonthName(now.month)} ${now.year}";
    final String formattedTime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Today",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          Text(
            "$formattedDate | $formattedTime",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 10),
          
          Attendance(), 
        ],
      ),
    );
  }
}

String getDayName(int weekday) {
  const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  return days[weekday - 1];
}

String getMonthName(int month) {
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  return months[month - 1];
}
