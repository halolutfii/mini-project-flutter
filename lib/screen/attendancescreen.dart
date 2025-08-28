import 'package:flutter/material.dart';

import './tabs/logs_tab.dart';
import './tabs/attendance_provider.dart';
import './tabs/shift_tab.dart';

import '../widgets/appbar.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "Logs"),
              Tab(text: "Attendance"),
              Tab(text: "Shift"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LogsTab(),
            AttendanceTab(),
            ShiftTab(),
          ],
        ),
      ),
    );
  }
}