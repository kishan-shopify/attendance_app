import 'package:flutter/material.dart';

import '../const/const_color.dart';
import '../const/text_style.dart';

class LeavePageLabel extends StatelessWidget {
  final bool isWidth50;
  final String label;
  const LeavePageLabel({Key? key, required this.label,this.isWidth50 = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final Size size = MediaQuery.of(context).size;
    return  Container(

      alignment: Alignment.center,
      width: (isWidth50) ? 50 : 100,
      child: Text(
        label,
        style: textStyleW600(
            size.width * 0.035, ConstColor.blackText),
      ),
    );
  }
}
