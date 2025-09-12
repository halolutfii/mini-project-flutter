import 'package:flutter/material.dart';

import 'main.dart';
import 'screen/homescreen.dart';
import 'screen/auth/loginscreen.dart';
import 'screen/updateprofilescreen.dart';
import 'screen/attendance_request.dart';

class AppRoutes {
  static const String main = '/main';
  static const String home = '/home';
  static const String login = '/login';
  static const String updateProfile = '/updateProfile';
  static const String attendanceRequest = '/attendanceRequest';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/updateProfile':
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case '/attendanceRequest':
        return MaterialPageRoute(builder: (_) => const AttendanceRequestScreen());
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