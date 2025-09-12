import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/footer.dart';
import '../../routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

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
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Create Your Account',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2E3A59),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      buildTextField("Name", _usernameController),
                      const SizedBox(height: 12),
                      buildTextField("Email", _emailController),
                      const SizedBox(height: 12),
                      buildTextField("Password", _passwordController, obscure: true),
                      const SizedBox(height: 20),

                      // Register button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => _isLoading = true);
                                    try {
                                      final success = await authProvider.registerWithEmail(
                                        _emailController.text.trim(),
                                        _passwordController.text.trim(),
                                        userProvider,
                                      );

                                      if (success && userProvider.user != null) {
                                        Navigator.pushReplacementNamed(context, AppRoutes.home);
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Register failed: $e")),
                                      );
                                    } finally {
                                      setState(() => _isLoading = false);
                                    }
                                  }
                                },
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("Register", style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Already have account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Sudah punya akun? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, AppRoutes.login);
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}