import 'dart:async';
import '../../modal/const/const_color.dart';
import '../../modal/const/const_image.dart';
import '../../modal/const/text_style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modal/modal_class/user.dart';
import 'employee/home_screen.dart';
import 'login_screen.dart';


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


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: ConstColor.white,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.12),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.3),
            SizedBox(
              height: size.height * 0.25,
              width: size.width * 0.5,
              child: Image.network(
                ConstImage.splash,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: size.height * 0.030),
            Text(
              "Welcome to",
              textAlign: TextAlign.center,
              maxLines: 1,
              style: textStyleW600(size.width * 0.062, ConstColor.blackText),
            ),
            Text(
              "Janovis Infotech",
              textAlign: TextAlign.center,
              maxLines: 1,
              style: textStyleW600(size.width * 0.068, ConstColor.blackText),
            ),
          ],
        ),
      ),
    );
  }

  void _getCurrentUser() async {
    sharedPreferences = await SharedPreferences.getInstance();

    try {
      if (sharedPreferences.getString('employeeId') != null) {
        User.employeeId = sharedPreferences.getString('employeeId')!;
        userAvailable = true;
      }
    }
    catch (e) {
      setState(() {
        userAvailable = false;
      });
    }
  }
}
