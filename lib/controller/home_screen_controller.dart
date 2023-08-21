import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreenController extends GetxController {
  RxInt newIndex = 0.obs;
  RxInt tappedIndex = 0.obs;
  RxInt leaves = 0.obs;
  RxInt lateComing = 0.obs;
  RxInt earlyGoing = 0.obs;
  RxBool isLoading = false.obs;
  RxBool notificationVisible = false.obs;

  RxString status = "".obs;

  RxList presentDays = [].obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

   fetchPresentDays(String userId, String month) async {
    try {
      final snapshot = await firestore.collection("Employee").doc(userId).collection("Record")
          .orderBy('date', descending: true).get();

      final presentDaysList = snapshot.docs.where((doc) {
        final date = doc['date'].toDate();
        return DateFormat('MMMM').format(date) == month;
      }).toList();

      presentDays.value = presentDaysList;

      // Calculate lateComing and update lateComing count
      lateComing.value = presentDaysList.where((doc) {
        String checkInTime = doc['checkIn'];
        if (checkInTime == "--/--") return false;

        DateTime parsedCheckInTime = DateFormat('hh:mm a').parse(checkInTime);
        TimeOfDay checkInTimeOfDay = TimeOfDay.fromDateTime(parsedCheckInTime);
        TimeOfDay lateComingTime = TimeOfDay(hour: 9, minute: 30);
        DateTime checkInDateTime = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            checkInTimeOfDay.hour,
            checkInTimeOfDay.minute);
        DateTime lateComingDateTime = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            lateComingTime.hour,
            lateComingTime.minute);
        return checkInDateTime.isAfter(lateComingDateTime);
      }).length;

      // Calculate earlyGoing and update earlyGoing count
      earlyGoing.value = presentDaysList.where((doc) {
        String checkOutTime = doc['checkOut'];
        if (checkOutTime == "--/--") return false;

        DateTime parsedCheckOutTime = DateFormat('hh:mm a').parse(checkOutTime);
        TimeOfDay checkOutTimeOfDay = TimeOfDay.fromDateTime(parsedCheckOutTime);
        TimeOfDay earlyGoingTime = TimeOfDay(hour: 19, minute: 30);
        DateTime checkOutDateTime = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            checkOutTimeOfDay.hour,
            checkOutTimeOfDay.minute
        );
        DateTime earlyGoingDateTime = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            earlyGoingTime.hour,
            earlyGoingTime.minute);
        return checkOutDateTime.isBefore(earlyGoingDateTime);
      }).length;
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}
