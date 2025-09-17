import 'dart:io';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  Users? _user;
  Users? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  void setSelectedImage(File? file) {
    _selectedImage = file;
    notifyListeners();
  }

  // form key
  final formKey = GlobalKey<FormState>();

  // controllers
  final nameController = TextEditingController();
  final professionController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final bioController = TextEditingController();

  // load profile dari Firestore
  Future<void> loadProfile(String uid) async {
    _setLoading(true);
    try {
      _user = await _userService.getUserProfile(uid);

      if (_user != null) {
        nameController.text = _user!.name;
        professionController.text = _user!.profession ?? '';
        phoneController.text = _user!.phone ?? '';
        addressController.text = _user!.address ?? '';
        bioController.text = _user!.bio ?? '';
      }
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // update profile ke Firestore
  Future<void> updateProfile() async {
    if (_user == null) return;
    if (!formKey.currentState!.validate()) return;

    _setLoading(true);
    try {
      final updated = Users(
        uid: _user!.uid,
        email: _user!.email,
        name: nameController.text,
        profession: professionController.text,
        phone: phoneController.text,
        address: addressController.text,
        bio: bioController.text,
        photo: _user!.photo, // nanti bisa diganti URL upload foto
        role: _user!.role,
      );

      await _userService.updateUserProfile(updated);
      _user = updated;
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  void clearProfile() {
    _user = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    professionController.dispose();
    phoneController.dispose();
    addressController.dispose();
    bioController.dispose();
    super.dispose();
  }
}