// lib/services/api_client.dart
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_service.dart';

class ApiClient {
  static const String baseUrl = "http://localhost:8080/api";

  static Dio? _dio;

  static Dio get dio {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );
      _dio!.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            // Use in-memory token first, fall back to SharedPreferences
            String? token = AuthService.token;
            if (token == null) {
              final prefs = await SharedPreferences.getInstance();
              token = prefs.getString('jwtToken');
            }
            print('TOKEN: $token');
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            if (options.data is FormData) {
              options.headers.remove('Content-Type');
            } else {
              options.headers['Content-Type'] = 'application/json';
            }
            print('HEADERS: ${options.headers}');
            return handler.next(options);
          },
          onError: (error, handler) {
            print('API Error: ${error.message}');
            print('API Error Response: ${error.response?.data}');
            return handler.next(error);
          },
        ),
      );
    }
    return _dio!;
  }

  static Future<void> addAuthHeader() async {
    String? token = AuthService.token;
    if (token == null) {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('jwtToken');
    }
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }
}