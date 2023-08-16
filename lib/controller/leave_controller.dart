import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../modal/custom/progress_indicator.dart';
import '../modal/modal_class/leave_class.dart';
import '../modal/modal_class/user.dart';
import '../view/screen/employee/home_screen.dart';
import 'home_screen_controller.dart';

class LeaveController extends GetxController {
  RxList<LeaveData> pendingLeaves = <LeaveData>[].obs;
  RxList<LeaveData> approvedLeaves = <LeaveData>[].obs;
  RxList<LeaveData> rejectedLeaves = <LeaveData>[].obs;


  RxString startDate = ''.obs;
  RxString endDate = ''.obs;
  Rx<TextEditingController> leaveReason = TextEditingController().obs;
  RxString selectedDropdownValue = 'Casual Leave'.obs;

  final Stream<QuerySnapshot> leaveStream = FirebaseFirestore.instance
      .collection('Employee')
      .doc(User.id)
      .collection('Leaves')
      .snapshots();



  final HomeScreenController homeController = Get.put(HomeScreenController());

  void updateStartDate(String date) {
    startDate.value = date;
  }

  void updateEndDate(String date) {
    endDate.value = date;
  }

  void updateLeaveReason(String reason) {
    leaveReason.value.text = reason;
  }

  void updateSelectedDropdownValue(String value) {
    selectedDropdownValue.value = value;
  }

  Future<void> applyLeave(context) async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("Employee")
        .where('id', isEqualTo: User.employeeId)
        .get();

    log("APPLIED...");
    try {
      String formattedStartDate = DateFormat('dd MMMM yyyy').format(
          DateFormat('dd-MM-yyyy').parse(startDate.value)
      );
      String formattedEndDate = DateFormat('dd MMMM yyyy').format(
          DateFormat('dd-MM-yyyy').parse(endDate.value)
      );


      ProgressDialog().show(context);
      await FirebaseFirestore.instance
          .collection("Employee")
          .doc(snap.docs[0].id)
          .collection("Leaves")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .set({
        "date": Timestamp.now(),
        "updatedDate" : Timestamp.now(),
        "status": "Pending",
        "startDate": formattedStartDate,
        "endDate": formattedEndDate,
        "remark" : "",
        "leaveType": selectedDropdownValue.value,
        "reason": leaveReason.value.text,
      });


      leaveReason.value.clear();
      startDate.value = "";
      endDate.value = "";

      ProgressDialog().hide(context);

      Navigator.push(context, MaterialPageRoute(builder: (_) => EmployeeHomeScreen()));
      homeController.newIndex.value = 0;
      homeController.tappedIndex.value = 0;
      homeController.notificationVisible.value = false;

      log("GO TO THE HOME SCREEN");

    } catch (error) {
      log("Getting error for applying leave :- $error");
    }
  }

  void updateLeaves(QuerySnapshot snapshot) {
    pendingLeaves.clear();
    approvedLeaves.clear();
    rejectedLeaves.clear();

    for (var doc in snapshot.docs) {
      var leaveData = doc.data() as Map<String, dynamic>;
      var leave = LeaveData(
        startDate: leaveData['startDate'],
        endDate: leaveData['endDate'],
        leaveType: leaveData['leaveType'],
        status: leaveData['status'],
        reason: leaveData['reason'],
      );

      if (leave.status == 'Pending') {
        pendingLeaves.add(leave);
      } else if (leave.status == 'Approved') {
        approvedLeaves.add(leave);
      } else if (leave.status == 'Rejected') {
        rejectedLeaves.add(leave);
      }
    }
  }

}
