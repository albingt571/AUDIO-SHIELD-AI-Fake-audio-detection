import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:audioshield/Forgot%20Password/newpassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTP_Page extends StatefulWidget {
  const OTP_Page({super.key});

  @override
  State<OTP_Page> createState() => _OTP_PageState();
}

class _OTP_PageState extends State<OTP_Page> {
  String otp = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FORGOT PASSWORD"),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'lib/image/backgroundimage.jpeg',
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
                      padding: const EdgeInsets.all(16.0), // Add padding to the container
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Enter OTP",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            OtpTextField(
                              numberOfFields: 5,
                              borderColor: const Color(0xFFFF0000),
                              focusedBorderColor: Colors.red,
                              showFieldAsBox: true,
                              textStyle: const TextStyle(
                                color: Colors.white, // Set input text color to white
                              ),
                              onCodeChanged: (String code) {
                                setState(() {
                                  if (code.isEmpty) {
                                    otp = otp.substring(0, otp.length - 1);
                                  } else {
                                    otp += code;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (otp.isEmpty) {
                        // If OTP is empty, show a red Snackbar error
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Error: OTP is empty",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (otp.length == 5) {
                        final sh = await SharedPreferences.getInstance();
                        String url = sh.getString("url") ?? "";
                        try {
                          var response = await http.post(
                            Uri.parse("${url}otpverification"),
                            body: {
                              'uname': otp,
                            },
                          );
                          var jasondata = json.decode(response.body);
                          print(jasondata);
                          String status = jasondata['task'].toString();
                          if (status == "valid") {
                            String lid = jasondata['lid'].toString();
                            sh.setString("lid", lid);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const New_Password(),
                              ),
                            );
                          } else {
                            print("Error: Invalid OTP");
                          }
                        } catch (e) {
                          print("Error: $e");
                        }
                      } else {
                        print("Error: OTP length should be 5");
                      }
                    },
                    icon: const Icon(Icons.key),
                    label: const Text("Verify"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.red,
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
}
