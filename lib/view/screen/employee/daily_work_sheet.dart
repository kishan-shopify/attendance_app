import 'package:flutter/material.dart';

class DailyWorkSheet extends StatefulWidget {
  const DailyWorkSheet({Key? key}) : super(key: key);

  @override
  State<DailyWorkSheet> createState() => _DailyWorkSheetState();
}

class _DailyWorkSheetState extends State<DailyWorkSheet> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "WORKING PROGRESS",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
    );
  }
}
