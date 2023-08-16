import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/employee_list_controller.dart';
import '../../../modal/const/const_color.dart';
import '../../../modal/const/text_style.dart';
import '../../../modal/custom/admin_app_bar.dart';

class EmployeeAttendanceScreen extends StatefulWidget {
  final String userID;

  EmployeeAttendanceScreen({super.key, required this.userID});

  @override
  State<EmployeeAttendanceScreen> createState() =>
      _EmployeeAttendanceScreenState();
}

class _EmployeeAttendanceScreenState extends State<EmployeeAttendanceScreen> {
  final EmployeeController employeeController = Get.put(EmployeeController());

  var month;
  DateTime currentDate = DateTime.now();

  void updateMonth(int offset) {
    currentDate = DateTime(currentDate.year, currentDate.month + offset);
    setState(() {});
    month = DateFormat('MMMM').format(currentDate);
    employeeController.getAttendance(widget.userID, month);
  }

  @override
  void initState() {
    updateMonth(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        height: double.infinity,
        width: double.infinity,
        color: ConstColor.primaryBackGround,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + size.height * 0.02,
            ),
            CustomAdminAppBar(
              onTap: () {},
            ),
            SizedBox(
              height: size.height * 0.04
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Profile",
                  style: textStyleW700(
                    size.width * 0.07,
                    ConstColor.blackText,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                ),
                GestureDetector(
                    onTap: () {
                      updateMonth(-1);
                    },
                    child: Icon(Icons.arrow_back)),
                Expanded(child: Container()),
                Text(
                  DateFormat('MMMM').format(currentDate),
                  // _month,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: ConstColor.blackText,
                    fontSize: size.width * 0.05,
                  ),
                ),
                Expanded(child: Container()),
                GestureDetector(
                    onTap: () {
                      updateMonth(1);
                    },
                    child: Icon(Icons.arrow_forward)),
                SizedBox(
                  width: 50,
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Expanded(
              child: Container(
                height: size.height / 1.5,
                child: EasyRefresh(
                  onRefresh: () async {
                    employeeController.getAttendance(widget.userID, month);
                  },
                  child: Obx(() {
                    if (employeeController.employeeAttendanceList.isEmpty) {
                      return Center(
                        child: Text(
                          'No Data Found',
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.w700,
                            color: ConstColor.blackText,
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount:
                            employeeController.employeeAttendanceList.length,
                        itemBuilder: (context, index) {
                          final doc = employeeController.employeeAttendanceList[index];
                          final date = doc['date'].toDate();
                          final checkIn = doc['checkIn'];
                          final checkOut = doc['checkOut'];
                          return Container(
                            width: size.width,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: ConstColor.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        width: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            color:
                                                ConstColor.primaryBackGround),
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Text(
                                              DateFormat('dd').format(date),
                                              style: TextStyle(
                                                fontSize: size.width * 0.045,
                                                color: ConstColor.blackText,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('EE').format(date),
                                              style: TextStyle(
                                                fontSize: size.width * 0.04,
                                                color: ConstColor.blackText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Punch in",
                                              style: TextStyle(
                                                fontSize: size.width * 0.039,
                                                color: ConstColor.blackText,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              checkIn,
                                              style: TextStyle(
                                                fontSize: size.width * 0.037,
                                                color: ConstColor.blackText
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Punch out",
                                              style: TextStyle(
                                                fontSize: size.width * 0.037,
                                                color: ConstColor.blackText,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              checkOut,
                                              style: TextStyle(
                                                fontSize: size.width * 0.038,
                                                color: ConstColor.blackText
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: dayStatusColor(checkIn, checkOut),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(11),
                                      bottomRight: Radius.circular(11),
                                    ),
                                  ),
                                  width: 70,
                                  height: 80,
                                  child: Text(
                                    dayStatus(checkIn, checkOut),
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String dayStatus(checkIn, checkOut) {
    // CHECK IN
    DateTime parsedCheckInTime = DateFormat('hh:mm a').parse(checkIn);
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

    // CHECK OUT
    DateTime checkOutDateTime;
    DateTime earlyGoingDateTime;
    if (checkOut != "--/--") {
      DateTime parsedCheckOutTime = DateFormat('hh:mm a').parse(checkOut);
      TimeOfDay checkOutTimeOfDay = TimeOfDay.fromDateTime(parsedCheckOutTime);
      TimeOfDay earlyGoingTime = TimeOfDay(hour: 19, minute: 30);
      checkOutDateTime = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, checkOutTimeOfDay.hour, checkOutTimeOfDay.minute);
      earlyGoingDateTime = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, earlyGoingTime.hour, earlyGoingTime.minute);
    } else {
      return "";
    }

    if (checkIn == "--/--" || checkOut == "--/--") {
      return "";
    } else {
      if (checkInDateTime.isAfter(lateComingDateTime) &&
          checkOutDateTime.isBefore(earlyGoingDateTime)) {
        return "L/E";
      } else if (checkInDateTime.isAfter(lateComingDateTime)) {
        return "L";
      } else if (checkOutDateTime.isBefore(earlyGoingDateTime)) {
        return "E";
      } else {
        return "P";
      }
    }
  }

  Color dayStatusColor(checkIn, checkOut) {
    // CHECK IN
    DateTime parsedCheckInTime = DateFormat('hh:mm a').parse(checkIn);
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

    // CHECK OUT
    DateTime checkOutDateTime;
    DateTime earlyGoingDateTime;
    if (checkOut != "--/--") {
      DateTime parsedCheckOutTime = DateFormat('hh:mm a').parse(checkOut);
      TimeOfDay checkOutTimeOfDay = TimeOfDay.fromDateTime(parsedCheckOutTime);
      TimeOfDay earlyGoingTime = TimeOfDay(hour: 19, minute: 30);
      checkOutDateTime = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, checkOutTimeOfDay.hour, checkOutTimeOfDay.minute);
      earlyGoingDateTime = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, earlyGoingTime.hour, earlyGoingTime.minute);
    } else {
      return ConstColor.white;
    }

    if (checkIn == "--/--" && checkOut == "--/--") {
      return ConstColor.white;
    } else {
      if (checkInDateTime.isAfter(lateComingDateTime) &&
          checkOutDateTime.isBefore(earlyGoingDateTime)) {
        return ConstColor.primary;
      } else if (checkIn != "--/--" && checkOut == "--/--") {
        return ConstColor.red;
      } else if (checkInDateTime.isAfter(lateComingDateTime)) {
        return ConstColor.red;
      } else if (checkOutDateTime.isBefore(earlyGoingDateTime)) {
        return ConstColor.red;
      } else {
        return ConstColor.lightGreen;
      }
    }
  }
}
