import 'package:attendance_app/modal/const/const_color.dart';
import 'package:attendance_app/modal/const/text_style.dart';
import 'package:flutter/material.dart';

class GestureCircle extends StatelessWidget {
  final Function onTap;
  final String image;
  final String btnLabel;
  final List<Color> gradientColor;
  final bool isMinimize;

  const GestureCircle({
    Key? key,
    required this.onTap,
    required this.image,
    required this.btnLabel,
    required this.gradientColor,
    this.isMinimize = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              blurRadius: 4,
              offset: const Offset(2, 4), // Shadow position
            ),
          ],
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColor),
        ),
        height: size.height * 0.28,
        width: size.width * 0.52,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              color: ConstColor.white,
              height: (isMinimize) ? size.height * 0.1 : size.height * 0.12,
              width: size.height * 0.12,
            ),
            SizedBox(
              height: size.height * 0.012,
            ),
            Text(
              btnLabel,
              style: textStyleW500((isMinimize) ? size.width * 0.05 : size.width * 0.052, ConstColor.white),
            ),
          ],
        ),
      ),
    );
  }
}
