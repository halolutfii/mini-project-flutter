import 'package:flutter/foundation.dart';
import '../models/attendance.dart';

class AttendanceProvider with ChangeNotifier {
  final List<AttendanceRequest> _requests = [];

  List<AttendanceRequest> get requests => _requests;

  void addRequest(AttendanceRequest request) {
    _requests.add(request);
    notifyListeners();

    // Simulasi auto approve setelah 2 detik
    Future.delayed(const Duration(seconds: 2), () {
      request.status = "Approved";
      notifyListeners();
    });
  }
}
