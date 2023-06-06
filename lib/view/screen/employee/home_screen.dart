import 'dart:developer';

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
      // _getProfilePic();
    });

    _getCredentials();
    super.initState();
  }

  void _getCredentials() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("Employee")
          .doc(User.id)
          .get();
      setState(() {
        User.name = doc['name'];
        User.designation = doc['designation'];
        User.birthdate = doc['birthdate'];
        User.joiningDate = doc['joiningdate'];
        User.aadhaarNo = doc['aadhaar'];
        User.mail = doc['email'];
        User.panNo = doc['pan'];
        User.address = doc['address'];
        User.password = doc['password'];
        User.bloodGroup = doc['bloodgroup'];
        User.mobile = doc['mobile'];
        User.emergency = doc['emergency'];
      });


    } catch (e) {
      return;
    }
  }

  // void _getProfilePic() async {
  //   DocumentSnapshot doc = await FirebaseFirestore.instance
  //       .collection("Employee")
  //       .doc(User.id)
  //       .get();
  //   setState(() {
  //     User.profilePicLink = doc['profilePic'];
  //   });
  // }

  Future<void> getId() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("Employee")
        .where('id', isEqualTo: User.employeeId)
        .get();

    setState(() {
      User.id = snap.docs[0].id;
    });

    log("DATA  ==  ${snap.docs[0].data()}");
    log("DATA  ==  ${snap.docs[0].data().runtimeType}");

    log("DATA 1  ==  ${User.id}");
    log("DATA 1  ==  ${User.employeeId}");
    log("DATA 1 ==  ${User.designation}");
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
