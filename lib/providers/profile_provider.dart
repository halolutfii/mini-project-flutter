import 'dart:io';
import 'package:flutter/material.dart';
import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  Profile profile = Profile(
    name: "Lutfi Cahya Nugraha",
    position: "Junior Software Engineer",
    department: "IT Development",
    email: "lutfi.cahya@solecode.id",
    phone: "+62 821-1083-3753",
    location: "Tangerang Selatan, Indonesia",
    image: 'assets/images/lutfi.jpeg',
  );

  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  void setSelectedImage(File image) {
    _selectedImage = image;
    notifyListeners();
  }

  void updateProfile(Profile updatedProfile) {
    profile = updatedProfile;
    _selectedImage = null;
    notifyListeners();
  }
}