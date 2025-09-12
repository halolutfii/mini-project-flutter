import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: provider.formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: provider.nameController,
                decoration: const InputDecoration(labelText: "Full Name"),
                validator: (val) =>
                    val == null || val.isEmpty ? "Name required" : null,
              ),
              TextFormField(
                controller: provider.professionController,
                decoration: const InputDecoration(labelText: "Profession"),
              ),

              TextFormField(
                controller: provider.phoneController,
                decoration: const InputDecoration(labelText: "Phone"),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: provider.addressController,
                decoration: const InputDecoration(labelText: "Address"),
              ),
              TextFormField(
                controller: provider.bioController,
                decoration: const InputDecoration(labelText: "Bio"),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () async {
                        await provider.updateProfile();
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Save Changes"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}