import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Consumer<UserProvider>(
        builder: (context, profileProvider, child) {
          if (profileProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = profileProvider.profile;

          if (profile == null) {
            return const Center(child: Text("Failed to load profile"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                buildProfileHeader(context, profileProvider, profile),
                const SizedBox(height: 20),
                buildContactInfo(profile),
                const SizedBox(height: 20),
                buildLocationInfo(profile),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildProfileHeader(BuildContext context, UserProvider profileProvider, profile) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFF2E3A59)),
                onPressed: () {
                  // Navigasi ke screen update profile
                  Navigator.pushNamed(context, '/updateProfile');
                },
              ),
            ],
          ),
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: ClipOval(
                    child: profileProvider.selectedImage != null
                        ? Image.file(
                            profileProvider.selectedImage!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : profile.image.isNotEmpty
                            ? Image.network(
                                profile.image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.person, size: 50),
                  ),
                ),
                const SizedBox(height: 10),
                Text(profile.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(profile.position),
                Text(profile.department),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContactInfo(profile) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Contact Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildInfoRow(icon: Icons.email_outlined, label: 'Email', value: profile.email),
          const SizedBox(height: 12),
          _buildInfoRow(icon: Icons.phone_outlined, label: 'Phone', value: profile.phone),
        ],
      ),
    );
  }

  Widget buildLocationInfo(profile) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Location', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildInfoRow(icon: Icons.location_on_outlined, label: 'Office Location', value: profile.location),
        ],
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF2E3A59).withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: const Color(0xFF2E3A59)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF6B7280))),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1F2937))),
            ],
          ),
        ),
      ],
    );
  }
}