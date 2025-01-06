import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  _ComplaintPageState createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  List<String> ccidList = [];
  List<String> dateList = [];
  List<String> replyList = [];
  List<String> complaintList = [];

  @override
  void initState() {
    super.initState();
    loadComplaints();
  }

  Future<void> loadComplaints() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String lid = prefs.getString("lid") ?? "";
      String url = prefs.getString("url") ?? "";

      var response = await http.post(Uri.parse("${url}complaint_view_reply"), body: {'lid': lid});

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        String status = jsonData['status'];

        if (status == 'ok') {
          var complaints = jsonData["data"];

          for (var complaint in complaints) {
            ccidList.add(complaint['id'].toString());
            dateList.add(complaint['date'].toString());
            replyList.add(complaint['reply'].toString());
            complaintList.add(complaint['complaint'].toString());
          }
          setState(() {});
        } else {
          print("Server error: ${jsonData['message']}");
        }
      } else {
        print("HTTP error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complaints"),
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
          itemCount: ccidList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const SizedBox(height: 16,),
                            Row(
                              children: [
                                const SizedBox(width: 10,),
                                const Flexible(
                                  flex: 2,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text(" Date")],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text(dateList[index])],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16,),
                            Row(
                              children: [
                                const SizedBox(width: 10,),
                                const Flexible(
                                  flex: 2,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text("Complaint")],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text(complaintList[index])],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16,),
                            Row(
                              children: [
                                const SizedBox(width: 10,),
                                const Flexible(
                                  flex: 2,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text("Reply")],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.loose,
                                  child: Row(
                                    children: [Text(replyList[index])],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
            MaterialPageRoute(
              builder: (context) => const NewComplaintPage(),
            ),
          ).then((newComplaint) {
            if (newComplaint != null) {
              // Handle the new complaint here
            }
          });
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NewComplaintPage extends StatefulWidget {
  const NewComplaintPage({super.key});

  @override
  _NewComplaintPageState createState() => _NewComplaintPageState();
}

class _NewComplaintPageState extends State<NewComplaintPage> {
  final TextEditingController _complaintController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Initialize _formKey

  @override
  void dispose() {
    _complaintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Write a New Complaint"),
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
          child: Form( // Wrap your content with Form widget
            key: _formKey, // Use the _formKey here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _complaintController,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your complaint';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Complaint",
                    labelStyle: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                    ),
                    hintText: 'Enter your complaint...',
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
                      Icons.error,
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
                      String complaint = _complaintController.text.toString();
                      String url = sh.getString("url").toString();
                      String lid = sh.getString("lid").toString();

                      var response = await http.post(
                        Uri.parse("${url}complaintadd"),
                        body: {'complaint': complaint, 'lid': lid},
                      );
                      var jsonData = json.decode(response.body);
                      String status = jsonData['task'].toString();
                      if (status == "ok") {
                        Navigator.pop(context);
                      } else {
                        print("Error: $status");
                        // You can display an error message to the user
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Set button color to red
                  ),
                  child: const Text("Submit Complaint"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
