import 'package:flutter/material.dart';

import '../const/const_color.dart';

class ShowClockInOut extends StatelessWidget {

  final String checkTime;
  final Color textColor;


  const ShowClockInOut({Key? key, required this.checkTime, required this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: 100,
      alignment: Alignment.center,
      child: Text(
        checkTime,
        style: TextStyle(
          fontSize: size.width * 0.05,
          color: textColor
        ),
      ),
    );
  }
}
