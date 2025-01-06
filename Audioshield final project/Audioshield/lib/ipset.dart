import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_register.dart';

class IpSetPage extends StatefulWidget {
  const IpSetPage({Key? key});

  @override
  State<IpSetPage> createState() => _IpSetPageState();
}

class _IpSetPageState extends State<IpSetPage> {
  final TextEditingController ipController = TextEditingController();

  Future<bool> _onBackPressed() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black, // Dark background color
        title: const Text(
          'Exit App?',
          style: TextStyle(color: Colors.white), // White text color
        ),
        content: const Text(
          'Do you want to exit the app?',
          style: TextStyle(color: Colors.white), // White text color
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () => exit(0),
            child: const Text('Yes', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    ).then((value) => value as bool? ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Audioshield"),
          backgroundColor: Colors.black, // Change app bar color to black
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              'lib/image/backgroundimage.jpeg', // Path to your background image
              fit: BoxFit.cover,
            ),
            // Form and Button
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 0, 0, 0.5), // Transparent black color
                          borderRadius: BorderRadius.circular(10), // Optional: Add border radius
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: ipController,
                            style: const TextStyle(color: Colors.white), // Set text color to white
                            decoration: InputDecoration(
                              labelText: 'IP Address',
                              labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                              hintText: 'Enter a valid IP address',
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              prefixIcon: const Icon(Icons.key, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        String ip = ipController.text.toString();
                        final sh = await SharedPreferences.getInstance();
                        sh.setString("url", "http://$ip:5000/");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginRegisterPage()),
                        );
                      },
                      icon: const Icon(Icons.key),
                      label: const Text("Set IP"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Colors.amber, // Change text color to black
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
