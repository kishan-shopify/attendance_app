import 'dart:developer';

import 'package:attendance_app/controller/employee_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../modal/const/const_color.dart';
import '../../../modal/const/text_style.dart';
import '../../../modal/custom/admin_app_bar.dart';

class EmployeeTimeChangeRequest extends StatefulWidget {
  const EmployeeTimeChangeRequest({super.key});

  @override
  State<EmployeeTimeChangeRequest> createState() =>
      _EmployeeTimeChangeRequestState();
}

class _EmployeeTimeChangeRequestState extends State<EmployeeTimeChangeRequest> {
  final EmployeeController controller = Get.put(EmployeeController());

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
              height: size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Time Change Request",
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
            Expanded(
              child: Container(
                height: size.height / 1.5,
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: controller.getTimeRequest(),
                  builder: (context, snapShot) {
                    if (snapShot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: ConstColor.primary,
                      ));
                    }

                    if (snapShot.hasError) {
                      return Text('Error: ${snapShot.error}');
                    }

                    if (!snapShot.hasData || snapShot.data!.isEmpty) {
                      return Text('No Requests found.');
                    }

                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: snapShot.data!.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> requestData =
                              snapShot.data![index];
                          final appliedDate = requestData['date'].toDate();
                          final whichDate = requestData['whichDate'];
                          final punchIn = requestData['punchIn'];
                          final punchOut = requestData['punchOut'];
                          final remark = requestData['remark'];
                          final user = requestData['employeeId'];
                          final employeeName = requestData['employeeName'];
                          final status = requestData['status'];
                          final reason = requestData['reason'];
                          String formattedAppliedDate = DateFormat('dd-MM-yyyy').format(appliedDate);

                          return GestureDetector(
                            onTap: () {
                              log("Pressed..");
                            },
                            child: Container(
                              width: size.width,
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: ConstColor.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Name : ",
                                            style: textStyleW600(
                                                size.width * 0.04,
                                                ConstColor.blackText
                                                    .withOpacity(0.7)),
                                          ),
                                          Text(
                                            "$employeeName",
                                            style: textStyleW600(
                                                size.width * 0.04,
                                                ConstColor.blackText),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "◉ $status",
                                        style: textStyleW600(
                                            size.width * 0.04,
                                            (status == "Pending")
                                                ? ConstColor.primary
                                                : (status == "Rejected")
                                                    ? ConstColor.red
                                                    : ConstColor.lightGreen),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Date : ",
                                        style: textStyleW600(
                                            size.width * 0.04,
                                            ConstColor.blackText
                                                .withOpacity(0.7)),
                                      ),
                                      Text(
                                        "$whichDate",
                                        style: textStyleW600(size.width * 0.04,
                                            ConstColor.blackText),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Punch Out : ",
                                        style: textStyleW600(
                                            size.width * 0.04,
                                            ConstColor.blackText
                                                .withOpacity(0.7)),
                                      ),
                                      Text(
                                        "$punchIn",
                                        style: textStyleW600(size.width * 0.04,
                                            ConstColor.blackText),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Punch Out : ",
                                        style: textStyleW600(
                                            size.width * 0.04,
                                            ConstColor.blackText
                                                .withOpacity(0.7)),
                                      ),
                                      Text(
                                        "$punchOut",
                                        style: textStyleW600(size.width * 0.04,
                                            ConstColor.blackText),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Applied On : ",
                                        style: textStyleW600(
                                            size.width * 0.04,
                                            ConstColor.blackText
                                                .withOpacity(0.7)),
                                      ),
                                      Text(
                                        "$formattedAppliedDate",
                                        style: textStyleW600(size.width * 0.04,
                                            ConstColor.blackText),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
