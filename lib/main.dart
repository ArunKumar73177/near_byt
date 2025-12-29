// lib/main.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import the main application structure
import 'main_page.dart';

// Import the actual login screen implementation
import 'login_page.dart';

// Import the required page classes from pages_under_settings
import 'pages_under_settings/my_listings.dart';
import 'pages_under_settings/favorites.dart';
import 'pages_under_settings/reviews.dart';
import 'pages_under_settings/settings.dart';
import 'pages_under_settings/help_and_support.dart';

// Import edit profile
import 'edit_profile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NearByt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: false,
        scaffoldBackgroundColor: const Color(0xFFE8E9F3),
      ),
      // Use SplashScreen to check login status
      home: const SplashScreen(),
      routes: {
        // Now correctly points to the implementation from login_page.dart
        '/login': (context) => const LoginScreen(),
        '/main': (context) => const MainPage(),
      },
      // Register all the external pages
      onGenerateRoute: (settings) {
        if (settings.name == '/my_listings') {
          return MaterialPageRoute(builder: (context) => const MyListingsPage());
        }
        if (settings.name == '/favorites') {
          return MaterialPageRoute(builder: (context) => const FavoritesPage());
        }
        if (settings.name == '/reviews') {
          return MaterialPageRoute(builder: (context) => const ReviewsPage());
        }
        if (settings.name == '/settings') {
          return MaterialPageRoute(builder: (context) => const SettingsPage());
        }
        if (settings.name == '/help_support') {
          return MaterialPageRoute(builder: (context) => const HelpAndSupportPage());
        }
        if (settings.name == '/edit_profile') {
          return MaterialPageRoute(builder: (context) => const EditProfilePage());
        }
        return null;
      },
    );
  }
}

// Splash Screen to check login status
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Add a small delay for splash effect
    await Future.delayed(const Duration(milliseconds: 1500));

    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!mounted) return;

    if (isLoggedIn) {
      // User is logged in, navigate to main page
      Navigator.of(context).pushReplacementNamed('/main');
    } else {
      // User is not logged in, navigate to login page
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2563EB),
                    Color(0xFF9333EA),
                    Color(0xFFEC4899),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  'N',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  Color(0xFF2563EB),
                  Color(0xFF9333EA),
                  Color(0xFFEC4899),
                ],
              ).createShader(bounds),
              child: const Text(
                'NearByt',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
            ),
          ],
        ),
      ),
    );
  }
}