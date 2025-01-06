import 'package:audioshield/audioinput/audio_input_page.dart';
import 'package:flutter/material.dart'; // Import the next page where audio is inputted

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/image/backgroundimage.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + kToolbarHeight, // Adjust padding to include status bar and app bar
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                // Navigate to the next page when the image card is clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AudioUploadPage()),
                );
              },
              child: Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width - 40, // Adjust width to screen width
                  height: 200,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/image/fakeorrealimg.png'), // Replace with your card background image path
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Text(
                    'FAKE OR REAL',
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold), // Set text color to white
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
