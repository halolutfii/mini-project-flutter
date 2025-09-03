import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class ApiService {
  late Dio dio;
  late CookieJar cookieJar;

  // Singleton pattern supaya instance sama di seluruh app
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://backend-flutter.vercel.app/api/v1',
      contentType: 'application/json',
    ));
    cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
  }

  Future<Response> login(String email, String password) async {
    return dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
  }

  Future<Response> getCurrentUser() async {
    return dio.get('/auth/getuser'); // cookie otomatis dipakai
  }
}