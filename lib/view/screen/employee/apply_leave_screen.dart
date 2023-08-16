import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/home_screen_controller.dart';
import '../../../controller/leave_controller.dart';
import '../../../modal/const/const_color.dart';
import '../../../modal/const/text_style.dart';
import '../../../modal/custom/app_bar.dart';
import '../../../modal/custom/custom_button.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({Key? key}) : super(key: key);

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  final HomeScreenController homeController = Get.put(HomeScreenController());
  final LeaveController leaveController = Get.put(LeaveController());
  static const List<String> leaveReason = <String>[
    'Casual Leave',
    'Medical Leave',
    'Function Leave',
    'Trip Leave',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            CustomAppBar(
              onTap: () {
                homeController.notificationVisible.value =
                    !homeController.notificationVisible.value;
              },
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Apply Leave",
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "From",
                      style: textStyleW600(
                        size.width * 0.045,
                        ConstColor.blackText,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "To",
                      style: textStyleW600(
                        size.width * 0.045,
                        ConstColor.blackText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.006,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      datePick(context, "start");
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      alignment: Alignment.centerLeft,
                      height: size.height * 0.06,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ConstColor.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        leaveController.startDate.value.isEmpty
                            ? "Select Date"
                            : leaveController.startDate.value,
                        style: textStyleW500(
                            size.width * 0.04, ConstColor.blackText),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      datePick(context, "end");
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      alignment: Alignment.centerLeft,
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        color: ConstColor.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        leaveController.endDate.value.isEmpty
                            ? "Select Date"
                            : leaveController.endDate.value,
                        style: textStyleW500(
                            size.width * 0.04, ConstColor.blackText),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.045,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Leave Type",
                  style: textStyleW600(
                    size.width * 0.045,
                    ConstColor.blackText,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.006,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: size.height * 0.06,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ConstColor.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: DropdownButtonHideUnderline(
                child: Obx(() => DropdownButton<String>(
                      value: leaveController.selectedDropdownValue.value,
                      hint: const Text("Select Leave Type"),
                      isExpanded: true,
                      elevation: 16,
                      style: textStyleW500(
                          size.width * 0.04, ConstColor.blackText),
                      onChanged: (String? value) {
                        if (value != null) {
                          leaveController.updateSelectedDropdownValue(value);
                        }
                      },
                      items: leaveReason
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
              ),
            ),
            SizedBox(
              height: size.height * 0.045,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Reason",
                  style: textStyleW600(
                    size.width * 0.045,
                    ConstColor.blackText,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.006,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: size.height * 0.20,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ConstColor.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: leaveController.leaveReason.value,
                cursorColor: ConstColor.blackText,
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Mention a Reason Here...",
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.045,
            ),
            CustomButton(
              btnLabel: "Apply",
              onTap: () {
                if (leaveController.startDate.isEmpty ||
                    leaveController.endDate.isEmpty ||
                    leaveController.leaveReason.value.text.isEmpty) {
                  Get.snackbar("Error", "Please fill all details first..!",
                      colorText: ConstColor.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                      backgroundColor: ConstColor.red.withOpacity(0.8),
                      icon: Icon(
                        Icons.error_outline,
                        color: ConstColor.white,
                        size: 30,
                      ));
                } else {
                  DateTime startDate = DateFormat('dd-MM-yyyy')
                      .parse(leaveController.startDate.value);
                  DateTime endDate = DateFormat('dd-MM-yyyy')
                      .parse(leaveController.endDate.value);

                  if (endDate.isBefore(startDate)) {
                    Get.snackbar(
                        "Error", "End date cannot be before the start date..!",
                        colorText: ConstColor.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        backgroundColor: ConstColor.red.withOpacity(0.8),
                        icon: Icon(
                          Icons.error_outline,
                          color: ConstColor.white,
                          size: 30,
                        ));
                  } else {
                    leaveController.applyLeave(context);
                  }
                }
              },
              btnColor: ConstColor.primary,
              labelColor: ConstColor.white,
            ),
          ],
        ),
      ),
    );
  }

  void datePick(BuildContext context, String selectedDateType) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: ConstColor.primary,
            ),
          ),
          child: Container(child: child),
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      setState(() {
        if (selectedDateType == "start") {
          leaveController.startDate.value = formattedDate;
        } else if (selectedDateType == "end") {
          leaveController.endDate.value = formattedDate;
        }
      });
    }
  }
}
