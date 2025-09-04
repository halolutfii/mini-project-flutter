import 'package:flutter/material.dart';
import 'package:hr_attendance_tracker_app/routes.dart';
import 'package:provider/provider.dart';
import '../../providers/attendanceRequest_provider.dart';
import '../attendance_request.dart';

class AttendanceTab extends StatelessWidget {
  const AttendanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceProvider = Provider.of<AttendanceRequestProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: attendanceProvider.requests.isEmpty
          ? const Center(
              child: Text("No attendance requests yet."),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: attendanceProvider.requests.length,
              itemBuilder: (context, index) {
                final req = attendanceProvider.requests[index];

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
                  children: [
                    // ICON STATUS
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getStatusColor(req.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        req.status == "Approved"
                            ? Icons.check_circle
                            : (req.status == "Rejected"
                                ? Icons.cancel
                                : Icons.hourglass_top),
                        color: _getStatusColor(req.status),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // DETAIL REQUEST
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tanggal + jam
                          Text(
                            "${req.date.day.toString().padLeft(2, '0')}-"
                            "${req.date.month.toString().padLeft(2, '0')}-"
                            "${req.date.year}  "
                            "${req.date.hour.toString().padLeft(2, '0')}:"
                            "${req.date.minute.toString().padLeft(2, '0')}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Request type (dari dropdown)
                          Text(
                            "Request: ${req.request}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2E3A59),
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Reason (alasan detail)
                          Text(
                            "Reason: ${req.reason}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // STATUS
                    Text(
                      req.status,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(req.status),
                      ),
                    ),
                  ],
                ),
              );

              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2E3A59),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.attendanceRequest);
        },
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