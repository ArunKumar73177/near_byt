// lib/services/auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'api_client.dart';

class AuthService {
  // In-memory token for web session
  static String? _token;
  static String? get token => _token;

  static Future<bool> login(String username, String password) async {
    try {
      final response = await ApiClient.dio.post('/auth/login', data: {
        'username': username,
        'password': password,
      });

      _token = response.data['token'];
      print('Token received: $_token');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwtToken', _token!);
      await prefs.setString('userId', response.data['userId']);
      await prefs.setString('fullName', response.data['fullName'] ?? username);
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', username);

      return true;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  static Future<bool> signup(String username, String fullName,
      String password) async {
    try {
      final response = await ApiClient.dio.post('/auth/signup', data: {
        'username': username,
        'fullName': fullName,
        'password': password,
      });

      _token = response.data['token'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwtToken', _token!);
      await prefs.setString('userId', response.data['userId']);
      await prefs.setString('fullName', response.data['fullName']);
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', username);

      return true;
    } catch (e) {
      print('Signup error: $e');
      return false;
    }
  }
}