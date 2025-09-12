class Users {
  final String uid; // Firebase Auth UID = document ID
  final String name;
  final String? profession;
  final String email;
  final String? phone;
  final String? address;
  final String? bio;
  final String? photo; // simpan path foto (String)
  final String role; // 'admin' atau 'member'

  Users({
    required this.uid,
    required this.name,
    required this.email,
    this.profession,
    this.photo,
    this.phone,
    this.address,
    this.bio,
    required this.role,
  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profession: map['profession'] ?? '',
      photo: map['photo'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      bio: map['bio'] ?? '',
      role: map['role'] ?? 'member',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'profession': profession,
      'email': email,
      'phone': phone,
      'address': address,
      'bio': bio,
      'photo': photo,
      'role': role,
    };
  }
}