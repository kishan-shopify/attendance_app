import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/screen/admin/home_screen.dart';
import '../../view/screen/splash_screen.dart';
import '../const/const_color.dart';
import '../const/const_image.dart';

class CustomAdminAppBar extends StatefulWidget {
  final Function onTap;

  const CustomAdminAppBar({super.key, required this.onTap});

  @override
  State<CustomAdminAppBar> createState() => _CustomAdminAppBarState();
}

class _CustomAdminAppBarState extends State<CustomAdminAppBar> {

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
                Navigator.push(context, MaterialPageRoute(builder: (_) => AdminHomeScreen()));
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
    });
  }
}
