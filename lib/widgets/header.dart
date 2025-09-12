// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/user_provider.dart';

// class Header extends StatefulWidget {
//   const Header({Key? key}) : super(key: key);

//   @override
//   _HeaderState createState() => _HeaderState();
// }

// class _HeaderState extends State<Header> {
//   late DateTime now;
//   Timer? timer;

//   @override
//   void initState() {
//     super.initState();
//     now = DateTime.now();
//     timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       setState(() {
//         now = DateTime.now();
//       });
//     });

//     // Load user data saat widget pertama kali dibangun
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final userProvider = Provider.of<UserProvider>(context, listen: false);
//       userProvider.loadUser();
//     });
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   String getGreeting() {
//     final hour = now.hour;
//     if (hour < 12) return "Good Morning";
//     if (hour < 17) return "Good Afternoon";
//     return "Good Evening";
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);
//     final profile = userProvider.profile;

//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.all(20),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: const Color(0xFF2E3A59),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: userProvider.isLoading
//           ? const Center(
//               child: CircularProgressIndicator(color: Colors.white),
//             )
//           : Row(
//               children: [
//                 // Bagian teks
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "${getGreeting()}, ${profile?.name ?? 'Guest User'}",
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       const Text(
//                         "Have a great day at work!",
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Foto profil
//                 CircleAvatar(
//                   radius: 28,
//                   backgroundImage: profile != null && profile.image.isNotEmpty
//                       ? NetworkImage(profile.image)
//                       : const AssetImage('assets/images/lutfi.jpeg') as ImageProvider,
//                   backgroundColor: Colors.grey[200],
//                 ),
//               ],
//             ),
//     );
//   }
// }