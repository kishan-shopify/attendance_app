import 'package:attendance_app/controller/home_screen_controller.dart';
import 'package:attendance_app/modal/const/list.dart';
import 'package:attendance_app/modal/const/text_style.dart';
import 'package:attendance_app/modal/modal_class/user.dart';
import 'package:attendance_app/view/screen/employee/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../demo.dart';
import '../../../modal/const/const_color.dart';
import '../../../modal/const/const_image.dart';
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
    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        RotatedBox(
          quarterTurns: 2,
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              ConstImage.background,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(
                height:
                    MediaQuery.of(context).padding.top + size.height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.height * 0.15,
                  width: size.width * 0.35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        blurRadius: 4,
                        offset: const Offset(2, 4), // Shadow position
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: size.width * 0.35,
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/rutvik.jpg",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Text( User.name,
                  style: textStyleW600(size.width * 0.06, ConstColor.blackText),
                ),
                Text(
                  User.designation,
                  style: textStyleW500(size.width * 0.038,
                      ConstColor.blackText.withOpacity(0.8)),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color: ConstColor.white.withOpacity(0.85),
                ),
                child: ListView.builder(
                    itemCount: moreOptionList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if(index == 0){
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
                              }
                              else if(index == 1){}
                              else if(index == 2){}
                              else if(index == 3){}
                              else if(index == 4){}

                              if (index == 5) {
                                logout();
                              }
                            },
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 25,
                                      width: 30,
                                      child: Image.asset(
                                        moreOptionList[index],
                                        fit: BoxFit.contain,
                                        color: ConstColor.grey.withOpacity(0.9),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: size.width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          moreOptionListTitle[index],
                                          style: textStyleW500(
                                            size.width * 0.04,
                                            ConstColor.grey.withOpacity(0.9),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 1,
                                          color:
                                              ConstColor.grey.withOpacity(0.9),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  logout() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear().then((value) => {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const LoginScreen())),
          setState(() {
            homeController.newIndex.value = 0;
            homeController.tappedIndex.value = 0;
          }),
        });
  }
}
