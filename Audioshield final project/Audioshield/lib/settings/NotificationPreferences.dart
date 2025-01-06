import 'package:flutter/material.dart';

class NotificationPreferences extends StatefulWidget {
  @override
  _NotificationPreferencesState createState() => _NotificationPreferencesState();
}

class _NotificationPreferencesState extends State<NotificationPreferences> {
  bool receiveAlerts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Preferences'),
        backgroundColor: Colors.black, // Set your preferred app bar background color
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/image/backgroundimage.jpeg"), // Add your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Customize Your Notification Preferences',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Enable or disable alerts based on your preferences. Stay informed!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
                  SwitchListTile(
                    title: Text('Receive Alerts', style: TextStyle(color: Colors.white)), // Set text color
                    value: receiveAlerts,
                    onChanged: (value) {
                      setState(() {
                        receiveAlerts = value;
                      });
                      // TODO: Save the user's preference to your data storage.
                    },
                    activeTrackColor: Colors.white, // Set active track color
                    activeColor: Colors.red, // Set active switch color
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
