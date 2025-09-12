import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserService {
  final CollectionReference profiles =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUserProfile(Users profile) async {
    await profiles.doc(profile.uid).set(profile.toMap());
  }

  Future<Users?> getUserProfile(String uid) async {
    final doc = await profiles.doc(uid).get();
    if (doc.exists) {
      return Users.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateUserProfile(Users profile) async {
    await profiles.doc(profile.uid).update(profile.toMap());
  }

  Future<bool> checkUserExists(String uid) async {
    final doc = await profiles.doc(uid).get();
    return doc.exists;
  }
}