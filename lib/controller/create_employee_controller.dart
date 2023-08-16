import 'dart:developer';

import 'package:attendance_app/modal/custom/progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modal/const/const_color.dart';
import '../view/screen/admin/home_screen.dart';

class CreateEmployeeController extends GetxController {
  Rx<TextEditingController> employeeID = TextEditingController().obs;
  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> designation = TextEditingController().obs;
  Rx<TextEditingController> joiningDate = TextEditingController().obs;
  Rx<TextEditingController> emailID = TextEditingController().obs;
  Rx<TextEditingController> mobileNo = TextEditingController().obs;
  Rx<TextEditingController> birthDate = TextEditingController().obs;
  Rx<TextEditingController> bloodGroup = TextEditingController().obs;
  Rx<TextEditingController> aadhaarNo = TextEditingController().obs;
  Rx<TextEditingController> panNo = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;
  Rx<TextEditingController> emergency = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;

  createEmployee(context) async {
    if (employeeID.value.text.isEmpty) {
      Get.snackbar("Error", "Please Enter Employee ID...",
          colorText: ConstColor.white,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          backgroundColor: ConstColor.red.withOpacity(0.8),
          icon: Icon(
            Icons.error_outline,
            color: ConstColor.white,
            size: 30,
          ));
    } else if (name.value.text.isEmpty) {
      Get.snackbar("Error", "Please Enter Name...",
          colorText: ConstColor.white,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          backgroundColor: ConstColor.red.withOpacity(0.8),
          icon: Icon(
            Icons.error_outline,
            color: ConstColor.white,
            size: 30,
          ));
    } else if (designation.value.text.isEmpty) {
      Get.snackbar("Error", "Please Enter Designation...",
          colorText: ConstColor.white,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          backgroundColor: ConstColor.red.withOpacity(0.8),
          icon: Icon(
            Icons.error_outline,
            color: ConstColor.white,
            size: 30,
          ));
    } else if (joiningDate.value.text.isEmpty) {
      Get.snackbar("Error", "Please Enter Joining Date...",
          colorText: ConstColor.white,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          backgroundColor: ConstColor.red.withOpacity(0.8),
          icon: Icon(
            Icons.error_outline,
            color: ConstColor.white,
            size: 30,
          ));
    } else if (emailID.value.text.isEmpty) {
      Get.snackbar("Error", "Please Enter Email ID...",
          colorText: ConstColor.white,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          backgroundColor: ConstColor.red.withOpacity(0.8),
          icon: Icon(
            Icons.error_outline,
            color: ConstColor.white,
            size: 30,
          ));
    } else if (password.value.text.isEmpty) {
      Get.snackbar("Error", "Please Enter Password...",
          colorText: ConstColor.white,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          backgroundColor: ConstColor.red.withOpacity(0.8),
          icon: Icon(
            Icons.error_outline,
            color: ConstColor.white,
            size: 30,
          ));
    } else {
      try {
        ProgressDialog().show(context);
        await FirebaseFirestore.instance.collection("Employee").add({
          "id": employeeID.value.text,
          "name": name.value.text,
          "aadhaar": aadhaarNo.value.text,
          "address": address.value.text,
          "birthdate": birthDate.value.text,
          "bloodgroup ": bloodGroup.value.text,
          "designation": designation.value.text,
          "emergency": emergency.value.text,
          "joiningdate": joiningDate.value.text,
          "mail": emailID.value.text,
          "mobile": mobileNo.value.text,
          "pan": panNo.value.text,
          "password": password.value.text,
          "profile": "",
        });
        ProgressDialog().hide(context);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => AdminHomeScreen()),
            (route) => false);

        employeeID.value.clear();
        name.value.clear();
        designation.value.clear();
        joiningDate.value.clear();
        emailID.value.clear();
        mobileNo.value.clear();
        birthDate.value.clear();
        bloodGroup.value.clear();
        aadhaarNo.value.clear();
        panNo.value.clear();
        address.value.clear();
        emergency.value.clear();
        password.value.clear();
      } catch (e) {
        Get.snackbar("Error", "Something went wrong...",
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
