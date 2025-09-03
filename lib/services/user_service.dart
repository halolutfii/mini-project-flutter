import '../models/user.dart';
import 'api_service.dart';

class UserService {
  final ApiService _apiService = ApiService(); // pakai singleton

  Future<User> fetchUser() async {
    final response = await _apiService.getCurrentUser();
    return User.fromMap(response.data['user']);
  }

  Future<User> updateUser(User user) async {
    final response = await _apiService.dio.put(
      '/auth/update', // sesuaikan dengan endpoint backend kamu
      data: user.toMap(),
    );

    if (response.statusCode == 200) {
      return User.fromMap(response.data['user']);
    } else {
      throw Exception('Failed to update user');
    }
  }
}