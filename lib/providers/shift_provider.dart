import 'dart:async';
import 'package:flutter/material.dart';
import '../models/shift.dart';

class ShiftProvider with ChangeNotifier {
  final List<Shift> _requests = [];

  List<Shift> get requests => [..._requests];

  void addRequest(Shift request) {
    _requests.add(request);
    notifyListeners();

    // Simulasi approval otomatis setelah 2 detik
    Timer(const Duration(seconds: 2), () {
      request.status = "Approved";
      notifyListeners();
    });
  }
}