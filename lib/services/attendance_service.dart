import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/attendance.dart';

class AttendanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'attendances'; 

  // Mengambil daftar attendance berdasarkan user yang login
  Future<List<Attendance>> getMyAttendance(String userId) async {
    final querySnapshot = await _firestore
        .collection(collectionName)
        .where('users', isEqualTo: userId) // Filter berdasarkan userId
        .orderBy('date', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => Attendance.fromFirestore(doc))
        .toList();
  }

  // Check-in ke Firestore
  Future<Attendance> checkIn(String userId) async {
    final newAttendance = Attendance(
      id: '', // Firestore akan menghasilkan id secara otomatis
      user: userId,
      date: DateTime.now(),
      clockIn: DateTime.now(),
      clockOut: null,
      status: 'Present',
    );

    final docRef = await _firestore.collection(collectionName).add(newAttendance.toMap());
    return Attendance.fromFirestore(await docRef.get());
  }

  // Check-out dan update attendance di Firestore
  Future<Attendance> checkOut(String attendanceId) async {
    final docRef = _firestore.collection(collectionName).doc(attendanceId);

    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) throw Exception('Attendance not found');

    final updatedAttendance = Attendance.fromFirestore(docSnapshot);
    final updated = updatedAttendance.copyWith(clockOut: DateTime.now());

    await docRef.update(updated.toMap());
    return updated;
  }
}