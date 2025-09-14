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

  Future<void> loadEmployees() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _employees = await _service.getEmployees();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

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
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEmployee(String uid) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _service.deleteEmployee(uid);
      _employees.removeWhere((e) => e.uid == uid);
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
}