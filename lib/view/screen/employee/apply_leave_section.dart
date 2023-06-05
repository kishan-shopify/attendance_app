import 'package:attendance_app/modal/const/list.dart';
import 'package:attendance_app/modal/custom/custom_leave_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_switcher/slide_switcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../modal/custom/gradient_button.dart';
import '../../../modal/const/const_color.dart';
import '../../../modal/const/const_image.dart';
import '../../../modal/const/text_style.dart';
import '../../../modal/custom/back_button.dart';
import '../../../modal/custom/leave_page_label.dart';
import '../../../modal/modal_class/leave_class.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({Key? key}) : super(key: key);

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  static const List<String> leaveReason = <String>[
    'Casual Leave',
    'Medical Leave',
    'Function Leave',
    'Trip Leave',
    'Other'
  ];
  String dropdownValue = leaveReason.first;
  int switcherIndex = 0;

  final TextEditingController reason = TextEditingController();

  String startDate = "";
  String endDate = "";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          RotatedBox(
            quarterTurns: 2,
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                ConstImage.background,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top - 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // AnimatedTextKit(
                    //   animatedTexts: [
                    //     ColorizeAnimatedText(
                    //       "Janovis",
                    //       textAlign: TextAlign.center,
                    //       textStyle: TextStyle(
                    //         fontSize: size.width * 0.06,
                    //         fontWeight: FontWeight.w700,
                    //       ),
                    //       colors: [
                    //         ConstColor.primaryGradient2,
                    //         ConstColor.primaryGradient1,
                    //       ],
                    //     ),
                    //   ],
                    //   totalRepeatCount: 1,
                    //   pause: const Duration(milliseconds: 500),
                    //   displayFullTextOnTap: true,
                    // ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: size.height * 0.06,
                      width: size.width * 0.6,
                      child: Image.asset(
                        "assets/images/janovis_logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),

                    Container(
                      height: size.height * 0.12,
                      width: size.width * 0.12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            blurRadius: 4,
                            offset: const Offset(2, 4), // Shadow position
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: ConstColor.primaryGradient2,
                        radius: size.width * 0.12,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/rutvik.jpg",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.0008,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Leaves",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: ConstColor.blackText,
                          fontSize: size.width * 0.07)),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    color: ConstColor.white.withOpacity(0.85),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      GradientButton(
                        btnLabel: "APPLY LEAVE",
                        onTap: () {},
                        labelColor: ConstColor.white,
                        gradientColor: [
                          ConstColor.primaryGradient2,
                          ConstColor.primaryGradient1,
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      SlideSwitcher(
                        containerBorder:
                            Border.all(color: ConstColor.blackText),
                        onSelect: (int index) =>
                            setState(() => switcherIndex = index),
                        containerHeight: 40,
                        containerWight: 300,
                        containerColor: ConstColor.white,
                        slidersGradients: [
                          LinearGradient(
                            colors: [
                              ConstColor.primaryGradient1,
                              ConstColor.primaryGradient2,
                            ],
                          ),
                        ],
                        children: [
                          Text(
                            'Pending',
                            style: TextStyle(
                                fontWeight: switcherIndex == 0
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: switcherIndex == 0
                                    ? ConstColor.white.withOpacity(0.9)
                                    : ConstColor.blackText),
                          ),
                          Text(
                            'Approved',
                            style: TextStyle(
                                fontWeight: switcherIndex == 1
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: switcherIndex == 1
                                    ? ConstColor.white.withOpacity(0.9)
                                    : ConstColor.blackText),
                          ),
                          Text(
                            'Rejected',
                            style: TextStyle(
                                fontWeight: switcherIndex == 2
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: switcherIndex == 2
                                    ? ConstColor.white.withOpacity(0.9)
                                    : ConstColor.blackText),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          children: [
                            const LeavePageLabel(
                              isWidth50: true,
                              label: "Type",
                            ),
                            Expanded(child: Container()),
                            const LeavePageLabel(
                              label: "From",
                            ),
                            Expanded(child: Container()),
                            const LeavePageLabel(
                              label: "To",
                            ),
                            Container(
                              height: 25,
                              width: 15,
                              decoration: BoxDecoration(
                                  border: Border.all(color: ConstColor.white)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          height: size.height,
                          width: size.width,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: dummyLeaveList.length,
                            itemBuilder: (BuildContext context, int index) {
                              LeaveClass leave = dummyLeaveList[index];
                              return  LeaveView(
                                leaveType: leave.leaveType,
                                fromDate: leave.fromDate,
                                toDate: leave.toDate,
                                reason: "ABCD",
                              );
                            },
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
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
              primary: ConstColor.primaryGradient1,
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
    final String encodedStartDate = Uri.encodeQueryComponent(startDate);
    final String encodedEndDate = Uri.encodeQueryComponent(endDate);
    final String encodedReason = Uri.encodeQueryComponent(reason.text);

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'rutvik.janovis@gmail.com',
      queryParameters: {
        'subject': 'Leave Application',
        'body':
            'From: $encodedStartDate\nTo: $encodedEndDate\nReason: $encodedReason'
      },
    );

    // Manually replace spaces with %20 in the email body
    final String emailBody = emailLaunchUri.toString().replaceAll('+', ' ');

    try {
      await launch(emailBody);
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to launch email client.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
