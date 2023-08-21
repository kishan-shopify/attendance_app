import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmployeeController extends GetxController {
  var employees = <Map<String, dynamic>>[].obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList employeeAttendanceList = [].obs;
  RxString selectedDropdownValue = 'Pending'.obs;
  Rx<TextEditingController> remark = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
  }

  void updateSelectedDropdownValue(String value) {
    selectedDropdownValue.value = value;
  }

  void fetchEmployees() async {
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection('Employee').get();
      employees.value = snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching employees: $e");
    }
  }

  getAttendance(String userID, month) async {
    try {
      final snapshot = await firestore
          .collection("Employee")
          .doc(userID)
          .collection("Record")
          .orderBy('date', descending: true)
          .get();

      final attendanceList = snapshot.docs.where((doc) {
        final date = doc['date'].toDate();
        return DateFormat('MMMM').format(date) == month;
      }).toList();

      employeeAttendanceList.value = attendanceList;
    } catch (error) {
      // Handle the error
    }
  }

  Future<List<Map<String, dynamic>>> getLeaves() async {
    List<Map<String, dynamic>> leavesList = [];
    try {
      CollectionReference employees =
      FirebaseFirestore.instance.collection('Employee');
      QuerySnapshot employeeSnapshot = await employees.get();

      for (QueryDocumentSnapshot employeeDoc in employeeSnapshot.docs) {
        String employeeId = employeeDoc.id;
        Map<String, dynamic> employeeData = employeeDoc.data() as Map<String, dynamic>;
        String employeeName = employeeData['name']; // Get the employee name

        // Reference to the 'Leaves' sub-collection within each employee document
        CollectionReference leavesCollection = employees.doc(employeeId).collection('Leaves');

        // Get all documents from the 'Leaves' sub-collection
        QuerySnapshot leavesSnapshot = await leavesCollection.orderBy('date', descending: false).get();

        // Iterate through each leave document and add it to the list
        for (QueryDocumentSnapshot leaveDoc in leavesSnapshot.docs) {
          Map<String, dynamic>? leaveData = leaveDoc.data() as Map<String, dynamic>?;
          leaveData?['employeeId'] = employeeId;
          leaveData?['employeeName'] = employeeName; // Add employeeName to the leave data
          leavesList.add(leaveData!);
        }
      }
      log("LEAVES === $leavesList");
      log("LEAVES === ${leavesList.length}");
      return leavesList;
    } catch (e) {
      print('Error fetching leaves: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getTimeRequest() async{

    List<Map<String, dynamic>> timeRequestList = [];

    try {
      CollectionReference employees = FirebaseFirestore.instance.collection('Employee');
      QuerySnapshot employeeSnapshot = await employees.get();

      for (QueryDocumentSnapshot employeeDoc in employeeSnapshot.docs) {
        String employeeId = employeeDoc.id;
        Map<String, dynamic> employeeData = employeeDoc.data() as Map<String, dynamic>;
        String employeeName = employeeData['name']; // Get the employee name

        CollectionReference requestCollection = employees.doc(employeeId).collection('TimeChange');

        QuerySnapshot requestSnapshot = await requestCollection.orderBy('date', descending: false).get();

        for (QueryDocumentSnapshot requestDoc in requestSnapshot.docs) {
          Map<String, dynamic>? requestData = requestDoc.data() as Map<String, dynamic>?;
          requestData?['employeeId'] = employeeId;
          requestData?['employeeName'] = employeeName;
          timeRequestList.add(requestData!);
        }
      }
      return timeRequestList;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }

  }

}
