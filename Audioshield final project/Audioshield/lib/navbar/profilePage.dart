import 'dart:convert';

import 'package:audioshield/navbar/UserEdit.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  String fname = "";
  String lname = "";
  String phone = "";
  String id = "";
  String email = "";
  String place = "";
  String photo = "";

  @override
  void initState() {
    super.initState();
    viewProfile();
  }

  Future<void> viewProfile() async {
    try {
      final pref = await SharedPreferences.getInstance();
      String ip = pref.getString("url").toString();
      String lid = pref.getString("lid").toString();

      String url = "${ip}profile";
      print(url);
      print("=========================");

      var data = await http.post(Uri.parse(url), body: {'lid': lid, 'ip': ip});
      var jsondata = json.decode(data.body);
      print(jsondata); // Print the API response for debugging

      // Access profile fields directly from jsondata
      if (jsondata != null) {
        setState(() {
          fname = jsondata['fname'].toString();
          lname = jsondata['lname'].toString();
          phone = jsondata['phone'].toString();
          id = jsondata['id'].toString();
          email = jsondata['email'].toString();
          place = jsondata['place'].toString();
          photo = ip + jsondata['photo'].toString();
        });
      } else {
        print("No profile data found in the response");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'lib/image/backgroundimage.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          // Dark Overlay
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.grey, Colors.black],
                          ),
                        ),
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EnlargedImagePage(
                                      imageUrl: photo,
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 80,
                                backgroundColor:
                                Colors.grey.withOpacity(0.2),
                                backgroundImage: Image.network(photo).image,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildProfileInfo("Name", Icons.person,
                                "$fname $lname"),
                            _buildProfileInfo("Email", Icons.email, email),
                            _buildProfileInfo("Phone", Icons.phone, phone),
                            _buildProfileInfo("Address", Icons.location_on,
                                place),
                            const SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: () async {
                                final sh =
                                await SharedPreferences.getInstance();
                                sh.setString("fname", fname);
                                sh.setString("lname", lname);
                                sh.setString("email", email);
                                sh.setString("phone", phone);
                                sh.setString("place", place);
                                sh.setString("id", id);
                                // sh.setString("photo", photo);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UserEdit(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red, // Change button color to red
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "Edit",
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildProfileInfo(String label, IconData icon, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$label:",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3), // Reduced spacing here
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class EnlargedImagePage extends StatelessWidget {
  final String imageUrl;

  const EnlargedImagePage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Close the page when tapping on the image
        },
        child: Center(
          child: Hero(
            tag: 'student_image',
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> showExitConfirmationDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm Exit'),
        content: const Text('Do you want to exit the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No'),
          ),
        ],
      );
    },
  );
}
