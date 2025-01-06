import 'package:audioshield/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
// Import the splash screen file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Set SplashScreen as the home page
    );
  }
}
