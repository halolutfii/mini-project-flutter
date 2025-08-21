import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../models/profile.dart';
import '../providers/profile_provider.dart';
import '../widgets/appbar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController positionController;
  late TextEditingController departmentController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController locationController;

  bool isSaving = false;

  final List<String> positions = [
    "Junior Software Engineer",
    "Software Engineer",
    "Senior Software Engineer",
    "Team Lead",
    "HR",
  ];

  final List<String> departments = [
    "IT Development",
    "HR",
    "Finance",
    "Marketing",
    "Sales",
  ];

  final phoneMask = MaskTextInputFormatter(
      mask: '+62 ###-####-####', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    super.initState();
    final profile = Provider.of<ProfileProvider>(context, listen: false).profile;

    nameController = TextEditingController(text: profile.name);
    positionController = TextEditingController(text: profile.position);
    departmentController = TextEditingController(text: profile.department);
    emailController = TextEditingController(text: profile.email);
    phoneController = TextEditingController(text: profile.phone);
    locationController = TextEditingController(text: profile.location);
  }

  @override
  void dispose() {
    nameController.dispose();
    positionController.dispose();
    departmentController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    super.dispose();
  }

  Future<void> pickImage(ProfileProvider provider) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      provider.setSelectedImage(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    final profile = provider.profile;

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
          key: _formKey,
          child: Column(
            children: [
              // Avatar
              CircleAvatar(
                radius: 50,
                child: ClipOval(
                  child: provider.selectedImage != null
                      ? Image.file(
                          provider.selectedImage!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          profile.image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => pickImage(provider),
                icon: const Icon(Icons.camera_alt, size: 20, color: Colors.white),
                label: const Text(
                  "Change Photo",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E3A59),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Full Name
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Full Name"),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Full Name is required";
                  if (val.length < 3) return "Min 3 characters";
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Position
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Position"),
                dropdownColor: Colors.white,
                value: positionController.text.isNotEmpty ? positionController.text : null,
                items: positions
                    .map((pos) => DropdownMenuItem(
                          value: pos,
                          child: Text(pos),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) positionController.text = val;
                },
                validator: (value) =>
                    value == null || value.isEmpty ? "Please select a position" : null,
              ),

              const SizedBox(height: 12),

              // Department
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Department'),
                dropdownColor: Colors.white,
                value: departmentController.text.isNotEmpty ? departmentController.text : null,
                items: ['IT Development', 'HR', 'Finance', 'Marketing']
                    .map((dep) => DropdownMenuItem(
                          value: dep,
                          child: Text(dep),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    departmentController.text = val ?? '';
                  });
                },
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select a department'
                    : null,
              ),

              const SizedBox(height: 12),

              // Email
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Email is required";
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                      .hasMatch(val)) return "Enter valid email";
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Phone
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [phoneMask],
                decoration: const InputDecoration(labelText: "Phone"),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Phone is required";
                  if (!phoneMask.isFill()) return "Phone format: +62 812-3456-7890";
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Location
              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(labelText: "Location"),
              ),
              const SizedBox(height: 20),

              // Buttons
              isSaving
                  ? const CircularProgressIndicator()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Save Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E3A59),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => isSaving = true);

                              final updatedProfile = Profile(
                                name: nameController.text,
                                position: positionController.text,
                                department: departmentController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                location: locationController.text,
                                image: provider.selectedImage != null
                                    ? provider.selectedImage!.path
                                    : provider.profile.image,
                              );

                              await Future.delayed(const Duration(seconds: 1));

                              provider.updateProfile(updatedProfile);

                              setState(() => isSaving = false);

                              Navigator.pop(context);

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

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => Theme(
                                data: Theme.of(context).copyWith(
                                  dialogBackgroundColor: Colors.white,
                                  colorScheme: const ColorScheme.light(
                                    primary: Color(0xFF2E3A59),
                                    onPrimary: Colors.white,
                                    onSurface: Colors.black,
                                  ),
                                ),
                                child: AlertDialog(
                                  title: const Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  content: const Text(
                                    "Are you sure you want to cancel?",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx),
                                      child: const Text(
                                        "No",
                                        style: TextStyle(color: Color(0xFF2E3A59)),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(color: Color(0xFF2E3A59)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Cancel',
                            style:
                                TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
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