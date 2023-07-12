import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modal/const/const_color.dart';
import '../modal/modal_class/user.dart';
import '../view/screen/employee/home_screen.dart';

class LoginController extends GetxController {
  Rx<TextEditingController> employeeID = TextEditingController().obs;
  Rx<TextEditingController> employeePassword = TextEditingController().obs;
  Rx<TextEditingController> adminID = TextEditingController().obs;
  Rx<TextEditingController> adminPassword = TextEditingController().obs;
  RxBool isAdminScreen = false.obs;
  late SharedPreferences sharedPreferences;

  employeeValidation(context) async {
    if (employeeID.value.text.isEmpty || employeePassword.value.text.isEmpty) {
      Get.snackbar("Error", "Please fill up required data..!",
          colorText: ConstColor.white,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          backgroundColor: ConstColor.red.withOpacity(0.8),
          icon: Icon(
            Icons.error_outline,
            color: ConstColor.white,
            size: 30,
          ));
    } else {
      if (employeeID.value.text.length < 6) {
        Get.snackbar("Error", "Please enter valid Employee ID..!",
            colorText: ConstColor.white,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            backgroundColor: ConstColor.red.withOpacity(0.8),
            icon: Icon(
              Icons.error_outline,
              color: ConstColor.white,
              size: 30,
            ));
      } else {
        String eID = employeeID.value.text.trim();
        String ePassword = employeePassword.value.text.trim();

        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection("Employee")
            .where("id", isEqualTo: eID)
            .get();

        try {
          if (ePassword == snapshot.docs[0]["password"]) {
            sharedPreferences = await SharedPreferences.getInstance();

            sharedPreferences.setString('employeeId', eID).then((_) {
              User.employeeId = sharedPreferences.getString('employeeId')!;
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const EmployeeHomeScreen()));
            });
            employeeID.value.clear();
            employeePassword.value.clear();
          } else {
            Get.snackbar("Error", "Wrong Password..!",
                colorText: ConstColor.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                backgroundColor: ConstColor.red.withOpacity(0.8),
                icon: Icon(
                  Icons.error_outline,
                  color: ConstColor.white,
                  size: 30,
                ));
          }
        } catch (e) {
          Get.snackbar("Error", e.toString(),
              colorText: ConstColor.white,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              backgroundColor: ConstColor.red.withOpacity(0.8),
              icon: Icon(
                Icons.error_outline,
                color: ConstColor.white,
                size: 30,
              ));
        }
      }
    }
  }

  adminValidation() {}
}
