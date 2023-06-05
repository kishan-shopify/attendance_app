// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:io';

import 'package:attendance_app/modal/custom/gradient_button.dart';
import 'package:attendance_app/view/screen/employee/profile_page.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../../modal/const/const_color.dart';
import '../../../modal/const/const_image.dart';
import '../../../modal/const/text_style.dart';
import '../../../modal/custom/gesture_circle.dart';
import '../../../modal/modal_class/user.dart';

class EntryInOutScreen extends StatefulWidget {
  const EntryInOutScreen({Key? key}) : super(key: key);

  @override
  State<EntryInOutScreen> createState() => _EntryInOutScreenState();
}

class _EntryInOutScreenState extends State<EntryInOutScreen> {
  final currentDate = DateTime.now().day.toString();
  String checkIn = "--/--";
  String checkOut = "--/--";

  var cameraController;
  var inputImage;
  var faces;
  XFile? _imageFile;
  late final FaceDetector faceDetector;


  @override
  void initState() {
    faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableClassification: true,
        enableContours: false,
        enableLandmarks: true,
        enableTracking: true,
        minFaceSize: 0.1,
      ),
    );
    _getRecord();

    super.initState();
  }

  @override
  void dispose() {
    faceDetector.close();
    super.dispose();
  }

  void _getRecord() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("Employee")
          .where('id', isEqualTo: User.employeeId)
          .get();

      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection("Employee")
          .doc(snap.docs[0].id)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();

      setState(() {
        checkIn = snap2['checkIn'];
        checkOut = snap2['checkOut'];
      });
    } catch (e) {
      setState(() {
        checkIn = "--/--";
        checkOut = "--/--";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top - 5,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // AnimatedTextKit(
                  //   animatedTexts: [
                  //     ColorizeAnimatedText(
                  //       "Janovis",
                  //       textAlign: TextAlign.center,
                  //       textStyle: TextStyle(
                  //         fontSize: size.width * 0.06,
                  //         fontWeight: FontWeight.w700,
                  //       ),
                  //       colors: [
                  //         ConstColor.primaryGradient2,
                  //         ConstColor.primaryGradient1,
                  //       ],
                  //     ),
                  //   ],
                  //   totalRepeatCount: 1,
                  //   pause: const Duration(milliseconds: 500),
                  //   displayFullTextOnTap: true,
                  // ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: size.height * 0.06,
                    width: size.width * 0.6,
                    child: Image.asset(
                      "assets/images/janovis_logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
                    },
                    child: Container(
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
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            DateFormat('hh:mm:ss a').format(DateTime.now()),
                            style: textStyleW600(
                                size.width * 0.1, ConstColor.blackText)),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: size.width * 0.001,
              ),
              Text(
                currentDate + DateFormat(' MMMM yyyy').format(DateTime.now()),
                style: textStyleW500(size.width * 0.05, Colors.black38),
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
              (checkOut == "--/--")
                  ? GestureCircle(
                      onTap: ()  {

                        (isInLocation) ? openCamera() :Get.snackbar("Error", "You're away from office..!",
                            colorText: ConstColor.white,
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                            backgroundColor: ConstColor.red.withOpacity(0.8),
                            icon: Icon(
                              Icons.error_outline,
                              color: ConstColor.white,
                              size: 30,
                            ));

                      },
                      image: ConstImage.finger,
                      btnLabel: (checkIn == "--/--") ? "Clock In" : "Clock Out",
                      gradientColor: (checkIn == "--/--")
                          ? [
                              ConstColor.primaryGradient2,
                              ConstColor.primaryGradient1,
                            ]
                          : [
                              ConstColor.btnGradient1,
                              ConstColor.btnGradient2,
                            ],
                    )
                  : GestureCircle(
                      onTap: () {
                        Get.snackbar("Oops..", "You have done for today..!",
                            colorText: ConstColor.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            backgroundColor: ConstColor.orange.withOpacity(0.8),
                            icon: Icon(
                              Icons.error_outline,
                              color: ConstColor.white,
                              size: 30,
                            ));
                      },
                      isMinimize: true,
                      image: ConstImage.doneToday,
                      btnLabel: "Done for Today",
                      gradientColor: [
                        ConstColor.grey,
                        ConstColor.grey,
                      ],
                    ),
              Expanded(
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      SizedBox(
                          height: 45,
                          width: 45,
                          child: Image.asset(
                            ConstImage.clockIn,
                            color: ConstColor.grey,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(checkIn,style: textStyleW600(size.width * 0.04, ConstColor.blackText),),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                          height: 45,
                          width: 45,
                          child: Image.asset(
                            ConstImage.clockOut,
                            color: ConstColor.grey,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(checkOut,style: textStyleW600(size.width * 0.04, ConstColor.blackText),),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
            ],
          ),
        ),
      ],
    );
  }

  clockInOut() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("Employee")
        .where('id', isEqualTo: User.employeeId)
        .get();

    DocumentSnapshot snap2 = await FirebaseFirestore.instance
        .collection("Employee")
        .doc(snap.docs[0].id)
        .collection("Record")
        .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
        .get();

    log("OUTPUT == $snap");
    log("OUTPUT 2 == $snap2");

    try {
      String checkIn = snap2['checkIn'];

      setState(() {
        checkOut = DateFormat('hh:mm a').format(DateTime.now());
      });

      await FirebaseFirestore.instance
          .collection("Employee")
          .doc(snap.docs[0].id)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .update({
        'date': Timestamp.now(),
        'checkIn': checkIn,
        'checkOut': DateFormat('hh:mm a').format(DateTime.now()),
      });
    } catch (e) {
      setState(() {
        checkIn = DateFormat('hh:mm a').format(DateTime.now());
      });

      await FirebaseFirestore.instance
          .collection("Employee")
          .doc(snap.docs[0].id)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .set({
        'date': Timestamp.now(),
        'checkIn': DateFormat('hh:mm a').format(DateTime.now()),
        'checkOut': "--/--",
      });
    }
  }

  // clockInOut(XFile? checkInImage, XFile? checkOutImage) async {
  //   try {
  //     // Ensure checkInImage and checkOutImage are not null
  //     if (checkInImage == null || checkOutImage == null) {
  //       throw Exception('Image files not found');
  //     }
  //
  //     QuerySnapshot snap = await FirebaseFirestore.instance
  //         .collection("Employee")
  //         .where('id', isEqualTo: User.employeeId)
  //         .get();
  //
  //     DocumentSnapshot snap2 = await FirebaseFirestore.instance
  //         .collection("Employee")
  //         .doc(snap.docs[0].id)
  //         .collection("Record")
  //         .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
  //         .get();
  //
  //     log("OUTPUT == $snap");
  //     log("OUTPUT 2 == $snap2");
  //
  //     String checkIn = snap2['checkIn'];
  //     String checkOut = DateFormat('hh:mm a').format(DateTime.now());
  //
  //     // Upload checkInImage to Firebase Storage
  //     String checkInImagePath = 'checkInImages/${DateTime.now().millisecondsSinceEpoch}.jpg';
  //     await firebase_storage.FirebaseStorage.instance
  //         .ref(checkInImagePath)
  //         .putFile(File(checkInImage.path));
  //
  //     // Upload checkOutImage to Firebase Storage
  //     String checkOutImagePath = 'checkOutImages/${DateTime.now().millisecondsSinceEpoch}.jpg';
  //     await firebase_storage.FirebaseStorage.instance
  //         .ref(checkOutImagePath)
  //         .putFile(File(checkOutImage.path));
  //
  //     await FirebaseFirestore.instance
  //         .collection("Employee")
  //         .doc(snap.docs[0].id)
  //         .collection("Record")
  //         .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
  //         .update({
  //       'date': Timestamp.now(),
  //       'checkInImage': checkInImagePath,
  //       'checkOutImage': checkOutImagePath,
  //       'checkIn': checkIn,
  //       'checkOut': checkOut,
  //     });
  //   } catch (e) {
  //     log('Error: $e');
  //   }
  // }





  Future<void> openCamera() async {
    // Ensure that there are cameras available on the device
    List<CameraDescription> cameras = await availableCameras();
    if (cameras.isEmpty) {
      log('No cameras available');
      return;
    }

    // Select the first available camera
    CameraDescription camera = cameras[1];

    // Create a CameraController and initialize it with the selected camera
    CameraController controller = CameraController(camera, ResolutionPreset.high);

    try {
      // Initialize the camera controller
      await controller.initialize();


      // Open a dialog box to show the camera preview
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(

            content: SizedBox(
              width: 300,
              height: 380,
              child: CameraPreview(controller),
            ),
            actions: [
              GradientButton(
                btnLabel: "Capture",
                onTap: () async {
                  final XFile fileClicked = await controller.takePicture();
                  setState(() {
                    _imageFile = fileClicked;
                  });
                  final File filePicked = File(_imageFile!.path);
                  inputImage = InputImage.fromFile(filePicked);
                  faces = await faceDetector.processImage(inputImage);
                  try {
                    if (faces.isNotEmpty) {
                      print("FACE RECOGNIZE ....!");
                      clockInOut();
                      Navigator.pop(context);
                    } else {
                      Get.snackbar("Error", "Face Not Recognized Properly..!",
                          colorText: ConstColor.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          backgroundColor: ConstColor.red.withOpacity(0.8),
                          icon: Icon(
                            Icons.error_outline,
                            color: ConstColor.white,
                            size: 30,
                          ));
                    }
                  } catch (e) {
                    Get.snackbar("Error", "$e",
                        colorText: ConstColor.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        backgroundColor: ConstColor.red.withOpacity(0.8),
                        icon: Icon(
                          Icons.error_outline,
                          color: ConstColor.white,
                          size: 30,
                        ));
                  }
                },
                labelColor: ConstColor.white,
                gradientColor: [
                  ConstColor.primaryGradient2,
                  ConstColor.primaryGradient1,
                ],
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }




}

