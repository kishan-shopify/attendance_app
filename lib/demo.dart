// Text(
// "Choose Date",
// style: textStyleW500(
// size.width * 0.045,
// ConstColor.blackText,
// ),
// ),
// SizedBox(
// height: size.height * 0.006,
// ),
// Container(
// padding: const EdgeInsets.symmetric(horizontal: 12),
// alignment: Alignment.center,
// height: size.height * 0.06,
// width: double.infinity,
// decoration: BoxDecoration(
// color: ConstColor.white,
// borderRadius: BorderRadius.circular(16),
// ),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Container(
// alignment: Alignment.center,
// width: 110,
// child: GestureDetector(
// onTap: () {
// datePick(context, "start");
// },
// child: Text(
// startDate.isEmpty ? "From" : startDate,
// style: textStyleW500(
// size.width * 0.04, ConstColor.blackText),
// ),
// ),
// ),
// Container(
// alignment: Alignment.center,
// width: 110,
// child: GestureDetector(
// onTap: () {
// datePick(context, "end");
// },
// child: Text(
// endDate.isEmpty ? "To" : endDate,
// style: textStyleW500(
// size.width * 0.04, ConstColor.blackText),
// ),
// ),
// ),
// ],
// ),
// ),
// SizedBox(
// height: size.height * 0.045,
// ),
// Text(
// "Leave Type",
// style: textStyleW500(
// size.width * 0.045,
// ConstColor.blackText,
// ),
// ),
// SizedBox(
// height: size.height * 0.006,
// ),
// Container(
// padding: const EdgeInsets.symmetric(horizontal: 25),
// height: size.height * 0.06,
// width: double.infinity,
// decoration: BoxDecoration(
// color: ConstColor.white,
// borderRadius: BorderRadius.circular(16),
// ),
// child: DropdownButtonHideUnderline(
// child: DropdownButton<String>(
// value: dropdownValue,
// hint: const Text("Select Reason"),
// isExpanded: true,
// elevation: 16,
// style: textStyleW500(
// size.width * 0.04, ConstColor.blackText),
// onChanged: (String? value) {
// setState(() {
// dropdownValue = value!;
// });
// },
// items: leaveReason
//     .map<DropdownMenuItem<String>>((String value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(value),
// );
// }).toList(),
// ),
// ),
// ),
// SizedBox(
// height: size.height * 0.045,
// ),
// Text(
// "Reason",
// style: textStyleW500(
// size.width * 0.045,
// ConstColor.blackText,
// ),
// ),
// SizedBox(
// height: size.height * 0.006,
// ),
// Container(
// padding: const EdgeInsets.symmetric(horizontal: 25),
// height: size.height * 0.20,
// width: double.infinity,
// decoration: BoxDecoration(
// color: ConstColor.white,
// borderRadius: BorderRadius.circular(16),
// ),
// child: TextField(
// controller: reason,
// cursorColor: ConstColor.blackText,
// maxLines: null,
// decoration: const InputDecoration(
// border: InputBorder.none,
// hintText: "Mention a Reason Here...",
// ),
// ),
// ),
// SizedBox(
// height: size.height * 0.045,
// ),
// GradientButton(
// btnLabel: "Apply",
// onTap: sendEmail,
// labelColor: ConstColor.white,
// gradientColor: [
// ConstColor.primaryGradient2,
// ConstColor.primaryGradient1,
// ],
// ),

import 'package:flutter/material.dart';
import 'package:slide_switcher/slide_switcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SlideSwitcher(
          children: [
            Text('First'),
            Text('Second'),
          ],
          onSelect: (index) {},
          containerHeight: 40,
          containerWight: 350,
        ),
      ),
    );
  }
}
