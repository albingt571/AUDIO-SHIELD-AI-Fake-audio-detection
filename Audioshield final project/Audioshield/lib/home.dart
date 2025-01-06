import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'navbar/analysisResultsPage.dart';
import 'navbar/mainhomepage.dart';
import 'navbar/profilePage.dart';
import 'navbar/settingsPage.dart';
import 'login.dart'; // Import your login page

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isNavBarVisible = true;
  Timer? _timer;

  static final List<Widget> _widgetOptions = <Widget>[
    MainHomePage(),
    AnalysisResultsPage(),
    const ProfilePage(),
    SettingsPage(),
  ];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 10), () {
      setState(() {
        _isNavBarVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF383737),
            title: const Text(
              'Exit App',
              style: TextStyle(color: Colors.red),
            ),
            content: const Text(
              'Are you sure you want to exit?',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'No',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  // Clear login state when exiting
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                        (route) => false,
                  );
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ) ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Image.asset(
            'lib/image/audioshield.png',
            width: 100,
          ),
        ),
        backgroundColor: Colors.black,
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollStartNotification) {
              setState(() {
                _isNavBarVisible = false;
              });
            } else if (scrollNotification is ScrollUpdateNotification) {
              if (scrollNotification.metrics.axis == Axis.vertical) {
                if (scrollNotification.metrics.pixels >
                    scrollNotification.metrics.maxScrollExtent) {
                  setState(() {
                    _isNavBarVisible = false;
                  });
                } else {
                  setState(() {
                    _isNavBarVisible = true;
                  });
                }
              }
            } else if (scrollNotification is ScrollEndNotification) {
              _startTimer();
            }
            return true;
          },
          child: Stack(
            children: [
              Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: 0,
                right: 0,
                bottom: _isNavBarVisible ? 0 : -displayWidth * .155,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF383737),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  margin: EdgeInsets.all(displayWidth * .05),
                  height: displayWidth * .155,
                  child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    padding:
                    EdgeInsets.symmetric(horizontal: displayWidth * .02),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                            HapticFeedback.lightImpact();
                          });
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Stack(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              width: index == _selectedIndex
                                  ? displayWidth * .32
                                  : displayWidth * .18,
                              alignment: Alignment.center,
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                height: index == _selectedIndex
                                    ? displayWidth * .12
                                    : 0,
                                width: index == _selectedIndex
                                    ? displayWidth * .32
                                    : 0,
                                decoration: BoxDecoration(
                                  color: index == _selectedIndex
                                      ? Colors.blueAccent.withOpacity(.2)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              width: index == _selectedIndex
                                  ? displayWidth * .31
                                  : displayWidth * .18,
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  Row(
                                    children: [
                                      AnimatedContainer(
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        width: index == _selectedIndex
                                            ? displayWidth * .13
                                            : 0,
                                      ),
                                      AnimatedOpacity(
                                        opacity:
                                        index == _selectedIndex ? 1 : 0,
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        child: Text(
                                          index == _selectedIndex
                                              ? '${listOfStrings[index]}'
                                              : '',
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      AnimatedContainer(
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        width: index == _selectedIndex
                                            ? displayWidth * .03
                                            : 20,
                                      ),
                                      Icon(
                                        listOfIcons[index],
                                        size: displayWidth * .076,
                                        color: index == _selectedIndex
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.analytics_rounded,
    Icons.person_rounded,
    Icons.settings_rounded,
  ];

  List<String> listOfStrings = [
    'Home',
    'Analysis',
    'Profile',
    'Settings'
  ];
}
