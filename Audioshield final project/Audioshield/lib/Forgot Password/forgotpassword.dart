import 'dart:convert';

import 'package:audioshield/Forgot%20Password/otppage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Forgot_Password extends StatefulWidget {
  const Forgot_Password({super.key});

  @override
  State<Forgot_Password> createState() => _Forgot_PasswordState();
}

class _Forgot_PasswordState extends State<Forgot_Password> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();

  // Regular expression for email validation
  final RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,25}$');

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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 0, 0, 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextFormField(
                            controller: userController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                              hintText: 'Enter a valid Email Id',
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              prefixIcon: const Icon(Icons.email, color: Colors.white),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email !!!';
                              }
                              if (!emailRegExp.hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final sh = await SharedPreferences.getInstance();
                          String user = userController.text.toString();
                          String url = sh.getString("url").toString();
                          var data = await http.post(
                            Uri.parse("${url}forgotpassword1"),
                            body: {
                              'uname': user,
                            },
                          );
                          var jsonData = json.decode(data.body);
                          String status = jsonData['task'].toString();

                          if (status == "valid") {
                            String lid = jsonData['lid'].toString();
                            sh.setString("lid", lid);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OTP_Page(),
                              ),
                            );
                          } else {
                            print("error");
                          }
                        }
                      },
                      icon: const Icon(Icons.email),
                      label: const Text("Get OTP"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Colors.red,
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
