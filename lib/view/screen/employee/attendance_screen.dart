import 'dart:developer';

import 'package:attendance_app/modal/modal_class/user.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/home_screen_controller.dart';
import '../../../modal/const/const_image.dart';
import '../../../modal/const/text_style.dart';
import '../../../modal/custom/custom_button.dart';
import '../../../modal/const/const_color.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final HomeScreenController homeController = Get.put(HomeScreenController());
  final TextEditingController punchIn = TextEditingController();
  final TextEditingController punchOut = TextEditingController();
  final TextEditingController reason = TextEditingController();
  FocusNode punchInFocus = FocusNode();
  FocusNode punchOutFocus = FocusNode();


  var month;
  DateTime currentDate = DateTime.now();

  void updateMonth(int offset) {
    currentDate = DateTime(currentDate.year, currentDate.month + offset);
    setState(() {});
    month = DateFormat('MMMM').format(currentDate);
    homeController.fetchPresentDays(User.id, month);
  }

  @override
  void initState() {
    updateMonth(0);
    punchInFocus.addListener(onFocusChange);
    punchOutFocus.addListener(onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    punchOutFocus.removeListener(onFocusChange);
    punchInFocus.removeListener(onFocusChange);
    punchOutFocus.dispose();
    punchInFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Attendance",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: ConstColor.blackText,
                fontSize: size.width * 0.07,
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
            Text(DateFormat('MMMM').format(currentDate),
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
                homeController.fetchPresentDays(User.id, month);
              },
              child: Obx(() {
                if (homeController.presentDays.isEmpty) {
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
                    itemCount: homeController.presentDays.length,
                    itemBuilder: (context, index) {
                      final doc = homeController.presentDays[index];
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
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: ConstColor.primaryBackGround),
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
                            GestureDetector(
                              onTap: () {
                                if (index != 0) {
                                  log("INDEX  ===  $index");
                                  punchIn.text = checkIn;
                                  punchOut.text = checkOut;
                                  editDialogBox(size, date);
                                }
                              },
                              child: Container(
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

  editDialogBox(size, date) {
    var punchInEdit = true;
    var punchOutEdit = true;
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 25),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('dd MMMM yyyy').format(date),
              style: textStyleW600(
                size.width * 0.04,
                ConstColor.blackText,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Container(
            height: size.height / 3.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Punch In :",
                  style: TextStyle(
                    fontSize: size.width * 0.041,
                    color: ConstColor.blackText.withOpacity(0.9),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: ConstColor.blackText),
                  )),
                  height: 25,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          cursorColor: ConstColor.blackText,
                          controller: punchIn,
                          focusNode: punchInFocus,
                          onTap: onFocusChange,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          readOnly: punchInEdit,
                          onEditingComplete: closeKeyboard,
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.w600,
                            color: ConstColor.blackText.withOpacity(0.6),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            punchInEdit = false;
                          });
                          if (!punchInEdit) {
                            punchInFocus.requestFocus();
                          }
                        },
                        child: Image.asset(
                          ConstImage.edit,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Punch Out :",
                  style: TextStyle(
                    fontSize: size.width * 0.041,
                    color: ConstColor.blackText.withOpacity(0.9),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: ConstColor.blackText),
                  )),
                  height: 25,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          cursorColor: ConstColor.blackText,
                          controller: punchOut,
                          focusNode: punchOutFocus,
                          onTap: onFocusChange,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          readOnly: punchOutEdit,
                          onEditingComplete: closeKeyboard,
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.w600,
                            color: ConstColor.blackText.withOpacity(0.6),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            punchOutEdit = false;
                          });

                          if (!punchOutEdit) {
                            punchOutFocus.requestFocus();
                          }
                        },
                        child: Image.asset(
                          ConstImage.edit,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Remark :",
                  style: TextStyle(
                    fontSize: size.width * 0.041,
                    color: ConstColor.blackText.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  height: 55,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: ConstColor.blackText),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: TextField(
                    controller: reason,
                    cursorColor: ConstColor.blackText,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter reason..."
                    ),
                  ),

                ),
              ],
            ),
          ),
        ),
        actions: [
          CustomButton(
              btnLabel: "Submit Request",
              onTap: () {
                if(reason.text.isEmpty){
                  Get.snackbar("Error", "Please Enter Reason..!",
                      colorText: ConstColor.white,
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      backgroundColor: ConstColor.red.withOpacity(0.8),
                      icon: Icon(
                        Icons.error_outline,
                        color: ConstColor.white,
                        size: 30,
                      ));
                }else{
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: "Request send successfully...!",
                      //message to show toast
                      toastLength: Toast.LENGTH_LONG,
                      //duration for message to show
                      gravity: ToastGravity.CENTER,
                      //where you want to show, top, bottom
                      timeInSecForIosWeb: 1,
                      //for iOS only
                      //backgroundColor: Colors.red, //background Color for message
                      textColor: ConstColor.blackText,
                      //message text color
                      fontSize: 16.0 //message font size
                  );
                }
              },
              btnColor: ConstColor.primary,
              labelColor: ConstColor.white),
        ],
      ),
    );
  }

  void onFocusChange() {
    if (punchInFocus.hasFocus || punchOutFocus.hasFocus) {
      // Open the keyboard
      // FocusScope.of(context).requestFocus(punchInFocus);
      SystemChannels.textInput.invokeMethod('TextInput.show');
    }
  }

  void closeKeyboard() {
    punchInFocus.unfocus();
    punchOutFocus.unfocus();
  }
}
