import 'dart:developer';

import 'package:attendance_app/modal/custom/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controller/home_screen_controller.dart';
import '../../../modal/const/const_color.dart';
import '../../../modal/const/text_style.dart';
import '../../../modal/custom/app_bar.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({Key? key}) : super(key: key);

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  final HomeScreenController homeController = Get.put(HomeScreenController());
  final TextEditingController reason = TextEditingController();

  String startDate = "";
  String endDate = "";

  static const List<String> leaveReason = <String>[
    'Casual Leave',
    'Medical Leave',
    'Function Leave',
    'Trip Leave',
    'Other'
  ];
  String dropdownValue = leaveReason.first;

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
                        startDate.isEmpty ? "Select Date" : startDate,
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
                        endDate.isEmpty ? "Select Date" : endDate,
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
                child: DropdownButton<String>(
                  value: dropdownValue,
                  hint: const Text("Select Reason"),
                  isExpanded: true,
                  elevation: 16,
                  style: textStyleW500(size.width * 0.04, ConstColor.blackText),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items:
                      leaveReason.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
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
                controller: reason,
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
                sendEmail();
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
          startDate = formattedDate;
        } else if (selectedDateType == "end") {
          endDate = formattedDate;
        }
      });
    }
  }

  void sendEmail() async {
    final encodedStartDate = Uri.encodeFull(startDate);
    final encodedEndDate = Uri.encodeFull(endDate);
    // final encodedLeaveType = Uri.encodeComponent();
    String leaveReasonString = reason.text;
    final encodedReason = Uri.encodeFull(leaveReasonString);

    final Uri email = Uri(
        scheme: 'mailto',
        path: 'rutvik.janovis@gmail.com',
        queryParameters: {
          'body':
              'From: $encodedStartDate\nTo: $encodedEndDate\nReason: $encodedReason'
        }

        );

   try {
      await launchUrl(email);
    } catch(e) {
      log("Error");
    }
  }
}
