import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/shift.dart';
import '../../providers/shift_provider.dart';

class ShiftTab extends StatelessWidget {
  const ShiftTab({super.key});

  void _createShift(BuildContext context) {
    final newShift = Shift(
      id: DateTime.now().toString(),
      date: DateTime.now(),
      type: "Morning Shift",
    );

    Provider.of<ShiftProvider>(context, listen: false).addRequest(newShift);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.work, color: Colors.white),
            SizedBox(width: 8),
            Text("Shift created! Waiting approval..."),
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
  }

  @override
  Widget build(BuildContext context) {
    final shiftProvider = Provider.of<ShiftProvider>(context);
    final requests = shiftProvider.requests;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // bg abu muda
      body: requests.isEmpty
          ? const Center(
              child: Text("No shift requests yet."),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final shift = requests[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.work_history,
                          color: Colors.blue,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              shift.type,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Date: ${shift.date.year}-${shift.date.month.toString().padLeft(2, '0')}-${shift.date.day.toString().padLeft(2, '0')} "
                              "| ${shift.date.hour.toString().padLeft(2, '0')}:${shift.date.minute.toString().padLeft(2, '0')}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Status: ${shift.status}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _getStatusColor(shift.status),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2E3A59),
        tooltip: "Create Shift",
        onPressed: () => _createShift(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return Colors.green;
      case "Rejected":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}