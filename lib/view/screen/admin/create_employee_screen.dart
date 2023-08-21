import 'package:attendance_app/controller/create_employee_controller.dart';
import 'package:attendance_app/modal/custom/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../modal/const/const_color.dart';
import '../../../modal/const/text_style.dart';
import '../../../modal/custom/add_employee_field.dart';
import '../../../modal/custom/admin_app_bar.dart';

class CreateEmployee extends StatefulWidget {
  const CreateEmployee({super.key});

  @override
  State<CreateEmployee> createState() => _CreateEmployeeState();
}

class _CreateEmployeeState extends State<CreateEmployee> {
  final CreateEmployeeController controller =
      Get.put(CreateEmployeeController());

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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add a Employee",
                        style: textStyleW700(
                          size.width * 0.065,
                          ConstColor.blackText,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  AddEmployeeField(
                    label: 'Employee ID:',
                    controller: controller.employeeID.value,
                    isCapital: true,
                    maxLength: 6,
                    keyboard: TextInputType.name,
                    textInputType: const [],
                  ),
                  AddEmployeeField(
                    label: 'Name:',
                    controller: controller.name.value,
                    maxLength: 25,
                    keyboard: TextInputType.name,
                    textInputType: const [],
                  ),
                  AddEmployeeField(
                    label: 'Designation:',
                    controller: controller.designation.value,
                    maxLength: 25,
                    keyboard: TextInputType.name,
                    textInputType: const [],
                  ),
                  AddEmployeeField(
                    label: 'Joining Date:',
                    readOnly: true,
                    onTap: (){
                      joiningDatePick(context, controller.joiningDate.value.text);
                    },
                    controller: controller.joiningDate.value,
                    maxLength: 20,
                    keyboard: TextInputType.name,
                    textInputType: const [],
                  ),
                  AddEmployeeField(
                    label: 'Email ID:',
                    controller: controller.emailID.value,
                    maxLength: 20,
                    keyboard: TextInputType.emailAddress,
                    textInputType: const [],
                  ),
                  AddEmployeeField(
                    label: 'Mobile No:',
                    controller: controller.mobileNo.value,
                    maxLength: 10,
                    keyboard: TextInputType.number,
                    textInputType: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  AddEmployeeField(
                    label: 'Birth Date:',
                    readOnly: true,
                    onTap: (){
                      birthDatePick(context, controller.birthDate.value.text);
                    },
                    controller: controller.birthDate.value,
                    maxLength: 15,
                    keyboard: TextInputType.name,
                    textInputType: const [],
                  ),
                  AddEmployeeField(
                    label: 'Blood Group:',
                    controller: controller.bloodGroup.value,
                    maxLength: 20,
                    keyboard: TextInputType.name,
                    textInputType: const [],
                  ),
                  AddEmployeeField(
                    label: 'Aadhaar No:',
                    controller: controller.aadhaarNo.value,
                    maxLength: 16,
                    keyboard: TextInputType.number,
                    textInputType: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  AddEmployeeField(
                    label: 'Pan No:',
                    controller: controller.panNo.value,
                    maxLength: 10,
                    isCapital: true,
                    keyboard: TextInputType.name,
                    textInputType: const [],
                  ),
                  AddEmployeeField(
                    label: 'Address:',
                    controller: controller.address.value,
                    maxLength: 25,
                    keyboard: TextInputType.name,
                    textInputType: const [],
                  ),
                  AddEmployeeField(
                    label: 'Emergency:',
                    controller: controller.emergency.value,
                    maxLength: 10,
                    keyboard: TextInputType.number,
                    textInputType: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  AddEmployeeField(
                    label: 'Password:',
                    controller: controller.password.value,
                    maxLength: 25,
                    keyboard: TextInputType.name,
                    textInputType: const [],
                  ),
                  CustomButton(
                    btnLabel: "Create",
                    onTap: () {
                      controller.createEmployee(context);
                    },
                    btnColor: ConstColor.primary,
                    labelColor: ConstColor.white,
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void joiningDatePick(BuildContext context, String selectedDateType) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
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
      controller.joiningDate.value.text = formattedDate;
    }
  }


  void birthDatePick(BuildContext context, String selectedDateType) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
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
      controller.birthDate.value.text = formattedDate;
    }
  }

}
