import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatelessWidget {
  final Function(int) onItemTap;

  const AppDrawer({super.key, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF8F9FA),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF2E3A59),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/lutfi.jpeg'),
                ),
                const SizedBox(height: 8),
                Text(
                  'Lutfi Cahya Nugraha',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Software Engineer',
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: const [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 8),
                      Text("Settings Clicked!"),
                    ],
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: const [
                        Icon(Icons.check_circle, color: Colors.white),
                        SizedBox(width: 8),
                        Text("About Clicked!"),
                      ],
                    ),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
          ),
        ],
      ),
    );
  }
}