import 'package:flutter/foundation.dart';
import '../models/attendanceRequest.dart';

class AttendanceRequestProvider with ChangeNotifier {
  final List<AttendanceRequest> _requests = [];

  List<AttendanceRequest> get requests => List.unmodifiable(_requests);

  void addRequest(AttendanceRequest request) {
    _requests.add(request);
    notifyListeners();

    // Simulasi auto approve setelah 2 detik
    Future.delayed(const Duration(seconds: 2), () {
      final index = _requests.indexWhere((r) => r.id == request.id);
      if (index != -1) {
        _requests[index].status = "Approved";
        notifyListeners();
      }
    });
  }

  void rejectRequest(String id) {
    final index = _requests.indexWhere((r) => r.id == id);
    if (index != -1) {
      _requests[index].status = "Rejected";
      notifyListeners();
    }
  }
}