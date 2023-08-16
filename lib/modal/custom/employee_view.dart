import 'package:flutter/material.dart';

import '../const/const_color.dart';

class EmployeeView extends StatelessWidget {
  final String label;
  final String value;

  const EmployeeView({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          style: TextStyle(
            fontSize: size.width * 0.041,
            color: ConstColor.blackText.withOpacity(0.9),
            overflow: TextOverflow.visible,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 28,
          child: Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.w600,
                  color: ConstColor.blackText.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: ConstColor.grey.withOpacity(0.9),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
