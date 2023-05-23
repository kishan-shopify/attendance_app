import 'package:attendance_app/modal/const/const_color.dart';
import 'package:attendance_app/modal/const/text_style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  int maxLength;
  bool isCapital;
  final String label;

  CustomTextField({
    Key? key,
    required this.controller,
    this.isPassword = false,
    required this.maxLength,
    this.isCapital = false,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: ConstColor.white,
            borderRadius: BorderRadius.circular(14),
           ),
        child: Row(
          children: [
            Icon((isPassword) ? Icons.lock : Icons.person),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: TextField(
              controller: controller,
              obscureText: isPassword,
              maxLength: maxLength,
              obscuringCharacter: "*",
              textCapitalization: (isCapital)
                  ? TextCapitalization.characters
                  : TextCapitalization.none,
              cursorColor: ConstColor.blackText,
              style: textStyleW500(size.width * 0.045, ConstColor.blackText),
              decoration: InputDecoration(
                hintText: label,
                counterText: "",
                border: InputBorder.none,
              ),
            )),
          ],
        ));
  }
}
