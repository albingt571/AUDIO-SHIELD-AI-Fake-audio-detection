import 'package:audioshield/settings/Feedback_Page.dart';
import 'package:audioshield/login.dart';
import 'package:flutter/material.dart';

import '../settings/LegalInformation.dart';
import '../settings/PrivacySettings.dart';

import '../settings/aboutPage.dart';
import '../settings/complaint.dart';
import '../settings/helpFAQPage.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black, // Set your preferred background color
          image: DecorationImage(
            image: AssetImage("lib/image/backgroundimage.jpeg"), // Add your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 24),
              _buildCurvedContainer(
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FeedbackPage()),
                    );
                  },
                  child: _buildMenuItem(Icons.feedback, 'Feedback'),
                ),
                Colors.white.withOpacity(0.5), // Transparent white color
              ),
              const SizedBox(height: 24),
              _buildCurvedContainer(
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ComplaintPage()),
                    );
                  },
                  child: _buildMenuItem(Icons.comment, 'Complaint'),
                ),
                Colors.white.withOpacity(0.5), // Transparent white color
              ),
              const SizedBox(height: 24),
              _buildCurvedContainer(
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpFAQPage()),
                    );
                  },
                  child: _buildMenuItem(Icons.library_books, 'Help & FAQ'),
                ),
                Colors.white.withOpacity(0.5), // Transparent white color
              ),
              const SizedBox(height: 24),
              _buildCurvedContainer(
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PrivacySettings()),
                    );
                  },
                  child: _buildMenuItem(Icons.privacy_tip, 'Privacy Settings'),
                ),
                Colors.white.withOpacity(0.5), // Transparent white color
              ),
              const SizedBox(height: 24),
              _buildCurvedContainer(
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LegalInformation()),
                    );
                  },
                  child: _buildMenuItem(Icons.library_books, 'Legal Information'),
                ),
                Colors.white.withOpacity(0.5), // Transparent white color
              ),
              const SizedBox(height: 24),
              _buildCurvedContainer(
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutPage()),
                    );
                  },
                  child: _buildMenuItem(Icons.question_mark, 'About'),
                ),
                Colors.white.withOpacity(0.5), // Transparent white color
              ),
              const SizedBox(height: 24),
              _buildCurvedContainer(
                GestureDetector(
                  onTap: () {
                    // Navigate to the login page and replace the current page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: _buildMenuItem(Icons.exit_to_app, 'Log Out', isLogout: true),
                ),
                Colors.red.withOpacity(0.5), // Transparent red color
                isLogout: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurvedContainer(Widget child, Color color, {bool isLogout = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
        border: isLogout
            ? Border.all(color: Colors.red, width: 2) // Add border for logout button
            : null,
      ),
      child: child,
    );
  }

  Widget _buildMenuItem(IconData icon, String text, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.white, // Set text color to red for logout button
          fontSize: 16,
        ),
      ),
    );
  }
}
