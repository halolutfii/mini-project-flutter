import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'updateprofilescreen.dart';
import '../routes.dart';

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

          final profile = profileProvider.user;
          if (profile == null) {
            return const Center(child: Text("No profile data found."));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                buildProfileHeader(context, profileProvider, profile),
                const SizedBox(height: 20),
                buildContactInfo(profile),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildProfileHeader(BuildContext context, UserProvider provider, profile) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
           // Avatar + Name
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: provider.selectedImage != null
                      ? FileImage(provider.selectedImage!)
                      : (profile != null && profile.photo != null && profile.photo!.isNotEmpty
                          ? NetworkImage(profile.photo!)
                          : null) as ImageProvider<Object>?,
                  child: (provider.selectedImage == null &&
                          (profile == null || profile.photo == null || profile.photo!.isEmpty))
                      ? const Icon(Icons.person, size: 50, color: Colors.grey)
                      : null,
                ),
                const SizedBox(height: 10),
                Text(profile.name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                if (profile.profession != null && profile.profession!.isNotEmpty)
                  Text(profile.profession!,
                      style: const TextStyle(fontSize: 16, color: Colors.black87)),
                if (profile.bio != null && profile.bio!.isNotEmpty)
                Text(
                  profile.bio!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14, color: Colors.grey, height: 1.4),
                ),
        
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E3A59),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.updateProfile);
                  },
                  child: const Text("Update Profile"),
                ),
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
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Contact Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildInfoRow(
              icon: Icons.email_outlined, label: 'Email', value: profile.email),
          if (profile.phone != null && profile.phone!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildInfoRow(
                icon: Icons.phone_outlined, label: 'Phone', value: profile.phone!),
          ],
          if (profile.address != null && profile.address!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildInfoRow(
                icon: Icons.location_on_outlined,
                label: 'Address',
                value: profile.address!),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      {required IconData icon, required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF2E3A59).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: const Color(0xFF2E3A59)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B7280))),
              const SizedBox(height: 2),
              Text(value,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937))),
            ],
          ),
        ),
      ],
    );
  }
}