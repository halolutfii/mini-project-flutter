import 'package:flutter/foundation.dart';
import '../models/attendance.dart';
import '../services/attendance_service.dart';

class AttendanceProvider with ChangeNotifier {
  final AttendanceService _service = AttendanceService();

  final List<Attendance> _records = [];
  Attendance? _activeAttendance;
  bool _isCheckedIn = false;

  List<Attendance> get records => _records;
  bool get isCheckedIn => _isCheckedIn;

  // Memuat data attendance berdasarkan userId
  Future<void> loadAttendance(String userId) async {
    try {
      final data = await _service.getMyAttendance(userId);
      
      _records
        ..clear()
        ..addAll(data);

      if (_records.isNotEmpty && _records.last.clockOut == null) {
        _activeAttendance = _records.last;
        _isCheckedIn = true;
      } else {
        _activeAttendance = null;
        _isCheckedIn = false;
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error loadAttendance: $e");
    }
  }

  // Check-in berdasarkan userId
  Future<void> checkIn(String userId) async {
    try {
      final attendance = await _service.checkIn(userId);
      _records.add(attendance);
      _activeAttendance = attendance; 
      _isCheckedIn = true;
      notifyListeners();
    } catch (e) {
      debugPrint("Error checkIn: $e");
    }
  }

  // Check-out
  Future<void> checkOut() async {
    if (_activeAttendance == null) return;
    try {
      final updated = await _service.checkOut(_activeAttendance!.id);

      // Update record terakhir di list
      final index = _records.indexWhere((a) => a.id == updated.id);
      if (index != -1) {
        _records[index] = updated;
      }

      _activeAttendance = null;
      _isCheckedIn = false;
      notifyListeners();
    } catch (e) {
      debugPrint("Error checkOut: $e");
    }
  }
}