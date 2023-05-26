import 'package:attendance_app/modal/const/const_color.dart';
import 'package:attendance_app/modal/custom/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  final CameraController controller;

  const CameraScreen(this.controller, {super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: size.width,
            height: size.height,
            child: CameraPreview(widget.controller),
            // child: Camera()
          );
        },
      ),
    );
  }
}
