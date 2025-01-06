import 'package:audioshield/ipset.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

class LoginRegisterPage extends StatelessWidget {
  const LoginRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine the device's screen size
    double deviceWidth = MediaQuery.of(context).size.width;

    // Define logo size based on the screen size
    double logoWidth = deviceWidth * 1.0; // For smaller devices
    if (deviceWidth >= 600) {
      // Adjust for larger devices
      logoWidth = 400; // You can adjust this value based on your preference
    }

    // Define button width based on the screen size
    double buttonWidth = 200; // Default button width
    if (deviceWidth >= 600) {
      // Adjust for larger devices
      buttonWidth = 350; // You can adjust this value based on your preference
    }

    return WillPopScope(
      onWillPop: () async {
        // Perform custom navigation logic here when back button is pressed
        // For example, navigate to a specific page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const IpSetPage()),
        );

        // Return false to prevent default back button behavior
        // Return true if you want to allow default back button behavior
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/image/backgroundimage.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Add a styled image at the top
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'lib/image/audioshield.png',
                      width: logoWidth,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B0000),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: Colors.black,
                      elevation: 5,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: buttonWidth,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterPage()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
