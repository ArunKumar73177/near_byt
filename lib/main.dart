// lib/main.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import the main application structure (from main_page.dart)
import 'main_page.dart';

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
        '/login': (context) => const LoginScreen(),
        '/main': (context) => const MainPage(),
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

// --- Placeholder for 'login_page.dart' (Required for routes) ---
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Mock successful login
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', true);
            if (!context.mounted) return;
            Navigator.of(context).pushReplacementNamed('/main');
          },
          child: const Text('Mock Login'),
        ),
      ),
    );
  }
}

// --- Placeholder for 'edit_profile.dart' (Used by AccountPage) ---
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Edit Profile Form will be here.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Mock profile update success
                Navigator.pop(context, true);
              },
              child: const Text('Save Profile (Mock)'),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Placeholder Pages for Account Menu Navigation (Used by AccountPage) ---
class MyListingsPage extends StatelessWidget {
  const MyListingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('My Listings')),
        body: const Center(child: Text('Your product listings.')));
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Favorites')),
        body: const Center(child: Text('Your favorite products (8 items).')));
  }
}

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Reviews')),
        body: const Center(child: Text('Your reviews and ratings (0 reviews).')));
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: const Center(child: Text('App settings and preferences.')));
  }
}

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Help & Support')),
        body: const Center(child: Text('FAQ and support contact.')));
  }
}