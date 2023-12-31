
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/home_screen_controller.dart';
import '../../view/screen/employee/home_screen.dart';
import '../../view/screen/splash_screen.dart';
import '../const/const_color.dart';
import '../const/const_image.dart';

class CustomAppBar extends StatefulWidget {
  final Function onTap;

  const CustomAppBar({super.key, required this.onTap});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final HomeScreenController homeController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.065,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ConstColor.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.03,
              bottom: 10,
            ),
            child: InkWell(
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => EmployeeHomeScreen()));
              homeController.newIndex.value = 0;
              homeController.tappedIndex.value = 0;
              homeController.notificationVisible.value = false;
              },
              child: Image.asset(
                ConstImage.janovisLogo,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: size.width * 0.03,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    widget.onTap();
                  },
                  child: Image.asset(
                    ConstImage.notificationFill,
                    height: 35,
                    width: 35,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    logout();
                  },
                  child: Image.asset(
                    ConstImage.logout,
                    height: 35,
                    width: 35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  logout() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear().then((value) => {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SplashScreen(),
            ),
          ),
          setState(() {
            homeController.newIndex.value = 0;
            homeController.tappedIndex.value = 0;
          }),
        });
  }
}
