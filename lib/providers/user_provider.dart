import 'dart:io';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  User? _profile;
  final UserService _userService = UserService();
  bool _isLoading = false;

  User? get profile => _profile;
  bool get isLoading => _isLoading;

  Future<void> loadUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      _profile = await _userService.fetchUser();
    } catch (e) {
      print('Error loading user: $e');
      _profile = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// ✅ Update profile
  Future<void> updateProfile(User updatedUser) async {
    _isLoading = true;
    notifyListeners();

    try {
      _profile = await _userService.updateUser(updatedUser);
    } catch (e) {
      print("Error updating profile: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearUser() {
    _profile = null;
    notifyListeners();
  }

  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  void setSelectedImage(File image) {
    _selectedImage = image;
    notifyListeners();
  }

  /// ✅ Helper buat ambil foto profil
  ImageProvider getProfileImage() {
    if (_selectedImage != null) {
      return FileImage(_selectedImage!);
    } else if (_profile?.image.isNotEmpty == true) {
      return NetworkImage(_profile!.image);
    } else {
      return const AssetImage('assets/images/default_avatar.png');
    }
  }
}