import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';

import 'loginscreen.dart';
import '../../widgets/footer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  bool loading = false;

  Future<void> register() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        departmentController.text.isEmpty ||
        positionController.text.isEmpty ||
        phoneController.text.isEmpty ||
        locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field harus diisi!')),
      );
      return;
    }

    setState(() => loading = true);

    try {
      final dio = Dio(BaseOptions(
        baseUrl: "https://backend-flutter.vercel.app/api/v1",
      ));
      await dio.post("/auth/register", data: {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "department": departmentController.text.trim(),
        "position": positionController.text.trim(),
        "phone": phoneController.text.trim(),
        "location": locationController.text.trim(),
        "image": "https://res.cloudinary.com/duezfjojm/image/upload/v1756807417/mobileapp/profile/nskmxc5h2qn4hfui5tpq.png",
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Register sukses! Silakan login.')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } catch (e) {
      print("Register error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Register gagal, cek input!')),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  Widget buildTextField(String label, TextEditingController controller, {bool obscure = false}) {
    return TextField(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ), 
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E3A59),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white), 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
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
                    buildTextField("Name", nameController),
                    const SizedBox(height: 12),
                    buildTextField("Email", emailController),
                    const SizedBox(height: 12),
                    buildTextField("Password", passwordController, obscure: true),
                    const SizedBox(height: 12),
                    buildTextField("Department", departmentController),
                    const SizedBox(height: 12),
                    buildTextField("Position", positionController),
                    const SizedBox(height: 12),
                    buildTextField("Phone", phoneController),
                    const SizedBox(height: 12),
                    buildTextField("Location", locationController),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: loading ? null : register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E3A59),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: loading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                "Register",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      },
                      child: Text(
                        "Already have an account? Login",
                        style: GoogleFonts.poppins(color: const Color(0xFF2E3A59)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Footer()
          ],
        ),
      ),
    );
  }
}