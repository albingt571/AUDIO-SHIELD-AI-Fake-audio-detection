import 'package:flutter/material.dart';

class Response_Page extends StatefulWidget {
  const Response_Page({super.key});

  @override
  State<Response_Page> createState() => _Response_PageState();
}

class _Response_PageState extends State<Response_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/image/backgroundimage.jpeg'), // Replace with your background image path
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: 5, // Example number of analysis results
          itemBuilder: (context, index) {
            // Replace these with actual data from your analysis results history
            String audioName = 'Audio $index';
            String result = 'Fake'; // or 'Real'
            String confidenceLevel = '85%'; // Example confidence level

            return ListTile(
              title: Text(audioName),
              subtitle: Text('Result: $result, Confidence Level: $confidenceLevel'),
              onTap: () {
                // Action when tapping on an analysis result, if needed
              },
            );
          },
        ),
      ),
    );
  }
}
