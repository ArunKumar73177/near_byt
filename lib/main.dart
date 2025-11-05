import 'package:flutter/material.dart';
// Assuming LoginScreen is the name of the widget in this file
import 'login_page.dart';
// We need to import the main page as well
import 'main_page.dart';

void main() {
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

      // 1. Set the initial route to the login screen
      initialRoute: '/login',

      // 2. Define all the application routes
      routes: {
        // Route for the login screen
        '/login': (context) => const LoginScreen(),
        // Route for the main page (assuming the widget is called MainPage)
        '/main': (context) => const MainPage(),
      },

      // Removed: home: const LoginScreen(),
    );
  }
}

// NOTE: You will need to make sure the MainPage widget exists in main_page.dart
// Example:
// class MainPage extends StatelessWidget { ... }