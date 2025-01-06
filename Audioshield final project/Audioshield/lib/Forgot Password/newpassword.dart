import 'dart:convert';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:audioshield/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class New_Password extends StatefulWidget {
  const New_Password({super.key});

  @override
  State<New_Password> createState() => _New_PasswordState();
}

class _New_PasswordState extends State<New_Password> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Password"),
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
          // Form
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        _buildTextField(
                          _newPasswordController,
                          'New Password',
                          Icons.lock,
                          RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$'),
                          'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one digit',
                          _obscureNewPassword,
                              () {
                            setState(() {
                              _obscureNewPassword = !_obscureNewPassword;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          _confirmPasswordController,
                          'Confirm Password',
                          Icons.lock,
                          null, // No regex needed for confirm password
                          'Passwords do not match',
                          _obscureConfirmPassword,
                              () {
                            setState(() {
                              _obscureConfirmPassword =
                              !_obscureConfirmPassword;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final sh =
                              await SharedPreferences.getInstance();
                              String newPassword =
                              _newPasswordController.text.trim();
                              String confirmPassword =
                              _confirmPasswordController.text.trim();
                              String url =
                              sh.getString("url").toString();
                              String lid = sh.getString("lid").toString();
                              var data = await http.post(
                                Uri.parse(url + "newpassword"),
                                body: {
                                  "pswrd": newPassword,
                                  "lid": lid,
                                },
                              );
                              var jsonData = json.decode(data.body);
                              String status = jsonData['task'].toString();
                              if (status == "ok") {
                                AnimatedSnackBar.rectangle(
                                  'Success',
                                  'Password changed successfully!',
                                  type: AnimatedSnackBarType.success,
                                  brightness: Brightness.light,
                                ).show(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              } else {
                                print("Error: Unable to change password");
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black, backgroundColor: Colors.red,
                          ),
                          child: const Text('Change Password'),
                        ),
                      ],
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

  Widget _buildTextField(
      TextEditingController controller,
      String labelText,
      IconData icon,
      RegExp? reg,
      String errorMsg,
      bool obscureText,
      VoidCallback toggleVisibility,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          prefixIcon: Icon(icon, color: Colors.white),
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
            color: Colors.white,
            onPressed: toggleVisibility,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $labelText';
          }
          if (reg != null && !reg.hasMatch(value)) {
            return errorMsg;
          }
          if (labelText == 'Confirm Password' &&
              value != _newPasswordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
