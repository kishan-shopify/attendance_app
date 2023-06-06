import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../modal/const/const_color.dart';
import '../../../modal/const/const_image.dart';
import '../../../modal/const/text_style.dart';
import '../../../modal/custom/gradient_button.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({Key? key}) : super(key: key);

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  final TextEditingController reason = TextEditingController();

  String startDate = "";
  String endDate = "";

  static const List<String> leaveReason = <String>[
    'Casual Leave',
    'Medical Leave',
    'Function Leave',
    'Trip Leave',
    'Other'
  ];
  String dropdownValue = leaveReason.first;



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          RotatedBox(
            quarterTurns: 2,
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                ConstImage.background,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top - 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: size.height * 0.06,
                      width: size.width * 0.6,
                      child: Image.asset(
                        "assets/images/janovis_logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),

                    Container(
                      height: size.height * 0.12,
                      width: size.width * 0.12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            blurRadius: 4,
                            offset: const Offset(2, 4), // Shadow position
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: ConstColor.primaryGradient2,
                        radius: size.width * 0.12,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/rutvik.jpg",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.0008,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Apply Leave",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: ConstColor.blackText,
                          fontSize: size.width * 0.07)),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Expanded(
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    color: ConstColor.white.withOpacity(0.85),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.02
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "From",
                                style: textStyleW500(
                                  size.width * 0.045,
                                  ConstColor.blackText,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 25,),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "To",
                                style: textStyleW500(
                                  size.width * 0.045,
                                  ConstColor.blackText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.006,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                datePick(context, "start");
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                alignment: Alignment.center,
                                height: size.height * 0.06,
                               width: double.infinity,
                                decoration: BoxDecoration(
                                  color: ConstColor.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: ConstColor.blackText)
                                ),
                                child:Text(
                                  startDate.isEmpty ? "Select Date" : startDate,
                                  style: textStyleW500(
                                      size.width * 0.04, ConstColor.blackText),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 25,),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                datePick(context, "end");
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                alignment: Alignment.center,
                                height: size.height * 0.06,

                                decoration: BoxDecoration(
                                    color: ConstColor.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: ConstColor.blackText)
                                ),
                                child:Text(
                                  endDate.isEmpty ? "Select Date" : endDate,
                                  style: textStyleW500(
                                      size.width * 0.04, ConstColor.blackText),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.045,
                      ),
                      Text(
                        "Leave Type",
                        style: textStyleW500(
                          size.width * 0.045,
                          ConstColor.blackText,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.006,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        height: size.height * 0.06,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ConstColor.white,
                          borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: ConstColor.blackText)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            hint: const Text("Select Reason"),
                            isExpanded: true,
                            elevation: 16,
                            style: textStyleW500(
                                size.width * 0.04, ConstColor.blackText),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: leaveReason
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.045,
                      ),
                      Text(
                        "Reason",
                        style: textStyleW500(
                          size.width * 0.045,
                          ConstColor.blackText,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.006,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        height: size.height * 0.20,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ConstColor.white,
                          borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: ConstColor.blackText)
                        ),
                        child: TextField(
                          controller: reason,
                          cursorColor: ConstColor.blackText,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Mention a Reason Here...",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.045,
                      ),
                      GradientButton(
                        btnLabel: "Apply",
                        onTap: sendEmail,
                        labelColor: ConstColor.white,
                        gradientColor: [
                          ConstColor.primaryGradient2,
                          ConstColor.primaryGradient1,
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

    );
  }


  void datePick(BuildContext context, String selectedDateType) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: ConstColor.primaryGradient1,
            ),
          ),
          child: Container(child: child),
        );
      },
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      setState(() {
        if (selectedDateType == "start") {
          startDate = formattedDate;
        } else if (selectedDateType == "end") {
          endDate = formattedDate;
        }
      });
    }
  }

  void sendEmail() async {
    final String encodedStartDate = Uri.encodeQueryComponent(startDate);
    final String encodedEndDate = Uri.encodeQueryComponent(endDate);
    final String encodedReason = Uri.encodeQueryComponent(reason.text);

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'rutvik.janovis@gmail.com',
      queryParameters: {
        'subject': 'Leave Application',
        'body':
        'From: $encodedStartDate\nTo: $encodedEndDate\nReason: $encodedReason'
      },
    );

    // Manually replace spaces with %20 in the email body
    final String emailBody = emailLaunchUri.toString().replaceAll('+', ' ');

    try {
      await launch(emailBody);
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to launch email client.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

}
