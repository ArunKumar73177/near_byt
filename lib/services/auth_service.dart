import 'package:shared_preferences/shared_preferences.dart';
import 'api_client.dart';

class AuthService {
  static Future<bool> login(String username, String password) async {
    try {
      final response = await ApiClient.dio.post('/auth/login', data: {
        'username': username,
        'password': password,
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwtToken', response.data['token']);
      await prefs.setString('userId', response.data['userId']);
      await prefs.setString('fullName', response.data['fullName']);
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', username);
      return true;
    } catch (e) {
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
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwtToken', response.data['token']);
      await prefs.setString('userId', response.data['userId']);
      await prefs.setString('fullName', response.data['fullName']);
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', username);
      return true;
    } catch (e) {
      return false;
    }
  }
}