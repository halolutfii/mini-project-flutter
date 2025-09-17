import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/admin_provider.dart';

import '../../../widgets/appbar.dart';

class EmployeeAddScreen extends StatefulWidget {
  const EmployeeAddScreen({super.key});

  @override
  State<EmployeeAddScreen> createState() => _EmployeeAddScreenState();
}

class _EmployeeAddScreenState extends State<EmployeeAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget buildTextField(String label, TextEditingController controller, {bool obscure = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: GoogleFonts.poppins(),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "$label tidak boleh kosong";
        if (label == "Password" && value.length < 6) return "Password minimal 6 karakter";
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomAppBar(
        title: "Add New Employee",
        onBack: () => Navigator.pop(context),
        showDrawer: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      buildTextField("Name", _nameController),
                      const SizedBox(height: 12),
                      buildTextField("Email", _emailController),
                      const SizedBox(height: 12),
                      buildTextField("Password", _passwordController, obscure: _obscurePassword),
                      const SizedBox(height: 20),

                      // Button Add Employee
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => _isLoading = true);
                                    try {
                                      await adminProvider.addEmployee(
                                        _emailController.text.trim(),
                                        _passwordController.text.trim(),
                                        _nameController.text.trim(),
                                      );

                                      if (mounted) {
                                        if (adminProvider.errorMessage == null) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Employee created successfully"),
                                            ),
                                          );
                                          Navigator.pop(context);
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(adminProvider.errorMessage!),
                                            ),
                                          );
                                        }
                                      }
                                    } finally {
                                      if (mounted) setState(() => _isLoading = false);
                                    }
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E3A59),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  "Create Employee",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}