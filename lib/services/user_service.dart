import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class UserService {
  final CollectionReference employees =
      FirebaseFirestore.instance.collection('employees');

  Future<void> createUserProfile(Users profile) async {
    await employees.doc(profile.uid).set(profile.toMap());
  }

  Future<Users?> getUserProfile(String uid) async {
    final doc = await employees.doc(uid).get();
    if (doc.exists) {
      return Users.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateUserProfile(Users profile) async {
    await employees.doc(profile.uid).update(profile.toMap());
  }

  Future<bool> checkUserExists(String uid) async {
    final doc = await employees.doc(uid).get();
    return doc.exists;
  }

  Future<List<Users>> getEmployees() async {
    final snapshot = await employees.where("role", isEqualTo: "employee").get();

    return snapshot.docs
        .map((doc) => Users.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<Users> createEmployee({
    required String email,
    required String password,
    required String name,
    String role = "employee",
  }) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    final profile = Users(
      uid: credential.user!.uid,
      name: name,
      email: email,
      role: role,
    );

    await employees.doc(profile.uid).set(profile.toMap());

    return profile;
  }

  Future<void> deleteEmployee(String uid) async {
    await employees.doc(uid).delete();
  }
}