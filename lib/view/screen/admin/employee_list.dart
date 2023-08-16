import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/employee_list_controller.dart';
import '../../../modal/const/const_color.dart';
import '../../../modal/const/const_image.dart';
import '../../../modal/const/text_style.dart';
import '../../../modal/custom/admin_app_bar.dart';
import 'create_employee_screen.dart';
import 'employee_attendance_screen.dart';
import 'employee_detail_screen.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  final EmployeeController employeeController = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            height: double.infinity,
            width: double.infinity,
            color: ConstColor.primaryBackGround,
            child: Column(
              children: [
                SizedBox(
                  height:
                      MediaQuery.of(context).padding.top + size.height * 0.02,
                ),
                CustomAdminAppBar(
                  onTap: () {
                    log("NOTIFICATION BUTTON TAPPED....!");
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => CreateEmployee()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: size.width * 0.45,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: ConstColor.primary,
                              size: 25,
                            ),
                            Text(" Add Employee",style: textStyleW500(size.width * 0.04, ConstColor.primary),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Obx(() {
                  if (employeeController.employees.isEmpty) {
                    return Center(
                      child: Text('No employees found.'),
                    );
                  }

                  return Expanded(
                    child: Container(
                      height: 500,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: employeeController.employees.length,
                        itemBuilder: (context, index) {
                          var employee = employeeController.employees[index];
                          return Container(
                            width: size.width,
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: ConstColor.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => EmployeeDetailScreen(
                                            profile: employee['profile'] ?? "",
                                            name: employee['name'] ?? "",
                                            designation:
                                                employee['designation'] ?? "",
                                            employeeID: employee['id'] ?? "",
                                            emailID: employee['mail'] ?? "",
                                            mobileNo: employee['mobile'] ?? "",
                                            birthDate: employee['birthdate'] ?? "",
                                            bloodGroup: employee['bloodgroup'] ?? "",
                                            aadhaarNo: employee['aadhaar'] ?? "",
                                            panNo: employee['pan'] ?? "",
                                            address: employee['address'] ?? "",
                                            emergency: employee['emergency'] ?? "",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          // backgroundColor: Colors.transparent,
                                          radius: size.width * 0.085,
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(4.0),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: ConstColor.primary,
                                                    width: 1.5)),
                                            child: ClipOval(
                                              child:
                                                  (employee['profile'] == " ")
                                                      ? Image.asset(
                                                          ConstImage.rutvik)
                                                      : Image.network(
                                                          employee['profile'] ??
                                                              ''),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: size.width * 0.37,
                                              child: Text(
                                                employee['name'],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: textStyleW600(
                                                    size.width * 0.042,
                                                    ConstColor.blackText),
                                              ),
                                            ),
                                            Text(
                                              employee['designation'],
                                              style: textStyleW500(
                                                  size.width * 0.035,
                                                  ConstColor.blackText
                                                      .withOpacity(0.7)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 50,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    QuerySnapshot snap = await FirebaseFirestore
                                        .instance
                                        .collection("Employee")
                                        .where('id', isEqualTo: employee['id'])
                                        .get();
                                    var userID;

                                    setState(() {
                                      userID = snap.docs[0].id;
                                    });

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                EmployeeAttendanceScreen(
                                                  userID: userID,
                                                )));
                                  },
                                  child: GestureDetector(
                                    child: Text(
                                      'View',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
