import 'package:attendance_app/view/screen/employee/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/login_controller.dart';
import '../../modal/const/const_color.dart';
import '../../modal/const/const_image.dart';
import '../../modal/custom/custom_button.dart';
import '../../modal/custom/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
        color: ConstColor.primaryBackGround,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 30,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: Image.asset(
                    ConstImage.janovisLogo,
                    color: Colors.black,
                    fit: BoxFit.fitWidth,
                    width: 200,
                    height: 200,
                  )),
              SizedBox(
                height: size.height * 0.1,
              ),
              Obx(
                () => (controller.isAdminScreen.value)
                    ? Column(
                        children: [
                          CustomTextField(
                            label: "Admin ID",
                            controller: controller.adminID.value,
                            maxLength: 6,
                            isCapital: true,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          CustomTextField(
                            label: "Password",
                            controller: controller.adminPassword.value,
                            isPassword: true,
                            maxLength: 8,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          GestureDetector(
                            onTap: () {

                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: ConstColor.blackText,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          CustomButton(
                            btnLabel: "LOGIN",
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              controller.adminValidation(context);
                            },
                            btnColor: ConstColor.primary,
                            labelColor: ConstColor.blackText,
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Are you Employee?  ",
                                style: TextStyle(
                                    color: ConstColor.blackText,
                                    fontSize: size.width * 0.04),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.isAdminScreen.value =
                                      !controller.isAdminScreen.value;
                                },
                                child: Text(
                                  "Click here",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: ConstColor.blackText,
                                      fontSize: size.width * 0.04,
                                      letterSpacing: 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          CustomTextField(
                            label: "Employee ID",
                            controller: controller.employeeID.value,
                            maxLength: 6,
                            isCapital: true,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          CustomTextField(
                            label: "Password",
                            controller: controller.employeePassword.value,
                            isPassword: true,
                            maxLength: 8,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()));
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: ConstColor.blackText,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),

                          CustomButton(
                            btnLabel: "LOGIN",
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              controller.employeeValidation(context);
                            },
                            btnColor: ConstColor.primary,
                            labelColor: ConstColor.blackText,
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Are you Admin?  ",
                                style: TextStyle(
                                    color: ConstColor.blackText,
                                    fontSize: size.width * 0.04),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.isAdminScreen.value =
                                      !controller.isAdminScreen.value;
                                },
                                child: Text(
                                  "Click here",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: ConstColor.blackText,
                                      fontSize: size.width * 0.04,
                                      letterSpacing: 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
