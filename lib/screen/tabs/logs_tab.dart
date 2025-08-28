import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/logs_provider.dart';

class LogsTab extends StatelessWidget {
  const LogsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final logsProvider = Provider.of<LogsProvider>(context);
    final records = logsProvider.records;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: records.isEmpty
          ? const Center(
              child: Text("No logs yet."),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: records.length,
              itemBuilder: (context, index) {
                final log = records[index];
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
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (log.checkOutTime != null
                                  ? Colors.red
                                  : Colors.green)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          log.checkOutTime != null
                              ? Icons.logout
                              : Icons.login,
                          color: log.checkOutTime != null
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date: ${log.date}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Check-in: ${_formatTime(log.checkInTime)}"
                              "${log.checkOutTime != null ? "\nCheck-out: ${_formatTime(log.checkOutTime!)}" : ""}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        log.status,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: log.status == "Present"
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  static String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }
}