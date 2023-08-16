import 'dart:developer';

import 'package:attendance_app/modal/const/const_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/home_screen_controller.dart';
import '../../../modal/const/const_color.dart';
import '../../../modal/const/list.dart';
import '../../../modal/custom/app_bar.dart';
import '../../../modal/custom/bottom_nav_bar.dart';
import '../../../modal/modal_class/notification_class.dart';
import '../../../modal/modal_class/user.dart';
import 'attendance_screen.dart';
import 'entry_in_out_screen.dart';
import 'more_option_screen.dart';
import 'daily_work_sheet.dart';

class EmployeeHomeScreen extends StatefulWidget {
  final int index = 0;

  const EmployeeHomeScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  final HomeScreenController homeController = Get.put(HomeScreenController());
  final String _month = DateFormat('MMMM').format(DateTime.now());

  @override
  void initState() {
    getId().then((value) {
      _getCredentials();
      _getProfilePic();
      homeController.fetchPresentDays(User.id, _month);
    });
    _getCredentials();
    _getProfilePic();
    super.initState();
  }

  void _getProfilePic() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("Employee")
        .doc(User.id)
        .get();
    setState(() {
      User.profile = doc['profile'] ?? "";
    });
  }

  void _getCredentials() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("Employee")
          .doc(User.id)
          .get();
      setState(() {
        User.name = doc['name'] ?? "";
        User.designation = doc['designation'] ?? "";
        User.birthdate = doc['birthdate'] ?? "";
        User.joiningDate = doc['joiningdate'] ?? "";
        User.aadhaarNo = doc['aadhaar'] ?? "";
        User.mail = doc['email'] ?? "";
        User.panNo = doc['pan'] ?? "";
        User.address = doc['address'] ?? "";
        User.password = doc['password'] ?? "";
        User.bloodGroup = doc['bloodgroup'] ?? "";
        User.mobile = doc['mobile'] ?? "";
        User.emergency = doc['emergency'] ?? "";
      });
    } catch (e) {
      return;
    }
  }

  Future<void> getId() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("Employee")
        .where('id', isEqualTo: User.employeeId)
        .get();

    setState(() {
      User.id = snap.docs[0].id;
    });
  }

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
                    height: MediaQuery.of(context).padding.top + size.height * 0.02,
                  ),
                  CustomAppBar(
                    onTap: () {
                      homeController.notificationVisible.value =
                          !homeController.notificationVisible.value;
                      log("NOTIFICATION BUTTON TAPPED....!");
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Expanded(
                    child: Obx(
                      () => homeController.newIndex.value == 0
                          ? const EntryInOutScreen()
                          : homeController.newIndex.value == 1
                              ? const AttendanceScreen()
                              : homeController.newIndex.value == 2
                                  ? const DailyWorkSheet()
                                  : const MoreOptionScreen(),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Visibility(
                visible: homeController.notificationVisible.value,
                child: Positioned(
                  top: MediaQuery.of(context).padding.top + size.height * 0.095,
                  right: size.width * 0.04,
                  left: size.width * 0.04,
                  child: Container(
                    height: size.height,
                    width: size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: ConstColor.primary),
                        color: ConstColor.primaryBackGround,
                        borderRadius: BorderRadius.circular(10)),
                    child: EasyRefresh(
                      onRefresh: () async {},
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: dummyNotificationList.length,
                          itemBuilder: (context, index) {
                            NotificationClass notification = dummyNotificationList[index];
                            return Column(
                              children: [
                                Container(
                                  width: size.width,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 12),
                                  margin: EdgeInsets.only(
                                      top: 10, right: 10, left: 10),
                                  decoration: BoxDecoration(
                                    color: ConstColor.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            notification.icon,
                                            height: 40,
                                            width: 40,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: size.width * 0.55,
                                            child: Text(
                                              notification.title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            ConstImage.optionVertical,
                                            height: 20,
                                            width: 20,
                                            color: ConstColor.grey,
                                          ),
                                          SizedBox(
                                            height: 1,
                                          ),
                                          Text(
                                            "4h",
                                            style: TextStyle(
                                                color: ConstColor.grey,
                                                fontSize: size.width * 0.03),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                (index == dummyNotificationList.length - 1)
                                    ? SizedBox(
                                        height: 25,
                                      )
                                    : SizedBox(),
                              ],
                            );
                          }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBar(
          size: size,
          onTap: (index) {
            homeController.newIndex.value = index;
            homeController.tappedIndex.value = index;
            homeController.notificationVisible.value = false;
          },
        ),
      ),
    );
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
}
