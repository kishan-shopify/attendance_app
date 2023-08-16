import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  Rx<TextEditingController> employeeID = TextEditingController().obs;
  Rx<TextEditingController> emailID = TextEditingController().obs;
  Rx<TextEditingController> mobileNo = TextEditingController().obs;
  Rx<TextEditingController> birthDate = TextEditingController().obs;
  Rx<TextEditingController> bloodGroup = TextEditingController().obs;
  Rx<TextEditingController> aadhaarNo = TextEditingController().obs;
  Rx<TextEditingController> panNo = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;
  Rx<TextEditingController> emergencyNo = TextEditingController().obs;
}