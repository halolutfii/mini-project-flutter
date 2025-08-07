import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

  // Data Profil
  const String name = "Lutfi Cahya Nugraha";
  const String position = "Junior Software Engineer";
  const String dept = "IT Development";
  const String email = "lutfi.cahya@solecode.id";
  const String phone = "+62 821-1083-3753";
  const String location = "Tangerang Selatan, Indonesia";
  const String emp_id = "28072025";

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: const ProfileScreen(),
      );
    }
  }

  class ProfileScreen extends StatelessWidget {
    const ProfileScreen({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        backgroundColor: Color(0xFFF8F9FA),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF2E3A59),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // Aksi saat diklik
            },
          ),
          title: Text(
            'Profile Employee Solecode',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildDateHeader(),
              const SizedBox(height: 20),
              buildProfileHeader(),
              const SizedBox(height: 20),
              buildContactInfo(),
              const SizedBox(height: 20),
              buildLocationInfo(),
              const SizedBox(height: 110),
              buildFooter(),
            ],
          ),
        ),
      );
    }
  }

  // Date Header
  Widget buildDateHeader() {
    final DateTime now = DateTime.now();
    final String formattedDate =
        "${getDayName(now.weekday)}, ${now.day} ${getMonthName(now.month)} ${now.year}";

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      color: Colors.white, // Background putih
      child: Text(
        "Today: $formattedDate",
        style: const TextStyle(
          color: Colors.black, // Tulisan hitam
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Profile Header
  Widget buildProfileHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
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
        crossAxisAlignment: CrossAxisAlignment.start, // Sama seperti contactInfo
        children: [
          Center( // Biar avatar dan nama tetap di tengah
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/lutfi.jpeg'),
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  emp_id,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  position,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  dept,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Contact Employee
  Widget buildContactInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E3A59),
            ),
          ),
          
          SizedBox(height: 16),
          
          // Email
          _buildInfoRow(
            icon: Icons.email_outlined,
            label: 'Email',
            value: email,
          ),
          
          SizedBox(height: 12),
          
          // Phone
          _buildInfoRow(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: phone,
          ),
        ],
      ),
    );
  }

  // Location information
  Widget buildLocationInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E3A59),
            ),
          ),
          
          SizedBox(height: 16),
          
          _buildInfoRow(
            icon: Icons.location_on_outlined,
            label: 'Office Location',
            value: location,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF2E3A59).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: Color(0xFF2E3A59),
          ),
        ),
        
        SizedBox(width: 12),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),
              
              SizedBox(height: 2),
              
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Footer
  Widget buildFooter() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        'HR Attendance Tracker v1.0',
        style: TextStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

   // Helper functions for date formatting
  String getDayName(int weekday) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[weekday - 1];
  }

  String getMonthName(int month) {
    const months = ['January', 'February', 'March', 'April', 'May', 'June',
          'July', 'August', 'September', 'October', 'November', 'December'];
    return months[month - 1];
  }