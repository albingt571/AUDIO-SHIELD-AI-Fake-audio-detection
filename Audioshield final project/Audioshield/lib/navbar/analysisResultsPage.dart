import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnalysisResultsPage extends StatefulWidget {
  const AnalysisResultsPage({super.key});

  @override
  _AnalysisResultsPageState createState() => _AnalysisResultsPageState();
}

class _AnalysisResultsPageState extends State<AnalysisResultsPage> {
  List<dynamic> audioResults = [];

  Future<void> loadAudioResults() async {
    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid") ?? "";
      String ip = pref.getString("url") ?? "";

      String url = ip + "view_audioresult";
      var response = await http.post(Uri.parse(url), body: {'lid': lid});

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['status'] == 'ok') {
          setState(() {
            audioResults = jsonData['data'];
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
  void initState() {
    super.initState();
    loadAudioResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/image/backgroundimage.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: audioResults.length,
          itemBuilder: (BuildContext context, int index) {
            var audioResult = audioResults[index];
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
                        "Date: ${audioResult['date']}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "File Name: ${audioResult['file']}",
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Result: ${audioResult['result']}",
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Confidence Level: ${audioResult['confidence_level']}",
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
