import 'package:attendance_app/modal/const/const_color.dart';
import 'package:attendance_app/modal/const/text_style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnLabel;
  final Function onTap;
  final Color btnColor;
  final Color labelColor;

  const CustomButton(
      {Key? key,
      required this.btnLabel,
      required this.onTap,
      required this.btnColor,
      required this.labelColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(14)
        ),
       padding: EdgeInsets.symmetric(vertical: size.height * 0.013),
        width: size.width,

        child: Center(
          child: Text(btnLabel,
              style: textStyleW700(size.width * 0.048, labelColor)),
        ),
      ),
    );
  }
}
