// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:attendance_app/view/screen/employee/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../../../modal/const/const_color.dart';
import '../../../modal/custom/back_button.dart';
import '../../../modal/custom/gradient_button.dart';

class CameraScreen extends StatefulWidget {
  final CameraController controller;

  const CameraScreen(this.controller, {super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  var inputImage;
  var faces;
  XFile? _imageFile;
  String checkIn = "--/--";
  String checkOut = "--/--";

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
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: size.width,
                height: size.height,
                child: CameraPreview(widget.controller),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top + 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomBackButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      iconColor: ConstColor.white,
                    ),
                  ],
                ),
                Expanded(
                  child: Container(),
                ),
                GradientButton(
                  btnLabel: "Capture",
                  onTap: () async {
                    final XFile fileClicked = await widget.controller.takePicture();
                    setState(() {
                      _imageFile = fileClicked;
                    });
                    final File filePicked = File(_imageFile!.path);
                    inputImage = InputImage.fromFile(filePicked);
                    faces = await faceDetector.processImage(inputImage);
                    try {
                      if (faces.isNotEmpty) {
                        print("FACE RECOGNIZE ....!");


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
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom + 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
