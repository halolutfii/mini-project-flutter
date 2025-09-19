import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_attendance_tracker_app/providers/admin_provider.dart';
import 'package:hr_attendance_tracker_app/routes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/attendance_provider.dart';
import 'providers/attendanceRequest_provider.dart';
import 'providers/shift_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/user_provider.dart';
import 'providers/admin_provider.dart';

import 'widgets/appbar.dart';
import 'widgets/drawer.dart';
import 'screen/homescreen.dart';
import 'screen/profilescreen.dart';
import 'screen/attendancescreen.dart';
import 'screen/auth/loginscreen.dart';

import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
      await Firebase.initializeApp(
          options: FirebaseOptions(
              projectId: 'backend-hr-472113', // Project ID
              messagingSenderId: '716285922483',//Project Number
              apiKey: 'AIzaSyBpa0N-gkTEfay6mLjn3mCBoLWpdlE9AyU',//Web API Key
              appId: '1:716285922483:android:16d68e2b73707fb322b4c6'), // App ID
      );

      await Supabase.initialize(
        url: 'https://fjiwjztctrhwzwggtikx.supabase.co',
        anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZqaXdqenRjdHJod3p3Z2d0aWt4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgxMjYyNDMsImV4cCI6MjA3MzcwMjI0M30.2N1ew6cqQyrGV8gUH3ZlhLilWPhHM4Xv3qpX0MuDO8M',
      );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AttendanceProvider()),
        ChangeNotifierProvider(create: (_) => AttendanceRequestProvider()),
        ChangeNotifierProvider(create: (_) => ShiftProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

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
      initialRoute: AppRoutes.splashscreen, 
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _changeTab(int index) {
    setState(() => _currentIndex = index);
  }
  final List<Widget> _screens = [
    HomeScreen(),
    ProfileScreen(),
    AttendanceScreen(),
  ];
  final List<String> _titles = ['ESS Solecode', 'Profile Employee', 'Attendance History'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _titles[_currentIndex],
        showDrawer: true, 
        onSettings: () {   
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
      drawer: AppDrawer(
        onItemTap: _changeTab,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF2E3A59),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 213, 213, 213),
        onTap: _changeTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Attendance',
          ),
        ],
      ),
    );
  }
}