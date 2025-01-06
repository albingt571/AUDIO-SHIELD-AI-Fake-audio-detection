import 'dart:convert';
import 'package:audioshield/Forgot%20Password/forgotpassword.dart';
import 'package:audioshield/home.dart';
import 'package:audioshield/login_register.dart';
import 'package:audioshield/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add a global key for the form
  bool _obscureText = true; // State variable to control text visibility
  bool _isLoading = false; // State variable to control loading indicator

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    double logoHeight = height * 0.4;
    if (width >= 600) {
      logoHeight = height * 0.42;
    }

    double loginTextSize = width * 0.1;
    if (width >= 600) {
      loginTextSize = width * 0.05;
    }

    double buttonWidth = width * 0.4;
    double buttonHeight = height * 0.07;
    if (width >= 600) {
      buttonWidth = width * 0.2;
      buttonHeight = height * 0.08;
    }

    return WillPopScope(
      onWillPop: () async {
        // Perform custom navigation logic here when back button is pressed
        // For example, navigate to a specific page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginRegisterPage()),
        );
        // Return false to prevent default back button behavior
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/image/backgroundimage.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: logoHeight,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: height * 0.05,
                            height: height * 0.3,
                            width: width,
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('lib/image/audioshield.png'),
                                  fit: BoxFit.fitHeight,
                                  colorFilter: ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.modulate,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: height * 0.002),
                            Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: loginTextSize,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.025),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(0.5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 20,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: height * 0.02),
                                  _buildTextField(
                                    userController,
                                    'Username',
                                    Icons.email,
                                    RegExp(
                                        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,25}$'),
                                    'Enter a valid username',
                                  ),
                                  SizedBox(height: height * 0.02),
                                  _buildTextField(
                                    passwordController,
                                    'Password',
                                    Icons.lock,
                                    RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$'),
                                    'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one digit',
                                    isPassword: true,
                                  ),
                                  SizedBox(height: height * 0.02),
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Center(
                              child: TextButton(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Forgot_Password()),
                                  );
                                },
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.005),
                            MaterialButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true; // Start loading indicator
                                  });
                                  final sh = await SharedPreferences.getInstance();
                                  String user = userController.text.toString();
                                  String password = passwordController.text.toString();
                                  String url = sh.getString("url").toString();

                                  var data = await http.post(
                                    Uri.parse("${url}login_code"),
                                    body: {
                                      'uname': user,
                                      "pswrd": password,
                                    },
                                  );
                                  var jsonData = json.decode(data.body);
                                  String status = jsonData['task'].toString();
                                  String type = jsonData['type'].toString();
                                  if (status == "valid") {
                                    if (type == 'user') {
                                      String lid = jsonData['lid'].toString();
                                      sh.setString("lid", lid);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Invalid username or password",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  } else if (status == 'block') {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.black87,
                                          title: const Text(
                                            "Account Blocked",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          content: const Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Your account has been blocked by the administrator.",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                "Please contact the administrator at:",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "stmminiproject003@gmail.com",
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            Center(
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  "OK",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Invalid username or password",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.red,
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                  setState(() {
                                    _isLoading = false; // Stop loading indicator
                                  });
                                }
                              },
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              minWidth: buttonWidth,
                              height: buttonHeight,
                              child: const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RegisterPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "New User? Register Now",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Loading indicator inside a card
            if (_isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: Card(
                      color: Colors.black12,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red), // Change the color here
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String labelText,
      IconData icon,
      RegExp reg,
      String errorMsg, {
        bool isPassword = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? _obscureText : false,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.white.withOpacity(0.8),
          ),
          hintText: 'Enter your $labelText',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.8),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your $labelText';
          } else if (!reg.hasMatch(value)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  errorMsg,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 5),
              ),
            );
            return null;
          }
          return null;
        },
      ),
    );
  }
}
