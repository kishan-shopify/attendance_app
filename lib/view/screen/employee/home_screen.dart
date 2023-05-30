import 'package:attendance_app/demo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home_screen_controller.dart';
import '../../../modal/custom/bottom_nav_bar.dart';
import 'package:geolocator/geolocator.dart';
import '../../../modal/modal_class/user.dart';
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
    getId().then((value) {
      _getCredentials();
      _getProfilePic();
    });
    super.initState();
  }

  void _getCredentials() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("Employee")
          .doc(User.id)
          .get();
      setState(() {
        User.canEdit = doc['canEdit'];
        User.firstName = doc['firstName'];
        User.lastName = doc['lastName'];
        User.birthDate = doc['birthDate'];
        User.address = doc['address'];
      });
    } catch (e) {
      return;
    }
  }

  void _getProfilePic() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("Employee")
        .doc(User.id)
        .get();
    setState(() {
      User.profilePicLink = doc['profilePic'];
    });
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
