import 'package:attendance_app/controller/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_screen.dart';

class MoreOptionScreen extends StatefulWidget {
  const MoreOptionScreen({Key? key}) : super(key: key);

  @override
  State<MoreOptionScreen> createState() => _MoreOptionScreenState();
}

class _MoreOptionScreenState extends State<MoreOptionScreen> {
  final HomeScreenController homeController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {


    return Container(
      height: double.infinity,
      width: double.infinity,
      child: TextButton(
        onPressed: () async{


          var sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.clear().then((value) => {

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginScreen())),

          setState(() {
          homeController.newIndex.value = 0;
          homeController.tappedIndex.value = 0;
          }),

          });


        },
        child: Text("Log Out"),
      ),
    );
  }
}
