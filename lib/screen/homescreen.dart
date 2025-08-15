import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_attendance_tracker_app/widgets/card_attendance.dart';
import 'package:hr_attendance_tracker_app/widgets/footer.dart';
import 'package:hr_attendance_tracker_app/screen/attendancescreen.dart'; 

import '../widgets/header.dart';
import '../widgets/attendance.dart';
import '../widgets/features.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(
              name: "Lutfi Cahya Nugraha",
              profileImage: "assets/images/lutfi.jpeg", 
            ),
            buildPageHome(context),
            const SizedBox(height: 20),
            Features(),
            const SizedBox(height: 100),
            Footer()
          ],
        ),
      ),
    );
  }

  Widget buildPageHome(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF2E3A59),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header tanggal + jam
            Container(
              child: CardAttendance(), 
            ),
          ],
        ),
      ),
    );
  }
}
