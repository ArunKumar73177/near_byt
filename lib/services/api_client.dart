// lib/services/api_client.dart
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static const String baseUrl = "http://YOUR_BACKEND_IP:8080/api";
  // For Android emulator use: http://10.0.2.2:8080/api
  // For physical device use your machine's local IP: http://192.168.x.x:8080/api
  // For production: https://your-domain.com/api

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {"Content-Type": "application/json"},
    ),
  );

  static Future<void> addAuthHeader() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwtToken');
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }
}