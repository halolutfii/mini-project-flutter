import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'updateprofilescreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    if (provider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.user == null) {
      return const Scaffold(
        body: Center(child: Text("No profile data found.")),
      );
    }

    final profile = provider.user!;

    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  profile.photo != null ? NetworkImage(profile.photo!) : null,
              child: profile.photo == null
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              profile.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (profile.profession != null)
              Text(
                profile.profession!,
                style: TextStyle(color: Colors.grey[700]),
              ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(profile.email),
            ),

            if (profile.phone != null)
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text(profile.phone!),
              ),
            if (profile.address != null)
              ListTile(
                leading: const Icon(Icons.location_on),
                title: Text(profile.address!),
              ),
            if (profile.bio != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(profile.bio!),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,  MaterialPageRoute(
                    builder: (_) => const EditProfileScreen(),
                  ),
                );
              },
              child: const Text("Edit Profile"),
            )
          ],
        ),
      ),
    );
  }
}