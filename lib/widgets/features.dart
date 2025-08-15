import 'package:flutter/material.dart';

class Features extends StatelessWidget {
  Features({super.key});

  final List<Map<String, dynamic>> features = [
    {"icon": Icons.receipt_long, "label": "Reimbursement"},
    {"icon": Icons.airplane_ticket, "label": "Leave Request"},
    {"icon": Icons.access_time, "label": "Overtime"},
    {"icon": Icons.calendar_today, "label": "Schedule"},
    {"icon": Icons.account_balance_wallet, "label": "Payroll"},
    {"icon": Icons.emoji_events, "label": "Achievement"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: features.map((feature) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.blue.withOpacity(0.1),
                child: Icon(feature["icon"], color: Colors.blue, size: 28),
              ),
              const SizedBox(height: 8),
              Text(
                feature["label"],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
