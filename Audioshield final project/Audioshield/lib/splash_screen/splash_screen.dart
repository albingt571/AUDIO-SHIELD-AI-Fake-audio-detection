import 'dart:async';
import 'package:audioshield/ipset.dart';
import 'package:flutter/material.dart';
import '../login_register.dart'; // Import your main page here

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a long-running task
    Timer(Duration(seconds: 4), () {
      // Navigate to your main page after 2 seconds
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => IpSetPage(), // Replace with your main page
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Change the background color as needed
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add your app logo or any other widgets you want to display as splash
            // Example:
            Image.asset(
              'lib/image/audioshield.png', // Path to your app logo
              width: 350,
              height: 350,
            ),
            SizedBox(height: 20),
            Text(
              'Your App Name',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
