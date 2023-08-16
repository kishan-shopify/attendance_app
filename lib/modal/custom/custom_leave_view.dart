import 'dart:developer';

import 'package:flutter/material.dart';

import '../const/const_color.dart';
import '../const/const_image.dart';
import '../const/text_style.dart';
import '../modal_class/leave_class.dart';

class LeaveView extends StatelessWidget {
  final LeaveData leave;

  const LeaveView({Key? key, required this.leave}) : super(key: key);

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
                  "FL",
                  // "leave.leaveType",
                  style:
                      textStyleW600(size.width * 0.043, ConstColor.blackText),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.65,
                child: Text(
                  "${leave.startDate}  --   ${leave.endDate}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyleW600(size.width * 0.037, ConstColor.blackText),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap : (){
                      showDialog(context: context, builder: (_){
                        return SimpleDialog(
                          contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.07,vertical: 25),
                          title: Text("Reason",style: textStyleW600(size.width * 0.04, ConstColor.blackText),),
                          children: [
                            Text("${leave.reason}")
                          ],
                        );
                      });
                    },
                    child: Image.asset(
                      ConstImage.view,
                      height: 20,
                      width: 20,
                    ),
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
