import 'package:flutter/material.dart';

import 'screen/updateprofilescreen.dart';
import 'screen/attendance_request.dart';

class AppRoutes {
  static const String updateProfile = '/updateProfile';
  static const String attendanceRequest = '/attendanceRequest';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/updateProfile':
        return MaterialPageRoute(builder: (_) => const UpdateProfileScreen());
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