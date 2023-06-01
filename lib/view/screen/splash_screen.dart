import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:attendance_app/modal/const/const_color.dart';
import 'package:attendance_app/view/screen/employee/home_screen.dart';
import 'package:attendance_app/view/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../modal/modal_class/user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool userAvailable = false;
  late SharedPreferences sharedPreferences;


  @override
  void initState() {
    checkDistanceFromOffice();
    _getCurrentUser();
    super.initState();
    Timer(
      const Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => userAvailable ? const EmployeeHomeScreen() : const LoginScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
             colors: [
                ConstColor.primaryGradient1,
                ConstColor.primaryGradient2,
                ConstColor.primaryGradient3,
              ]
          )
        ),
        child: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                'Welcome to '
                    ' Janovis Infotech',
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  fontSize: size.width * 0.09,
                  fontWeight: FontWeight.bold,
                ),
                colors: [Colors.white, Colors.cyan, Colors.black],
              ),
            ],
            totalRepeatCount: 1,
            pause: const Duration(milliseconds: 500),
            displayFullTextOnTap: true,
          ),
        ),
      ),
    );
  }

  void _getCurrentUser() async {
    sharedPreferences = await SharedPreferences.getInstance();

    try {
      if (sharedPreferences.getString('employeeId') != null) {
        setState(() {
          User.employeeId = sharedPreferences.getString('employeeId')!;
          userAvailable = true;
        });
      }
    } catch (e) {
      setState(() {
        userAvailable = false;
      });
    }
  }
}
