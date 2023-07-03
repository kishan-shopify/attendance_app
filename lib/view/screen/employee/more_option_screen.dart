
import 'package:attendance_app/view/screen/employee/leave_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home_screen_controller.dart';
import '../../../modal/const/const_color.dart';
import '../../../modal/const/const_image.dart';
import '../../../modal/modal_class/user.dart';
import 'profile_page.dart';

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
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Profile",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: ConstColor.blackText,
                        fontSize: size.width * 0.07)),
              ],
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Container(
              width: size.width,
              height: size.height * 0.2,
              decoration: BoxDecoration(
                color: ConstColor.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.09,
                  ),
                  Text(
                    User.name,
                    style: TextStyle(
                        fontSize: size.width * 0.055,
                        color: ConstColor.blackText,
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    User.designation,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        // size.width * 0.042,
                        fontWeight: FontWeight.w600,
                        color: ConstColor.blackText.withOpacity(0.6)),
                  ),
                  Text(
                    "Joined from ${User.joiningDate}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        // size.width * 0.042,
                        fontWeight: FontWeight.w600,
                        color: ConstColor.blackText.withOpacity(0.6)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Container(
              width: size.width,
              height: size.height * 0.12,
              decoration: BoxDecoration(
                color: ConstColor.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Late",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            // size.width * 0.042,
                            fontWeight: FontWeight.w600,
                            color: ConstColor.blackText.withOpacity(0.5)),
                      ),
                      Text(
                        "${homeController.lateComing}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: size.width * 0.05,
                            // size.width * 0.042,
                            fontWeight: FontWeight.w600,
                            color: ConstColor.blackText.withOpacity(0.7)),
                      ),
                    ],
                  ),
                  Container(
                    height: 25,
                    width: 1,
                    color: ConstColor.primary,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Attendance",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            // size.width * 0.042,
                            fontWeight: FontWeight.w600,
                            color: ConstColor.blackText.withOpacity(0.5)),
                      ),
                      Text(
                        "${homeController.presentDays.length}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: size.width * 0.05,
                            // size.width * 0.042,
                            fontWeight: FontWeight.w600,
                            color: ConstColor.blackText.withOpacity(0.7)),
                      ),
                    ],
                  ),
                  Container(
                    height: 25,
                    width: 1,
                    color: ConstColor.primary,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Early",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            // size.width * 0.042,
                            fontWeight: FontWeight.w600,
                            color: ConstColor.blackText.withOpacity(0.5)),
                      ),
                      Text(
                        "${homeController.earlyGoing}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: size.width * 0.05,
                            // size.width * 0.042,
                            fontWeight: FontWeight.w600,
                            color: ConstColor.blackText.withOpacity(0.7)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              width: size.width,
              height: size.height * 0.06,
              decoration: BoxDecoration(
                color: ConstColor.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Image.asset(ConstImage.general),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "General Settings",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: size.width * 0.042,
                        // size.width * 0.042,
                        fontWeight: FontWeight.w600,
                        color: ConstColor.blackText.withOpacity(0.7)),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Image.asset(ConstImage.forward),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: size.height * 0.015,
            // ),
            // Container(
            //   padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
            //   width: size.width,
            //   height: size.height * 0.06,
            //   decoration: BoxDecoration(
            //     color: ConstColor.white,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Row(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 2),
            //         child: Image.asset(ConstImage.calendar),
            //       ),
            //       const SizedBox(width: 15,),
            //       Text(
            //         "My Attendance",
            //         maxLines: 1,
            //         overflow: TextOverflow.ellipsis,
            //         style: TextStyle(
            //             fontSize: size.width * 0.042,
            //             // size.width * 0.042,
            //             fontWeight: FontWeight.w600,
            //             color: ConstColor.blackText.withOpacity(0.7)),
            //       ),
            //       Expanded(child: Container()),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 10.0),
            //         child: Image.asset(ConstImage.forward),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: size.height * 0.015,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => LeaveSection()));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                width: size.width,
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  color: ConstColor.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Image.asset(ConstImage.leave),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Apply Leave",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: size.width * 0.042,
                          // size.width * 0.042,
                          fontWeight: FontWeight.w600,
                          color: ConstColor.blackText.withOpacity(0.7)),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Image.asset(ConstImage.forward),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: InkWell(
            onTap: () {

            },
            child: Column(
              children: [
                SizedBox(height: size.height * 0.05,),
                CircleAvatar(
                  backgroundColor: ConstColor.white,
                  radius: size.width * 0.18,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(
                      child: (User.profile == " ")
                          ? Image.asset(
                              ConstImage.rutvik,
                            )
                          : Image.network(User.profile),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


}
