import 'package:attendance_app/controller/password_controller.dart';
import 'package:attendance_app/modal/custom/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../modal/const/const_color.dart';
import '../../../modal/const/const_image.dart';
import '../../../modal/custom/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final PasswordController controller = Get.put(PasswordController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
        decoration: BoxDecoration(color: ConstColor.primary),
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
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                "Forgot Password ?",
                style: TextStyle(
                  color: ConstColor.white,
                  fontWeight: FontWeight.w600,
                  fontSize: size.width * 0.075,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Column(
                children: [
                  CustomTextField(
                    label: "Enter Your Email",
                    controller: controller.email.value,
                    maxLength: 20,
                    isCapital: true,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  CustomButton(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    btnLabel: "Send",
                    btnColor: ConstColor.white,
                    labelColor: ConstColor.primary,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
