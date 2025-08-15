import 'package:flutter/foundation.dart';
import '../models/attendance.dart';

class AttendanceProvider with ChangeNotifier {
  final List<Attendance> _records = [];
  bool _isCheckedIn = false;

  List<Attendance> get records => _records;
  bool get isCheckedIn => _isCheckedIn;

  void checkIn() {
    final now = DateTime.now();
    _records.add(
      Attendance(
        checkInTime: now,
        date: "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}",
        status: "Present",
      ),
    );
    _isCheckedIn = true;
    notifyListeners();
  }

  void checkOut() {
    if (_records.isNotEmpty) {
      final now = DateTime.now();
      final lastRecord = _records.last;
      _records[_records.length - 1] = Attendance(
        checkInTime: lastRecord.checkInTime,
        checkOutTime: now,
        date: lastRecord.date,
        status: lastRecord.status,
      );
    }
    _isCheckedIn = false;
    notifyListeners();
  }
}