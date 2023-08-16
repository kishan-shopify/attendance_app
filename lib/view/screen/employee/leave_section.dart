// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slide_action/slide_action.dart';
import 'package:slide_switcher/slide_switcher.dart';

import '../../../controller/home_screen_controller.dart';
import '../../../controller/leave_controller.dart';
import '../../../modal/const/const_color.dart';
import '../../../modal/const/const_image.dart';
import '../../../modal/const/text_style.dart';
import '../../../modal/custom/app_bar.dart';
import '../../../modal/custom/custom_leave_view.dart';
import '../../../modal/modal_class/user.dart';
import 'apply_leave_screen.dart';

class LeaveSection extends StatefulWidget {
  const LeaveSection({Key? key}) : super(key: key);

  @override
  State<LeaveSection> createState() => _LeaveSectionState();
}

class _LeaveSectionState extends State<LeaveSection> {
  final HomeScreenController homeController = Get.put(HomeScreenController());
  final LeaveController leaveController = Get.put(LeaveController());
  int switcherIndex = 0;
  bool stretchThumb = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        height: double.infinity,
        width: double.infinity,
        color: ConstColor.primaryBackGround,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + size.height * 0.02,
            ),
            CustomAppBar(
              onTap: () {
                homeController.notificationVisible.value = !homeController.notificationVisible.value;
              },
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Leaves",
                  style: textStyleW700(
                    size.width * 0.07,
                    ConstColor.blackText,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              width: size.width,
              height: size.height * 0.078,
              child: SlideAction(
                stretchThumb: stretchThumb,
                trackBuilder: (context, state) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: ConstColor.primary, width: 2),
                      color: ConstColor.primaryBackGround,
                    ),
                    child: Text(
                      "APPLY LEAVE",
                      style: textStyleW600(
                          size.width * 0.042, ConstColor.blackText),
                    ),
                  );
                },
                thumbBuilder: (context, state) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ConstColor.primary),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        width: stretchThumb ? 64 : double.infinity,
                        child: SvgPicture.asset(ConstImage.arrow),
                      ),
                    ),
                  );
                },
                action: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ApplyLeaveScreen()));
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              width: size.width,
              height: size.height * 0.078,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: ConstColor.primary, width: 2),
              ),
              child: SlideSwitcher(
                onSelect: (int index) => setState(() => switcherIndex = index),
                containerHeight: 40,
                containerWight: 300,
                containerColor: ConstColor.primaryBackGround,
                slidersGradients: [
                  LinearGradient(
                    colors: [
                      ConstColor.primary,
                      ConstColor.primary,
                    ],
                  ),
                ],
                children: [
                  Text(
                    'Pending',
                    style: TextStyle(
                        fontSize: switcherIndex == 0
                            ? size.width * 0.04
                            : size.width * 0.037,
                        fontWeight: switcherIndex == 0
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: switcherIndex == 0
                            ? ConstColor.white.withOpacity(0.9)
                            : ConstColor.blackText),
                  ),
                  Text(
                    'Approved',
                    style: TextStyle(
                        fontSize: switcherIndex == 1
                            ? size.width * 0.04
                            : size.width * 0.037,
                        fontWeight: switcherIndex == 1
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: switcherIndex == 1
                            ? ConstColor.white.withOpacity(0.9)
                            : ConstColor.blackText),
                  ),
                  Text(
                    'Rejected',
                    style: TextStyle(
                        fontSize: switcherIndex == 2
                            ? size.width * 0.04
                            : size.width * 0.037,
                        fontWeight: switcherIndex == 2
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: switcherIndex == 2
                            ? ConstColor.white.withOpacity(0.9)
                            : ConstColor.blackText),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            (switcherIndex == 0)
                ? pendingLeave()
                : (switcherIndex == 1)
                    ? approvedLeave()
                    : rejectedLeave(),
          ],
        ),
      ),
    );
  }

  Widget pendingLeave() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Employee')
            .doc(User.id)
            .collection('Leaves')
            .where('status', isEqualTo: 'Pending')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No pending leave applications found.');
          }

          leaveController.updateLeaves(snapshot.data!);

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: leaveController.pendingLeaves.length,
            itemBuilder: (context, index) {
              var leave = leaveController.pendingLeaves[index];
              return LeaveView(leave: leave);
            },
          );
        },
      ),
    );
  }

  Widget approvedLeave() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Employee')
            .doc(User.id)
            .collection('Leaves')
            .where('status', isEqualTo: 'Approved')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No Approved leave applications found.');
          }

          leaveController.updateLeaves(snapshot.data!);

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: leaveController.approvedLeaves.length,
            itemBuilder: (context, index) {
              var leave = leaveController.approvedLeaves[index];
              return LeaveView(leave: leave);
            },
          );
        },
      ),
    );
  }

  Widget rejectedLeave() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Employee')
            .doc(User.id)
            .collection('Leaves')
            .where('status', isEqualTo: 'Rejected')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No Rejected leave applications found.');
          }

          leaveController.updateLeaves(snapshot.data!);

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: leaveController.rejectedLeaves.length,
            itemBuilder: (context, index) {
              var leave = leaveController.rejectedLeaves[index];
              return LeaveView(leave: leave);
            },
          );
        },
      ),
    );
  }

}

