import 'package:flutter/material.dart';
import 'screens/onboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CineMatch',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF191022),
        primaryColor: const Color(0xFF7F0DF2),
      ),
      home: const OnboardingScreen(),
    );
  }
}