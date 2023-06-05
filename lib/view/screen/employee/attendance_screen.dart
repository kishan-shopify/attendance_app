import 'dart:developer';

import 'package:attendance_app/modal/const/const_color.dart';
import 'package:attendance_app/modal/const/text_style.dart';
import 'package:attendance_app/modal/custom/show_clock_in_out.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../modal/const/const_image.dart';
import '../../../modal/modal_class/user.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final String _month = DateFormat('MMMM').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
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
                Text("Attendance",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: ConstColor.blackText,
                        fontSize: size.width * 0.07)),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Expanded  (
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),),
                  color: ConstColor.white.withOpacity(0.85),
                ),

                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 75,
                            alignment: Alignment.center,
                            child: Text(
                              "Date",
                              style: textStyleW600(
                                  size.width * 0.048, ConstColor.blackText),
                            ),
                          ),
                          Expanded(child: Container(),),
                          Container(
                            width: 100,
                            alignment: Alignment.center,

                            child: Text(
                              "Check In",
                              style: textStyleW600(
                                  size.width * 0.048, ConstColor.blackText),
                            ),
                          ),
                          Expanded(child: Container(),),
                          Container(
                            width: 100,
                            alignment: Alignment.center,

                            child: Text(
                              "Check Out",
                              style: textStyleW600(
                                  size.width * 0.048, ConstColor.blackText),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SizedBox(
                        height: size.height,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("Employee")
                              .doc(User.id)
                              .collection("Record")
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              final snap = snapshot.data!.docs;
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: snap.length,
                                itemBuilder: (context, index) {
                                  return DateFormat('MMMM').format(
                                              snap[index]['date'].toDate()) ==
                                          _month
                                      ? Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                            children: [
                                              Container(
                                                width: 75,
                                                alignment: Alignment.center,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      DateFormat('dd').format(
                                                          snap[index]['date']
                                                              .toDate()),
                                                      style: TextStyle(
                                                        fontSize: size.width * 0.05,
                                                        color: ConstColor.blackText,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                    Text(
                                                      DateFormat('EE').format(
                                                          snap[index]['date']
                                                              .toDate()),
                                                      style: TextStyle(
                                                        fontSize: size.width * 0.04,
                                                        color: ConstColor.blackText,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(child: Container(),),
                                              ShowClockInOut(
                                                checkTime: snap[index]['checkIn'],
                                  textColor: ConstColor.blackText,
                                                // textColor: (int.parse(snap[index]['checkIn'].split(':')[0]) < 9 || (int.parse(snap[index]['checkIn'].split(':')[0]) == 9 && int.parse(snap[index]['checkIn'].split(':')[1]) <= 30)) ? ConstColor.lightGreen : ConstColor.red,
                                              ),
                                              Expanded(child: Container(),),
                                              ShowClockInOut(
                                                checkTime: snap[index]['checkOut'],
                                                textColor: ConstColor.blackText,
                                              ),
                                            ],
                                          ),
                                      )
                                      : const SizedBox();
                                },
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
