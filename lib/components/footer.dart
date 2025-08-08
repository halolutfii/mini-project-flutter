import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
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
}