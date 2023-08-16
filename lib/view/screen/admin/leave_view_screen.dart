import 'package:attendance_app/modal/custom/progress_indicator.dart';
import 'package:attendance_app/view/screen/admin/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/employee_list_controller.dart';
import '../../../modal/const/const_color.dart';
import '../../../modal/const/text_style.dart';
import '../../../modal/custom/admin_app_bar.dart';
import '../../../modal/custom/custom_button.dart';

class LeaveViewScreen extends StatefulWidget {
  final String fromDate;
  final String userId;
  final String toDate;
  final String leaveType;
  final String reason;
  final String remark;
  final String status;

  const LeaveViewScreen({
    super.key,
    required this.fromDate,
    required this.toDate,
    required this.leaveType,
    required this.reason,
    required this.remark,
    required this.status,
    required this.userId,
  });

  @override
  State<LeaveViewScreen> createState() => _LeaveViewScreenState();
}

class _LeaveViewScreenState extends State<LeaveViewScreen> {
  final EmployeeController controller = Get.put(EmployeeController());

  static const List<String> leaveReason = <String>[
    'Pending',
    'Approved',
    'Rejected',
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        height: double.infinity,
        width: double.infinity,
        color: ConstColor.primaryBackGround,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    "Leave Request",
                    style: textStyleW700(
                      size.width * 0.07,
                      ConstColor.blackText,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
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
                        widget.fromDate,
                        style: textStyleW500(
                            size.width * 0.04, ConstColor.blackText),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      alignment: Alignment.centerLeft,
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        color: ConstColor.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        widget.toDate,
                        style: textStyleW500(
                            size.width * 0.04, ConstColor.blackText),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.030,
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
                padding: const EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.centerLeft,
                height: size.height * 0.06,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ConstColor.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  widget.leaveType,
                  style: textStyleW500(size.width * 0.04, ConstColor.blackText),
                ),
              ),
              SizedBox(
                height: size.height * 0.030,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                height: size.height * 0.1,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ConstColor.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(widget.reason),
              ),
              SizedBox(
                height: size.height * 0.030,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Status",
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
                        value: controller.selectedDropdownValue.value,
                        hint: const Text("Select Leave Type"),
                        isExpanded: true,
                        elevation: 16,
                        style: textStyleW500(
                            size.width * 0.04, ConstColor.blackText),
                        onChanged: (String? value) {
                          if (value != null) {
                            controller.updateSelectedDropdownValue(value);
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
                height: size.height * 0.030,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Remark",
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
                height: size.height * 0.10,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ConstColor.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: controller.remark.value,
                  cursorColor: ConstColor.blackText,
                  maxLines: null,
                  readOnly: (widget.status == "Approved" ||
                          widget.status == "Rejected")
                      ? true
                      : false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.remark,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.030,
              ),
              CustomButton(
                btnLabel: "Done",
                onTap: () async {
                  if (controller.remark.value.text.isEmpty) {
                    Get.snackbar("Error", "Please Enter a Remark...",
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
                    if (widget.status == "Approved" ||
                        widget.status == "Rejected") {
                      Get.snackbar("Error", "Can't Update Status",
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
                      ProgressDialog().show(context);

                      await FirebaseFirestore.instance
                          .collection("Employee")
                          .doc(widget.userId)
                          .collection("Leaves")
                          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now())).update({
                        "date": Timestamp.now(),
                        "updatedDate": Timestamp.now(),
                        "status": controller.selectedDropdownValue.value,
                        "startDate": widget.fromDate,
                        "endDate": widget.toDate,
                        "remark": controller.remark.value.text,
                        "leaveType": widget.leaveType,
                        "reason": widget.reason,
                      });
                      ProgressDialog().hide(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => AdminHomeScreen()));
                    }
                  }
                },
                btnColor: ConstColor.primary,
                labelColor: ConstColor.white,
              ),
              SizedBox(
                height: size.height * 0.030,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
