import 'package:attendance_app/demo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home_screen_controller.dart';
import '../../../modal/custom/bottom_nav_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'attendance_screen.dart';
import 'entry_in_out_screen.dart';
import 'more_option_screen.dart';
import 'notification_screen.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () => controller.newIndex.value == 0
            ? const EntryInOutScreen()
            // ?  MyScreen()
            : controller.newIndex.value == 1
                ? const AttendanceScreen()
                : controller.newIndex.value == 2
                    ? const NotificationScreen()
                    : const MoreOptionScreen(),
      ),
      bottomNavigationBar: BottomNavBar(
        size: size,
        onTap: (index) {
          controller.newIndex.value = index;
          controller.tappedIndex.value = index;
        },
      ),
    );
  }
}
