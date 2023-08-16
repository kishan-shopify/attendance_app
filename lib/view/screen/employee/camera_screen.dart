// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:intl/intl.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import '../../../controller/camera_controller.dart';
import '../../../modal/const/const_color.dart';
import '../../../modal/const/const_image.dart';
import '../../../modal/const/text_style.dart';
import '../../../modal/modal_class/user.dart';
import 'home_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CameraScreen createState() => _CameraScreen();
}

class _CameraScreen extends State<CameraScreen> {
  final CameraScreenController cameraController = Get.put(CameraScreenController());



  // ignore: prefer_typing_uninitialized_variables
  XFile? _imageFile;
  bool isLoading = false;
  bool isIdentical = false;

  // ignore: prefer_typing_uninitialized_variables
  var inputImage;

  // ignore: prefer_typing_uninitialized_variables
  var faces;

  List<CameraDescription> cameras = [];

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  int _selectedCameraIndex = 1;

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(
        cameras[_selectedCameraIndex], ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
    setState(() {});
  }

  void toggleCamera() {
    if (mounted) {
      int newCameraIndex = (_selectedCameraIndex + 1) % cameras.length;
      _selectedCameraIndex = newCameraIndex;
      _controller = CameraController(
        cameras[_selectedCameraIndex],
        ResolutionPreset.medium,
      );
      _initializeControllerFuture = _controller.initialize();
      if (mounted) {
        setState(() {});
      }
    }
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

      cameraController.checkIn.value = snap2['checkIn'] ?? "--/--";
      cameraController.checkOut.value = snap2['checkOut'] ?? "--/--";
      cameraController.checkInUrl.value = snap2['checkInImage'] ?? "";
      cameraController.checkOutUrl.value = snap2['checkOutImage'] ?? "";
    } catch (e) {
      cameraController.checkIn.value = "--/--";
      cameraController.checkOut.value = "--/--";
      cameraController.checkInUrl.value = "";
      cameraController.checkOutUrl.value = "";
    }
  }


  @override
  void initState() {
    _getRecord();
    _initializeCamera();
    captureImage();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    cameraController.faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ConstColor.primaryBackGround,
      appBar: AppBar(
        backgroundColor: ConstColor.primaryBackGround,
        elevation: 0,
        centerTitle: true,
        leading: BackButton(
          color: ConstColor.blackText.withOpacity(0.7),
        ),
        title: Text(
          (cameraController.checkIn.value == "--/--") ? "Punch In" : "Punch Out",
          style: textStyleW600(size.width * 0.053, ConstColor.blackText),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.only(top: 10, right: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: ConstColor.white,
              ),
              child: _buildCameraToggleButton(),
            ),
          ),
          Expanded(child: Container()),
          WidgetCircularAnimator(
            size: size.width * 0.85,
            innerIconsSize: 3,
            outerIconsSize: 3,
            innerAnimation: Curves.easeInOutBack,
            outerAnimation: Curves.easeInOutBack,
            innerColor: Colors.deepPurple,
            outerColor: ConstColor.primary,
            innerAnimationSeconds: 5,
            outerAnimationSeconds: 5,
            child: FutureBuilder(
                future: _initializeControllerFuture,
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.done) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: ConstColor.grey),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(size.width / 2),
                        child: (!_controller.value.isInitialized)
                            ? Container()
                            : CameraPreview(_controller),
                      ),
                    );
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      color: ConstColor.primary,
                    ));
                  }
                }),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Text(
            (cameraController.checkIn.value == "--/--") ?
            "Verify to Punch In" : "Verify to Punch Out",
            style: textStyleW600(size.width * 0.058, ConstColor.blackText),
          ),
          SizedBox(
            height: size.height * 0.001,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              "Make sure your face is in circle,while we scan your face",
              textAlign: TextAlign.center,
              style: textStyleW500(
                size.width * 0.049,
                ConstColor.blackText.withOpacity(0.6),
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  captureImage() {
    Timer(const Duration(seconds: 5), () async {
      try {
        final XFile fileClicked = await _controller.takePicture();
        setState(() {
          _imageFile = fileClicked;
        });
        final File filePicked = File(_imageFile!.path);
        inputImage = InputImage.fromFile(filePicked);
        faces = await cameraController.faceDetector.processImage(inputImage);
        try {
          if (faces.isNotEmpty) {
            print("FACE RECOGNIZE ....!");
            if (cameraController.checkIn.value != "--/--") {
              clockOut(filePicked);
            } else {
              clockIn(filePicked);
            }

            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(context,
              CupertinoPageRoute(
                builder: (context) => const EmployeeHomeScreen(),
              ),
            );
          } else {
            Get.snackbar("Error", "Face Not Recognized Properly..!",
                colorText: ConstColor.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                backgroundColor: ConstColor.red.withOpacity(0.8),
                dismissDirection: DismissDirection.horizontal,
                icon: Icon(
                  Icons.error_outline,
                  color: ConstColor.white,
                  size: 30,
                ));
            Navigator.pop(context);
          }
        } catch (e) {
          Get.snackbar(
            "Error", "$e",
            colorText: ConstColor.white,
            dismissDirection: DismissDirection.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            backgroundColor: ConstColor.red.withOpacity(0.8),
            icon: Icon(
              Icons.error_outline,
              color: ConstColor.white,
              size: 30,
            ),
          );
        }
      } catch (e) {
        print('Error initializing camera: $e');
      }
    });
  }

  Widget _buildCameraToggleButton() {
    return GestureDetector(
      onTap: toggleCamera,
      child: SizedBox(
        height: 32,
        width: 35,
        child: SvgPicture.asset(
          ConstImage.flip,
          color: Colors.black,
        ),
      ),
    );
  }

  clockIn(File filePicked) async {
    log("STARTED..");
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("Employee")
        .where('id', isEqualTo: User.employeeId)
        .get();

    DocumentSnapshot snap2 = await FirebaseFirestore.instance.collection("Employee")
        .doc(snap.docs[0].id).collection("Record")
        .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
        .get();

    log("OUTPUT == $snap");
    log("OUTPUT 2 == $snap2");
    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceImages = reference.child("checkImages");

    try {
      String checkInTime = DateFormat('hh:mm a').format(DateTime.now());

      String fileName =
          "${User.employeeId}_checkIn_${cameraController.currentDate}${DateFormat('MMMM').format(DateTime.now())}";

      Reference referenceImagesUpload = referenceImages.child(fileName);
      await referenceImagesUpload.putFile(filePicked);
      cameraController.checkInUrl.value = await referenceImagesUpload.getDownloadURL();

      await FirebaseFirestore.instance
          .collection("Employee")
          .doc(snap.docs[0].id)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .set({
        'date': Timestamp.now(),
        'checkIn': checkInTime,
        'checkInImage': cameraController.checkInUrl.value,
        'checkOut': "--/--",
        'checkOutImage': "",
      });

      log("TRY");
    } catch (e) {
      log("CHECK IN CATCH");
      log("CHECK IN CATCH  ===  $e");
    }
  }

  clockOut(File filePicked) async {
    QuerySnapshot snap = await FirebaseFirestore.instance.collection("Employee")
        .where('id', isEqualTo: User.employeeId).get();

    DocumentSnapshot snap2 = await FirebaseFirestore.instance.collection("Employee")
        .doc(snap.docs[0].id).collection("Record")
        .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
        .get();

    log("OUTPUT == $snap");
    log("OUTPUT 2 == $snap2");
    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceImages = reference.child("checkImages");

    try {
      String checkOutTime = DateFormat('hh:mm a').format(DateTime.now());

      String fileName = "${User.employeeId}_checkOut_${cameraController.currentDate}${DateFormat('MMMM').format(DateTime.now())}";

      Reference referenceImagesUpload = referenceImages.child(fileName);

      await referenceImagesUpload.putFile(filePicked);
      cameraController.checkOutUrl.value = await referenceImagesUpload.getDownloadURL();

      String checkIn = snap2['checkIn'];

      await FirebaseFirestore.instance.collection("Employee").doc(snap.docs[0].id).collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now())).update({
        'date': Timestamp.now(),
        'checkIn': checkIn,
        'checkInImage': cameraController.checkInUrl.value,
        'checkOut': checkOutTime,
        'checkOutImage': cameraController.checkOutUrl.value,
      });
    } catch (e) {
      log("CHECK OUT CATCH");
      log("CHECK OUT CATCH  ===  $e");
    }
  }
}
