import 'package:flutter/material.dart';

import 'screen/updateprofilescreen.dart';

class AppRoutes {
  static const String updateProfile = '/updateProfile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/updateProfile':
        return MaterialPageRoute(builder: (_) => const UpdateProfileScreen());
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