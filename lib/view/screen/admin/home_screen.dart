import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../modal/const/const_color.dart';
import '../../../modal/const/const_image.dart';
import '../../../modal/const/text_style.dart';
import '../../../modal/custom/admin_app_bar.dart';
import 'employee_leave_request.dart';
import 'employee_list.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => showExitConfirmationDialog(context),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              height: double.infinity,
              width: double.infinity,
              color: ConstColor.primaryBackGround,
              child: Column(
                children: [
                  SizedBox(
                    height:
                        MediaQuery.of(context).padding.top + size.height * 0.02,
                  ),
                  CustomAdminAppBar(
                    onTap: () {
                      log("NOTIFICATION BUTTON TAPPED....!");
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              getGreetingMessage(),
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                              style: textStyleW400(size.width * 0.042,
                                  ConstColor.blackText.withOpacity(0.8)),
                            ),
                            Text(
                              "Let's get to work",
                              style: textStyleW700(
                                  size.width * 0.062, ConstColor.blackText),
                            ),
                          ],
                        ),
                        Image.asset(
                          ConstImage.stopwatch,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  labelContainer(
                      size, "See Employee", ConstImage.profile, () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => EmployeeList()));
                  }),
                  SizedBox(
                    height: 15,
                  ),
                  labelContainer(
                      size, "Daily Worksheet", ConstImage.worksheet, () {}),
                  SizedBox(
                    height: 15,
                  ),
                  labelContainer(
                      size, "Leave Request", ConstImage.leave, () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => EmployeeLeaveRequest()));
                  }),
                  SizedBox(
                    height: 15,
                  ),
                  labelContainer(
                      size, "Time Change Request", ConstImage.clock, () {}),
                ],
              ),
            ),
            // Obx(
            //       () => Visibility(
            //     visible: homeController.notificationVisible.value,
            //     child: Positioned(
            //       top: MediaQuery.of(context).padding.top + size.height * 0.095,
            //       right: size.width * 0.04,
            //       left: size.width * 0.04,
            //       child: Container(
            //         height: size.height,
            //         width: size.width,
            //         decoration: BoxDecoration(
            //             border: Border.all(color: ConstColor.primary),
            //             color: ConstColor.primaryBackGround,
            //             borderRadius: BorderRadius.circular(10)),
            //         child: EasyRefresh(
            //           onRefresh: () async {},
            //           child: ListView.builder(
            //               padding: EdgeInsets.zero,
            //               itemCount: dummyNotificationList.length,
            //               itemBuilder: (context, index) {
            //                 NotificationClass notification = dummyNotificationList[index];
            //                 return Column(
            //                   children: [
            //                     Container(
            //                       width: size.width,
            //                       padding: EdgeInsets.symmetric(
            //                           horizontal: 15, vertical: 12),
            //                       margin: EdgeInsets.only(
            //                           top: 10, right: 10, left: 10),
            //                       decoration: BoxDecoration(
            //                         color: ConstColor.white,
            //                         borderRadius: BorderRadius.circular(12),
            //                       ),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Row(
            //                             children: [
            //                               Image.asset(
            //                                 notification.icon,
            //                                 height: 40,
            //                                 width: 40,
            //                               ),
            //                               SizedBox(
            //                                 width: 20,
            //                               ),
            //                               Container(
            //                                 width: size.width * 0.55,
            //                                 child: Text(
            //                                   notification.title,
            //                                   maxLines: 2,
            //                                   overflow: TextOverflow.ellipsis,
            //                                   style: TextStyle(),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                           Column(
            //                             crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                             children: [
            //                               Image.asset(
            //                                 ConstImage.optionVertical,
            //                                 height: 20,
            //                                 width: 20,
            //                                 color: ConstColor.grey,
            //                               ),
            //                               SizedBox(
            //                                 height: 1,
            //                               ),
            //                               Text(
            //                                 "4h",
            //                                 style: TextStyle(
            //                                     color: ConstColor.grey,
            //                                     fontSize: size.width * 0.03),
            //                               ),
            //                             ],
            //                           )
            //                         ],
            //                       ),
            //                     ),
            //                     (index == dummyNotificationList.length - 1)
            //                         ? SizedBox(
            //                       height: 25,
            //                     )
            //                         : SizedBox(),
            //                   ],
            //                 );
            //               }),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  String getGreetingMessage() {
    final currentTime = DateTime.now();
    if (currentTime.hour < 12) {
      return "Good morning ";
    } else if (currentTime.hour < 18) {
      return "Good afternoon ";
    } else {
      return "Good evening ";
    }
  }

  showExitConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to exit?'),
          actions: [
            TextButton(
              child: Text('Yes'),
              onPressed: () => SystemNavigator.pop(),
            ),
            TextButton(
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        );
      },
    );
  }

  Widget labelContainer(size, label, imageString, Function onTap) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: size.height * 0.09,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        decoration: BoxDecoration(
          border: Border.all(color: ConstColor.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                    height: 50,
                    width: 50,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Color(0XFFf7c343), shape: BoxShape.circle),
                    child: Image.asset(
                      imageString,

                      height: 35,
                      width: 35,
                    )),
                SizedBox(
                  width: 15,
                ),
                Text(
                  label,
                  style:
                      textStyleW600(size.width * 0.048, ConstColor.blackText),
                ),
              ],
            ),
            Image.asset(ConstImage.forward)
          ],
        ),
      ),
    );
  }
}
