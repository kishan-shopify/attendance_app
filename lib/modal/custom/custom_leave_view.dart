import 'package:flutter/material.dart';

import '../const/const_color.dart';
import '../const/const_image.dart';
import '../const/text_style.dart';

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
        Container(
          width: size.width,
          height: size.height * 0.06,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: ConstColor.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width * 0.12,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                  color: ConstColor.primary,
                ),
                child: Text(
                  leaveType,
                  style:
                      textStyleW600(size.width * 0.043, ConstColor.blackText),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  width: size.width * 0.65,
                  child: Text(
                    "From $fromDate - $toDate",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        textStyleW600(size.width * 0.037, ConstColor.blackText),
                  )),
              Row(
                children: [
                  Image.asset(
                    ConstImage.view,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
