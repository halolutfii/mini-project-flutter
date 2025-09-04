import 'package:dio/dio.dart';
import 'api_service.dart';
import '../models/attendance.dart';

class AttendanceService {
  final ApiService _api = ApiService();

  Future<List<Attendance>> getMyAttendance() async {
    final res = await _api.dio.get('/attendance');

    final responseData = res.data; // ini Map<String, dynamic>
    if (responseData['data'] is List) {
      return (responseData['data'] as List)
          .map((e) => Attendance.fromJson(e))
          .toList();
    } else {
      throw Exception("Unexpected response format: ${res.data}");
    }
  }

  Future<Attendance> checkIn() async {
    final res = await _api.dio.post('/attendance/check-in');
    return Attendance.fromJson(res.data);
  }

  Future<Attendance> checkOut(String id) async {
    final res = await _api.dio.put('/attendance/checkout/$id');
    return Attendance.fromJson(res.data);
  }
}