// ignore_for_file: use_build_context_synchronously

import 'package:action_slider/action_slider.dart';
import 'package:attendance_app/modal/const/list.dart';
import 'package:attendance_app/modal/const/text_style.dart';
import 'package:attendance_app/modal/custom/custom_leave_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_action/slide_action.dart';
import 'package:slide_switcher/slide_switcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../modal/const/const_color.dart';
import '../../../modal/const/const_image.dart';
import '../../../modal/custom/leave_page_label.dart';
import '../../../modal/modal_class/leave_class.dart';
import 'apply_leave_screen.dart';

class LeaveSection extends StatefulWidget {
  const LeaveSection({Key? key}) : super(key: key);

  @override
  State<LeaveSection> createState() => _LeaveSectionState();
}

class _LeaveSectionState extends State<LeaveSection> {

  int switcherIndex = 0;



  bool stretchThumb = true;

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
                      SlideAction(
                        stretchThumb: stretchThumb,
                        trackBuilder: (context, state) {
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: ConstColor.blackText),
                              color: Colors.white,
                            ),
                            child: Text(
                              "APPLY LEAVE",
                              style: textStyleW600(
                                  size.width * 0.042, ConstColor.blackText),
                            ),
                          );
                        },
                        thumbBuilder: (context, state) {
                          return Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.topLeft,
                                    colors: [
                                      ConstColor.primaryGradient2,
                                      ConstColor.primaryGradient1,
                                    ])),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                width: stretchThumb ? 64 : double.infinity,
                                child: Image.asset(
                                  ConstImage.plane,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                        action: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const ApplyLeaveScreen()));
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: ConstColor.blackText),
                        ),
                        child: SlideSwitcher(
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
                              return LeaveView(
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
}
