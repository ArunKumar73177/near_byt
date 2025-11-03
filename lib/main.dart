import 'package:flutter/material.dart';
import 'login_page.dart'; // Import your login page

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
      home: const LoginScreen(), // Use LoginScreen as home
    );
  }
}