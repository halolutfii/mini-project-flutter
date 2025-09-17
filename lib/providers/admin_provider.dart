import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class AdminProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final UserService _service = UserService();

  List<Users> _employees = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Users> get employees => _employees;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Ambil ulang semua employees dari Firestore
  Future<void> loadEmployees() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetched = await _service.getEmployees();
      debugPrint("✅ Employees fetched: ${fetched.length}");
      _employees
        ..clear()
        ..addAll(fetched);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Tambah employee baru, lalu push ke list lokal juga
  Future<void> addEmployee(String email, String password, String name) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newEmployee = await _service.createEmployee(
        email: email,
        password: password,
        name: name,
      );
      _employees.add(newEmployee);
      debugPrint("👤 New employee added: ${newEmployee.name}");
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Hapus employee by UID
  Future<void> deleteEmployee(String uid) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _service.deleteEmployee(uid);
      _employees.removeWhere((e) => e.uid == uid);
      debugPrint("🗑️ Employee deleted: $uid");
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  /// Reset semua state (dipanggil waktu logout)
  void clearEmployees() {
    _employees.clear();
    _errorMessage = null;
    notifyListeners();
  }
}