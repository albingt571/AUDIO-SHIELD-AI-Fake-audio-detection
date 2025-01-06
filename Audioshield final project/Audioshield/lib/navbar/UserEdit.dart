import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class UserEdit extends StatefulWidget {
  const UserEdit({super.key});

  @override
  _UserEditState createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  XFile? _image;

  final RegExp fnameRegExp = RegExp(r'^[A-Za-z ]{2,25}$');
  final RegExp lnameRegExp = RegExp(r'^[A-Za-z ]{0,25}$');
  final RegExp phoneRegExp = RegExp(r'^[6789]\d{9}$');
  final RegExp placeRegExp = RegExp(r'^[A-Za-z. ]{2,25}$');
  final RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,25}$');

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    final sh = await SharedPreferences.getInstance();
    setState(() {
      fnameController.text = sh.getString("fname") ?? '';
      lnameController.text = sh.getString("lname") ?? '';
      placeController.text = sh.getString("place") ?? '';
      phoneController.text = sh.getString("phone") ?? '';
      emailController.text = sh.getString("email") ?? '';
    });
  }

  void _imgFromCamera() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void _imgFromGallery() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void _showPicker(BuildContext context) {
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("Update Profile"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/image/backgroundimage.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.grey, Colors.black],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => _showPicker(context),
                            child: CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: _image != null
                                  ? FileImage(File(_image!.path))
                                  : null,
                              child: _image == null
                                  ? const Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.black54,
                              )
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // TextFormField for First Name
                          TextFormField(
                            controller: fnameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                              labelStyle: TextStyle(color: Colors.white),
                              prefixIcon: Icon(Icons.person, color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              if (!fnameRegExp.hasMatch(value)) {
                                return 'Please enter a valid first name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          // TextFormField for Last Name
                          TextFormField(
                            controller: lnameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                              labelStyle: TextStyle(color: Colors.white),
                              prefixIcon: Icon(Icons.person, color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            validator: (value) {
                              if (!lnameRegExp.hasMatch(value!)) {
                                return 'Please enter a valid last name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          // TextFormField for Place
                          TextFormField(
                            controller: placeController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Place',
                              labelStyle: TextStyle(color: Colors.white),
                              prefixIcon: Icon(Icons.location_on, color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            validator: (value) {
                              if (!placeRegExp.hasMatch(value!)) {
                                return 'Please enter a valid place';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          // TextFormField for Phone
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Phone',
                              labelStyle: TextStyle(color: Colors.white),
                              prefixIcon: Icon(Icons.phone, color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            validator: (value) {
                              if (!phoneRegExp.hasMatch(value!)) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          // TextFormField for Email
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white),
                              prefixIcon: Icon(Icons.email, color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            validator: (value) {
                              if (!emailRegExp.hasMatch(value!)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        try {
                          final sh = await SharedPreferences.getInstance();
                          String fname = fnameController.text.toString();
                          String lname = lnameController.text.toString();
                          String place = placeController.text.toString();
                          String phone = phoneController.text.toString();
                          String email = emailController.text.toString();
                          String base64Image = '';
                          if (_image != null) {
                            final bytes = File(_image!.path).readAsBytesSync();
                            base64Image = base64Encode(bytes);
                          }
                          String url = sh.getString("url").toString();

                          var data = await http.post(
                            Uri.parse("${url}editeduser"),
                            body: {
                              'fname': fname,
                              'lname': lname,
                              "place": place,
                              "phone": phone,
                              "email": email,
                              "photo": base64Image,
                              'id': sh.getString("id").toString()
                            },
                          );

                          var jasondata = json.decode(data.body);
                          String status = jasondata['task'].toString();

                          if (status == "ok") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Successfully Updated'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Server Error'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }
                        } catch (e) {
                          final sh = await SharedPreferences.getInstance();
                          String fname = fnameController.text.toString();
                          String lname = lnameController.text.toString();
                          String place = placeController.text.toString();
                          String phone = phoneController.text.toString();
                          String email = emailController.text.toString();
                          String url = sh.getString("url").toString();

                          var data = await http.post(
                            Uri.parse("${url}editeduser"),
                            body: {
                              'fname': fname,
                              'lname': lname,
                              "place": place,
                              "phone": phone,
                              "email": email,
                              "photo": "",
                              'id': sh.getString("id").toString()
                            },
                          );

                          var jasondata = json.decode(data.body);
                          String status = jasondata['task'].toString();

                          if (status == "ok") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Successfully Updated'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Server Error'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.red,
                        ),
                      ),
                      child: const Text("Update"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
