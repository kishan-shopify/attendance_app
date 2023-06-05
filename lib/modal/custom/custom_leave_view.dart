import 'package:flutter/material.dart';

import '../const/const_color.dart';
import '../const/const_image.dart';
import '../const/text_style.dart';
import 'leave_page_label.dart';

class LeaveView extends StatelessWidget {
  final String leaveType;
  final String fromDate;
  final String toDate;
  final String reason;

  const LeaveView(
      {Key? key,
      required this.leaveType,
      required this.fromDate,
      required this.toDate,
      required this.reason})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            LeavePageLabel(
              isWidth50: true,
              label: leaveType,
            ),
            Expanded(child: Container()),
            LeavePageLabel(
              label: fromDate,
            ),
            Expanded(child: Container()),
            LeavePageLabel(
              label: toDate,
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.only(left: 5),
                height: 18,
                width: 15,
                child: Image.asset(ConstImage.optionVertical,fit: BoxFit.cover,),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: ConstColor.grey.withOpacity(0.5),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
