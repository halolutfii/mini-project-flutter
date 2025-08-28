import 'dart:io';
import 'package:flutter/material.dart';
import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  Profile _profile = Profile(
    name: "Lutfi Cahya Nugraha",
    position: "Junior Software Engineer",
    department: "IT Development",
    email: "lutfi.cahya@solecode.id",
    phone: "+62 821-1083-3753",
    location: "Tangerang Selatan, Indonesia",
    image: 'assets/images/lutfi.jpeg',
  );

  File? selectedImage;

  Profile get profile => _profile;

  void updateProfile(Profile newProfile) {
    _profile = newProfile;
    notifyListeners();
  }

  void updateImage(File image) {
    selectedImage = image;
    notifyListeners();
  }

  /// dipakai di UI
  ImageProvider getProfileImage() {
    if (selectedImage != null) {
      return FileImage(selectedImage!);
    } else if (_profile.image.startsWith("assets/")) {
      return AssetImage(_profile.image);
    } else {
      return FileImage(File(_profile.image));
    }
  }
}