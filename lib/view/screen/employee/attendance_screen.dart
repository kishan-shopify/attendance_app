import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/home_screen_controller.dart';
import '../../../modal/modal_class/user.dart';
import '../../../modal/const/const_color.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final HomeScreenController homeController = Get.put(HomeScreenController());

  final String _month = DateFormat('MMMM').format(DateTime.now());

  @override
  void initState() {
    homeController.fetchPresentDays(User.id, _month);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Attendance",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: ConstColor.blackText,
                fontSize: size.width * 0.07,
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.04,
        ),
        Expanded(
          child: Container(
            height: size.height / 1.5,
            child: EasyRefresh(
              onRefresh: () async {
                // Fetch the present days again
                homeController.fetchPresentDays(User.id, _month);
              },
              child: Obx(
                () => ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: homeController.presentDays.length,
                  itemBuilder: (context, index) {
                    final doc = homeController.presentDays[index];
                    final date = doc['date'].toDate();
                    final checkIn = doc['checkIn'];
                    final checkOut = doc['checkOut'];
                    return Container(
                      width: size.width,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ConstColor.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: ConstColor.primaryBackGround),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text(
                                        DateFormat('dd').format(date),
                                        style: TextStyle(
                                          fontSize: size.width * 0.045,
                                          color: ConstColor.blackText,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('EE').format(date),
                                        style: TextStyle(
                                          fontSize: size.width * 0.04,
                                          color: ConstColor.blackText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: Container()),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Punch in",
                                        style: TextStyle(
                                          fontSize: size.width * 0.039,
                                          color: ConstColor.blackText,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        checkIn,
                                        style: TextStyle(
                                          fontSize: size.width * 0.037,
                                          color: ConstColor.blackText.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: Container()),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Punch out",
                                        style: TextStyle(
                                          fontSize: size.width * 0.037,
                                          color: ConstColor.blackText,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        checkOut,
                                        style: TextStyle(
                                          fontSize: size.width * 0.038,
                                          color: ConstColor.blackText
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ConstColor.red,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(11),
                                bottomRight: Radius.circular(11),
                              ),
                            ),
                            width: 70,
                            height: 80,
                            child: Text(
                              (checkOut == "--/--") ? "A" : "B",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
