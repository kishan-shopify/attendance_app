import 'package:flutter/material.dart';

import '../const/text_style.dart';

class GradientButton extends StatelessWidget {
  final String btnLabel;
  final List<Color> gradientColor;
  final Function onTap;
  final Color labelColor;

  const GradientButton(
      {Key? key,
      required this.btnLabel,
      required this.onTap,
      required this.labelColor,
      required this.gradientColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 55,
        width: size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.topLeft,
              colors: gradientColor),
        ),
        child: Text(btnLabel,
            style: textStyleW700(size.width * 0.048, labelColor)),
      ),
    );
  }
}
