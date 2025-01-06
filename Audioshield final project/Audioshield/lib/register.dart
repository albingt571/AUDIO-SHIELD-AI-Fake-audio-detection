import 'dart:convert';
import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart'; // Import the login page
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController phnController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add a global key for the form
  final RegExp fnameRegExp = RegExp(r'^[A-Za-z ]{2,25}$');
  final RegExp lnameRegExp = RegExp(r'^[A-Za-z ]{0,25}$');
  final RegExp _phoneReguser = RegExp(r'^[6789]\d{9}$');
  final RegExp placeRegExp = RegExp(r'^[A-Za-z. ]{2,25}$');
  final RegExp emailRegExp =
  RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,25}$');
  final RegExp passwordRegExp =
  RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$');
  XFile? _image; // Use XFile from image_picker package
  bool _isObscure = true;
  bool _isConfirmObscure = true;
  bool _isLoading = false;

  _imgFromCamera() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  _imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _imgFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/image/backgroundimage.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      Image.asset('lib/image/audioshield.png', width: 300),
                      Container(
                        width: MediaQuery.of(context).size.width < 600
                            ? double.infinity
                            : 700,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.7),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                _showPicker(context);
                              },
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: const Color(0xffdbd8cd),
                                child: _image != null
                                    ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.file(
                                    File(_image!.path),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  width: 100,
                                  height: 100,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              fnameController,
                              'First Name',
                              Icons.person,
                              fnameRegExp,
                              "Enter a valid First Name",
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              lnameController,
                              'Last Name',
                              Icons.person,
                              lnameRegExp,
                              "Enter a valid Last Name",
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              emailController,
                              'Email',
                              Icons.email,
                              emailRegExp,
                              "Enter a valid Email",
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              placeController,
                              'Place',
                              Icons.location_on,
                              placeRegExp,
                              "Enter a valid Place",
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              phnController,
                              'Phone Number',
                              Icons.phone,
                              _phoneReguser,
                              "Enter a valid Phone Number",
                            ),
                            const SizedBox(height: 16),
                            _buildPasswordField(
                              passController,
                              'Password',
                              passwordRegExp,
                              _isObscure,
                              _togglePasswordVisibility,
                            ),
                            const SizedBox(height: 16),
                            _buildPasswordField(
                              confirmPassController,
                              'Confirm Password',
                              passwordRegExp,
                              _isConfirmObscure,
                              _toggleConfirmPasswordVisibility,
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });

                          if (_image == null) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Please select a profile photo.'),
                              backgroundColor: Colors.red,
                            ));
                            setState(() {
                              _isLoading = false;
                            });
                            return;
                          }
                          if (_formKey.currentState!.validate()) {
                            if (passController.text !=
                                confirmPassController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Password and confirm password do not match.'),
                                backgroundColor: Colors.red,
                              ));
                              setState(() {
                                _isLoading = false;
                              });
                              return;
                            }
                            final sh = await SharedPreferences.getInstance();
                            String fname = fnameController.text.toString();
                            String lname = lnameController.text.toString();
                            String place = placeController.text.toString();
                            String phn = phnController.text.toString();
                            String email = emailController.text.toString();
                            String passwd = passController.text.toString();
                            String url = sh.getString("url").toString();
                            final bytes = File(_image!.path).readAsBytesSync();
                            String base64Image = base64Encode(bytes);
                            print("img_pan : $base64Image");
                            print("okkkkkkkkkkkkkkkkk");
                            var data = await http.post(
                              Uri.parse("${url}registration"),
                              body: {
                                'fname': fname,
                                'lname': lname,
                                'place': place,
                                'phone': phn,
                                'image': base64Image,
                                'email': email,
                                'password': passwd,
                              },
                            );
                            var jasondata = json.decode(data.body);
                            String status = jasondata['task'].toString();
                            if (status == "ok") {
                              AnimatedSnackBar.rectangle(
                                'Success',
                                'Registration successful!',
                                type: AnimatedSnackBarType.success,
                                brightness: Brightness.light,
                              ).show(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            } else if (status == "exist") {
                              AnimatedSnackBar.rectangle(
                                'Error',
                                'Email already exists.',
                                type: AnimatedSnackBarType.error,
                                brightness: Brightness.light,
                              ).show(context);
                              setState(() {
                                _isLoading = false;
                              });
                            } else {
                              print("error");
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          } else {
                            setState(() {
                              _isLoading = false; // Reset _isLoading to false
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Text(
                          'REGISTER',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            // Handle Create Account
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                          child: const Text(
                            "Already have an account?",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, IconData icon, RegExp reg, String errorMsg) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $labelText';
        } else if (!reg.hasMatch(value)) {
          return errorMsg;
        }
        return null;
      },
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String labelText, RegExp reg, bool obscure, void Function() toggleVisibility) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.white,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
          onPressed: toggleVisibility,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $labelText';
        } else if (!reg.hasMatch(value)) {
          return 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one digit';
        }
        return null;
      },
      style: const TextStyle(color: Colors.white),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmObscure = !_isConfirmObscure;
    });
  }
}
