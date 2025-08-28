import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/attendance.dart';
import '../providers/attendance_provider.dart';

class AttendanceRequestScreen extends StatefulWidget {
  const AttendanceRequestScreen({super.key});

  @override
  State<AttendanceRequestScreen> createState() => _AttendanceRequestScreenState();
}

class _AttendanceRequestScreenState extends State<AttendanceRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reasonController = TextEditingController();
  String? _selectedRequestType;

  bool isSaving = false;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isSaving = true);

      await Future.delayed(const Duration(seconds: 2)); // simulasi API

      final newRequest = AttendanceRequest(
        id: DateTime.now().toString(),
        date: DateTime.now(),
        reason: _reasonController.text,
        request: _selectedRequestType!,
      );

      Provider.of<AttendanceProvider>(context, listen: false).addRequest(newRequest);

      setState(() => isSaving = false);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text("Attendance request submitted!"),
              ],
            ),
            backgroundColor: const Color(0xFF2E3A59),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E3A59),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Attendance Request",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Request Type"),
                items: const [
                  DropdownMenuItem(value: "Leave", child: Text("Leave")),
                  DropdownMenuItem(value: "Sick Leave", child: Text("Sick Leave")),
                  DropdownMenuItem(value: "Check-In", child: Text("Check-In")),
                  DropdownMenuItem(value: "Check-Out", child: Text("Check-Out")),
                  DropdownMenuItem(value: "Remote Work", child: Text("Remote Work")),
                ],
                onChanged: (val) => _selectedRequestType = val,
                validator: (val) => val == null ? "Select request type" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _reasonController,
                decoration: const InputDecoration(labelText: "Reason"),
                validator: (val) =>
                    val == null || val.isEmpty ? "Reason is required" : null,
              ),
              const SizedBox(height: 20),
              isSaving
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E3A59)),
                    )
                  : ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E3A59),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
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