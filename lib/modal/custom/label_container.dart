import 'package:flutter/material.dart';

import '../const/const_color.dart';
import '../const/text_style.dart';

class LabelContainer extends StatelessWidget {
  final String label;
  final String value;
  final bool isWarning;

  const LabelContainer({
    super.key,
    required this.label,
    required this.value,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
        width: size.width,
        decoration: BoxDecoration(
            // color: ConstColor.white,
           border: Border.all(color: ConstColor.primary,width: 2),
            borderRadius: BorderRadius.circular(14)),
        child: Column(
          children: [
            Text(
              label,
              style: textStyleW600(
                size.width * 0.042,
                (isWarning) ? ConstColor.red : ConstColor.blackText,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.center,
              width: size.width * 0.1,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ConstColor.primary
              ),
              child: Text(
                value,
                style: textStyleW600(
                  size.width * 0.046,
                  (isWarning) ? ConstColor.white : ConstColor.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
