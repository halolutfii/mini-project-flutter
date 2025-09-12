// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../providers/user_provider.dart';
// import '../screen/auth/loginscreen.dart';

// class AppDrawer extends StatelessWidget {
//   final Function(int) onItemTap;

//   const AppDrawer({super.key, required this.onItemTap});

//   Future<void> _logout(BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('token'); // hapus token

//     // redirect ke login screen
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const LoginScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final profile = context.watch<UserProvider>().profile;

//     return Drawer(
//       backgroundColor: Colors.white,
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: const BoxDecoration(color: Color(0xFF2E3A59)),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 38,
//                   backgroundImage: profile != null && profile.image.isNotEmpty
//                       ? NetworkImage(profile.image)
//                       : const AssetImage('assets/images/lutfi.jpeg') as ImageProvider,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   profile?.name ?? 'Guest User',
//                   style: GoogleFonts.poppins(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   profile?.position ?? 'Position',
//                   style: GoogleFonts.poppins(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//            ListTile(
//             leading: const Icon(Icons.settings),
//             title: const Text('Settings'),
//             onTap: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Row(
//                     children: const [
//                       Icon(Icons.check_circle, color: Colors.white),
//                       SizedBox(width: 8),
//                       Text("Settings Clicked!"),
//                     ],
//                   ),
//                   backgroundColor: Colors.green,
//                   behavior: SnackBarBehavior.floating,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   duration: const Duration(seconds: 2),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.info),
//             title: const Text('About'),
//             onTap: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Row(
//                       children: const [
//                         Icon(Icons.check_circle, color: Colors.white),
//                         SizedBox(width: 8),
//                         Text("About Clicked!"),
//                       ],
//                     ),
//                     backgroundColor: Colors.green,
//                     behavior: SnackBarBehavior.floating,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     duration: const Duration(seconds: 2),
//                   ),
//                 );
//               },
//           ),
//           const Divider(),
//           ListTile(
//             leading: const Icon(Icons.logout, color: Colors.red),
//             title: const Text(
//               'Logout',
//               style: TextStyle(color: Colors.red),
//             ),
//             onTap: () => _logout(context),
//           ),
//         ],
//       ),
//     );
//   }
// }