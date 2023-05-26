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
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              ConstColor.primaryGradient1,
              ConstColor.primaryGradient2,
            ])),
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
                    color: Colors.white,
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
                            onTap: () {},
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: ConstColor.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          CustomButton(
                            onTap: () {
                              FocusScope.of(context).unfocus();},
                            btnLabel: "LOGIN",
                            btnColor: ConstColor.white,
                            labelColor: ConstColor.btnGradient1,
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
                                    color: ConstColor.white,
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
                                      color: ConstColor.white,
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
                            onTap: () {},
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: ConstColor.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          CustomButton(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              controller.employeeValidation(context);
                            },
                            btnLabel: "LOGIN",
                            btnColor: ConstColor.white,
                            labelColor: ConstColor.btnGradient1,
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
                                    color: ConstColor.white,
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
                                      color: ConstColor.white,
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
