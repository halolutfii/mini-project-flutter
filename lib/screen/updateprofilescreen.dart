import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/appbar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  bool isSaving = false;

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      Provider.of<UserProvider>(context, listen: false)
          .setSelectedImage(File(picked.path));
    }
  }

  Future<void> _saveProfile(BuildContext context) async {
    final provider = Provider.of<UserProvider>(context, listen: false);

    setState(() {
      isSaving = true;
    });

    try {
      // Periksa apakah ada foto baru yang di-upload, jika ada, update foto
      if (provider.selectedImage != null) {
        await provider.updateProfileWithPhoto(newPhoto: provider.selectedImage);
      } else {
        await provider.updateProfile(); // Update tanpa foto baru
      }

      // Menampilkan SnackBar sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text("Profile updated successfully!"),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          duration: const Duration(seconds: 2),
        ),
      );

      // Langsung navigasi kembali ke ProfileScreen
      Navigator.pop(context); // Pop untuk kembali ke Profile Screen

    } catch (error) {
      print('Error updating profile: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Text("Failed to update profile. Please try again."),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    setState(() {
      isSaving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
     final provider = Provider.of<UserProvider>(context);
    final user = provider.user;

    return Scaffold(
      appBar: CustomAppBar(
        title: "Update Profile",
        onBack: () => Navigator.pop(context),
        showDrawer: false,
      ),
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: provider.formKey,
          child: Column(
            children: [
              // Avatar
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: provider.selectedImage != null
                        ? FileImage(provider.selectedImage!)
                        : (user?.photo != null && user!.photo!.isNotEmpty
                            ? NetworkImage(user.photo!)
                            : null) as ImageProvider<Object>?,
                    child: provider.selectedImage == null &&
                            (user?.photo == null || user!.photo!.isEmpty)
                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => _pickImage(context),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color(0xFF2E3A59),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Full Name
              TextFormField(
                controller: provider.nameController,
                decoration: const InputDecoration(labelText: "Full Name"),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Full Name required";
                  if (val.length < 3) return "Min 3 characters";
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Profession
              TextFormField(
                controller: provider.professionController,
                decoration: const InputDecoration(labelText: "Profession"),
                validator: (val) =>
                    val == null || val.isEmpty ? "Profession required" : null,
              ),
              const SizedBox(height: 12),

              // Phone
              TextFormField(
                controller: provider.phoneController,
                decoration: const InputDecoration(labelText: "Phone"),
                keyboardType: TextInputType.phone,
                validator: (val) =>
                    val == null || val.isEmpty ? "Phone required" : null,
              ),
              const SizedBox(height: 12),

              // Address
              TextFormField(
                controller: provider.addressController,
                decoration: const InputDecoration(labelText: "Address"),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Address required";
                  return null;
                },
              ),
              const SizedBox(height: 12),
              
              // Bio
              TextFormField(
                controller: provider.bioController,
                decoration: const InputDecoration(labelText: "Bio"),
                maxLines: 3,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Bio required";
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              isSaving || provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E3A59),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            if (provider.formKey.currentState!.validate()) {
                              await _saveProfile(context);
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Cancel"),
                                content: const Text("Are you sure you want to cancel?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx),
                                    child: const Text("No"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Yes"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}