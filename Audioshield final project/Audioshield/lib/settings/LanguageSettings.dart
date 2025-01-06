import 'package:flutter/material.dart';

class LanguageSettings extends StatefulWidget {
  @override
  _LanguageSettingsState createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black, // Set your preferred app bar background color
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black, // Set your preferred background color
          image: DecorationImage(
            image: AssetImage("lib/image/backgroundimage.jpeg"), // Add your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Choose Your Preferred Language',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                DropdownButton<String>(
                  value: selectedLanguage,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLanguage = newValue!;
                    });
                    // TODO: Save the user's selected language to your data storage.
                  },
                  style: TextStyle(color: Colors.white), // Set text color
                  dropdownColor: Colors.grey, // Set dropdown background color
                  items: <String>['English', 'Hindi', 'Tamil', 'Telugu', 'Bengali', 'Marathi', 'Urdu', 'Malayalam']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Your selected language is: $selectedLanguage',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
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
