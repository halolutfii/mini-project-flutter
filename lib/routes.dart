import 'package:flutter/material.dart';

import 'main.dart';
import 'screen/auth/splashscreen.dart';
import 'screen/homescreen.dart';
import 'screen/auth/loginscreen.dart';
import 'screen/updateprofilescreen.dart';
import 'screen/attendance_request.dart';
import 'screen/pages/admin/dashboardscreen.dart';
import 'screen/pages/admin/addEmployee.dart';

class AppRoutes {
  static const String main = '/main';
  static const String splashscreen = 'splashscreen';
  static const String home = '/home';
  static const String login = '/login';
  static const String updateProfile = '/updateProfile';
  static const String attendanceRequest = '/attendanceRequest';
  static const String adminDashboard = '/adminDashboard';
  static const String addEmployee = '/addEmployee';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case splashscreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case updateProfile:
        return MaterialPageRoute(builder: (_) => UpdateProfileScreen());
      case attendanceRequest:
        return MaterialPageRoute(builder: (_) => AttendanceRequestScreen());
      case adminDashboard:
        return MaterialPageRoute(builder: (_) => AdminDashboardScreen());
      case addEmployee:
        return MaterialPageRoute(builder: (_) => EmployeeAddScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}