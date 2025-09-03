class User {
  final String id;
  final String name;
  final String email;
  final String department;
  final String position;
  final String image;
  final String phone;
  final String location;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
    required this.position,
    required this.image,
    required this.phone,
    required this.location,
    required this.role,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      department: map['department'] ?? '',
      position: map['position'] ?? '',
      image: map['image'] ?? '',
      phone: map['phone'] ?? '',
      location: map['location'] ?? '',
      role: map['role'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'department': department,
      'position': position,
      'image': image,
      'phone': phone,
      'location': location,
      'role': role,
    };
  }
}