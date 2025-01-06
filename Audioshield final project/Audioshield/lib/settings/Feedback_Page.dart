import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  List<String> feedbacks = [];
  List<String> dates = [];

  @override
  void initState() {
    super.initState();
    loadFeedback();
  }

  Future<void> loadFeedback() async {
    try {
      final pref = await SharedPreferences.getInstance();
      String url = pref.getString("url") ?? "";
      String lid = pref.getString("lid") ?? "";

      var response = await http.post(Uri.parse("${url}viewfeed"), body: {'lid': lid});

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['status'] == 'ok') {
          setState(() {
            feedbacks = jsonData['data'].map<String>((item) => item['feedback'].toString()).toList();
            dates = jsonData['data'].map<String>((item) => item['date'].toString()).toList();
          });
        } else {
          print("Error: ${jsonData['message']}");
        }
      } else {
        print("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/image/backgroundimage.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: feedbacks.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date: ${dates[index]}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Feedback: ${feedbacks[index]}",
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewFeedbackPage()),
          );
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NewFeedbackPage extends StatefulWidget {
  const NewFeedbackPage({super.key});

  @override
  _NewFeedbackPageState createState() => _NewFeedbackPageState();
}

class _NewFeedbackPageState extends State<NewFeedbackPage> {
  final TextEditingController _feedbackController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Initialize _formKey

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Write a New Feedback"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/image/backgroundimage.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.black.withOpacity(0.7),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form( // Wrap your content with Form widget
                key: _formKey, // Use the _formKey here
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _feedbackController,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your feedback';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Feedback",
                        labelStyle: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        hintText: 'Enter your feedback...',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        icon: const Icon(
                          Icons.feedback,
                          color: Colors.white,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final sh = await SharedPreferences.getInstance();
                          String feedback = _feedbackController.text.toString();
                          String url = sh.getString("url").toString();
                          String lid = sh.getString("lid").toString();

                          var data = await http.post(
                            Uri.parse("${url}and_send_feedback_user"),
                            body: {
                              'feedback': feedback,
                              'lid': lid,
                            },
                          );
                          var jsonData = json.decode(data.body);
                          String status = jsonData['task'].toString();
                          if (status == "ok") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Feedback sent'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const FeedbackPage()),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Set button color to red
                      ),
                      child: const Text("Send"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
