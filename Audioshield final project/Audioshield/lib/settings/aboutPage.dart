// about_page.dart

import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "lib/image/backgroundimage.jpeg"), // Replace with your background image
            fit: BoxFit.cover,
          ),
        ),
        child: const SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'About Our Team',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 20),
                DeveloperCard(
                  name: 'person 1',
                  role: 'Web Developer',
                  image: 'lib/image/Ap.png', // Replace with the image path
                ),
                DeveloperCard(
                  name: 'person 2',
                  role: 'App Developer',
                  image: 'lib/image/Ab.png', // Replace with the image path
                ),
                DeveloperCard(
                  name: 'person 3',
                  role: 'UI/UX Designer & Model Trainer',
                  image: 'lib/image/Ak.png', // Replace with the image path
                ),
                DeveloperCard(
                  name: 'person 4',
                  role: 'Data Preprocessing & Feature Extraction',
                  image: 'lib/image/At.png', // Replace with the image path
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DeveloperCard extends StatelessWidget {
  final String name;
  final String role;
  final String image;

  const DeveloperCard(
      {super.key, required this.name, required this.role, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      color: Colors
          .transparent, // Transparent background to show the image background
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(image),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              role,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
