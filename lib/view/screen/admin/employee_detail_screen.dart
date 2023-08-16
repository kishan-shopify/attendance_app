import 'package:attendance_app/modal/custom/admin_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../modal/const/const_color.dart';
import '../../../modal/const/const_image.dart';
import '../../../modal/const/text_style.dart';
import '../../../modal/custom/employee_view.dart';
import '../../../modal/modal_class/user.dart';

class EmployeeDetailScreen extends StatefulWidget {
  final String profile;
  final String name;
  final String designation;
  final String employeeID;
  final String emailID;
  final String mobileNo;
  final String birthDate;
  final String bloodGroup;
  final String aadhaarNo;
  final String panNo;
  final String address;
  final String emergency;

  const EmployeeDetailScreen({
    super.key,
    required this.profile,
    required this.name,
    required this.designation,
    required this.employeeID,
    required this.emailID,
    required this.mobileNo,
    required this.birthDate,
    required this.bloodGroup,
    required this.aadhaarNo,
    required this.panNo,
    required this.address,
    required this.emergency,
  });

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
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
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: ConstColor.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        // backgroundColor: Colors.transparent,
                        radius: size.width * 0.18,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: ConstColor.primary, width: 1.5)),
                          child: ClipOval(
                            child: (widget.profile == " ")
                                ? Image.asset(
                                    ConstImage.rutvik,
                                  )
                                : Image.network(widget.profile),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: size.width * 0.055,
                            color: ConstColor.blackText,
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        widget.designation,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            // size.width * 0.042,
                            fontWeight: FontWeight.w600,
                            color: ConstColor.blackText.withOpacity(0.6)),
                      ),
                      Text(
                        "Joined from ${User.joiningDate}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: ConstColor.blackText.withOpacity(0.6)),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      EmployeeView(
                        label: 'Employee ID:',
                        value: widget.employeeID,
                      ),
                      EmployeeView(
                        label: 'Email ID:',
                        value: widget.emailID,
                      ),
                      EmployeeView(
                        label: 'Mobile No:',
                        value: widget.mobileNo,
                      ),
                      EmployeeView(
                        label: 'Birth Date:',
                        value: widget.birthDate,
                      ),
                      EmployeeView(
                        label: 'Blood Group:',
                        value: widget.bloodGroup,
                      ),
                      EmployeeView(
                        label: 'Aadhaar No:',
                        value: widget.aadhaarNo,
                      ),
                      EmployeeView(
                        label: 'Pan No:',
                        value: widget.panNo,
                      ),
                      EmployeeView(
                        label: 'Address:',
                        value: widget.address,
                      ),
                      EmployeeView(
                        label: 'Emergency:',
                        value: widget.emergency,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
