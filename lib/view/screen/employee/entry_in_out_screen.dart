import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/camera_controller.dart';
import '../../../controller/home_screen_controller.dart';
import '../../../modal/const/const_color.dart';
import '../../../modal/const/const_image.dart';
import '../../../modal/const/text_style.dart';
import '../../../modal/custom/custom_button.dart';
import '../../../modal/custom/label_container.dart';
import '../../../modal/custom/progress_indicator.dart';
import '../../../modal/modal_class/user.dart';
import '../../../view/screen/employee/camera_screen.dart';

class EntryInOutScreen extends StatefulWidget {
  const EntryInOutScreen({Key? key}) : super(key: key);

  @override
  State<EntryInOutScreen> createState() => _EntryInOutScreenState();
}

class _EntryInOutScreenState extends State<EntryInOutScreen> {
  final HomeScreenController homeController = Get.put(HomeScreenController());
  final CameraScreenController cameraController =
  Get.put(CameraScreenController());
  final String _month = DateFormat('MMMM').format(DateTime.now());
  static const double officeLatitude = 23.027021;
  static const double officeLongitude = 72.5063857;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ProgressDialog().show(context);
      await homeController.fetchPresentDays(User.id, _month);
      await getRecord();
      ProgressDialog().hide(context);
    });
  }

  Future<void> getRecord() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("Employee")
          .where('id', isEqualTo: User.employeeId)
          .get();

      DocumentSnapshot snap2 = await FirebaseFirestore.instance.collection("Employee")
          .doc(snap.docs[0].id).collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();

      log("INPUT == $snap");
      log("INPUT 2 == $snap2");

      setState(() {
        cameraController.checkIn.value = snap2['checkIn'];
        cameraController.checkOut.value = snap2['checkOut'];
        cameraController.checkInUrl.value = snap2['checkInImage'];
        cameraController.checkOutUrl.value = snap2['checkOutImage'];
      });
    } catch (e) {
      setState(() {
        cameraController.checkIn.value = "--/--";
        cameraController.checkOut.value = "--/--";
        cameraController.checkInUrl.value = "";
        cameraController.checkOutUrl.value = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      getGreetingMessage(),
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      style: textStyleW400(size.width * 0.042,
                          ConstColor.blackText.withOpacity(0.8)),
                    ),
                    Text(
                      "Let's get to work",
                      style: textStyleW700(
                          size.width * 0.062, ConstColor.blackText),
                    ),
                  ],
                ),
                Image.asset(
                  ConstImage.stopwatch,
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Row(
            children: [
              Expanded(
                child: Container(),
              ),
              Container(
                width: size.width * 0.70,
                alignment: Alignment.center,
                // padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                decoration: BoxDecoration(
                  color: ConstColor.primary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(color: ConstColor.blackText,width: 0.5)
                ),
                child: StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return Text(
                      DateFormat('hh:mm:ss a').format(DateTime.now()),
                      style: textStyleW600(
                        size.width * 0.098,
                        ConstColor.blackText,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          CustomButton(
            btnLabel: (cameraController.checkIn.value != "--/--" &&
                cameraController.checkOut.value == "--/--")
                ? "Punch Out"
                : (cameraController.checkIn.value != "--/--" &&
                cameraController.checkOut.value != "--/--")
                ? "Done Today"
                : "Punch In",
            onTap: () {
              (cameraController.checkIn.value != "--/--" &&
                  cameraController.checkOut.value != "--/--")
                  ? Get.snackbar("Oops", "You've done for today..!",
                  colorText: ConstColor.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 15),
                  backgroundColor: ConstColor.red.withOpacity(0.8),
                  icon: Icon(
                    Icons.error_outline,
                    color: ConstColor.white,
                    size: 30,
                  ))
                  : checkDistanceFromOffice();
            },
            btnColor: ConstColor.primary,
            labelColor: ConstColor.blackText,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your Overview",
                style: textStyleW600(size.width * 0.050, ConstColor.blackText),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Row(
            children: [
              LabelContainer(
                label: 'Present Days',
                value: '${homeController.presentDays.length}',
              ),
              SizedBox(
                width: size.width * 0.04,
              ),
              LabelContainer(
                label: 'Leaves',
                value: '${homeController.leaves.value}',
              ),
            ],
          ),
          SizedBox(
            height: size.width * 0.04,
          ),
          Row(
            children: [
              LabelContainer(
                label: 'Late Coming',
                value: '${homeController.lateComing.value}',
                isWarning: true,
              ),
              SizedBox(
                width: size.width * 0.04,
              ),
              LabelContainer(
                label: 'Early going',
                value: '${homeController.earlyGoing.value}',
                isWarning: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getGreetingMessage() {
    final currentTime = DateTime.now();
    if (currentTime.hour < 12) {
      return "Good morning ${User.name}";
    } else if (currentTime.hour < 18) {
      return "Good afternoon ${User.name}";
    } else {
      return "Good evening ${User.name}";
    }
  }

  checkDistanceFromOffice() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      Get.snackbar("Error", "Please enabled location..!",
          colorText: ConstColor.white,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          backgroundColor: ConstColor.red.withOpacity(0.8),
          icon: Icon(
            Icons.error_outline,
            color: ConstColor.white,
            size: 30,
          ));
    }

    try { // Get the current position of the device
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      // Calculate the distance between the user's location and the office location
      double distanceInMeters = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        officeLatitude,
        officeLongitude,
      );

      // Define the threshold distance (e.g., 200 meters)
      double thresholdDistance = 15;

      if (distanceInMeters <= thresholdDistance) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const CameraScreen()));
      } else {
        Get.snackbar("Error", "You're away from office..!",
            colorText: ConstColor.white,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            backgroundColor: ConstColor.red.withOpacity(0.8),
            icon: Icon(
              Icons.error_outline,
              color: ConstColor.white,
              size: 30,
            ));
      }
    } catch (e) {
      log("Getting Error : $e");
  }
  }
}
