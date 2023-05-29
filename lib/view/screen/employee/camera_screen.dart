import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../../../modal/const/const_color.dart';
import '../../../modal/const/const_image.dart';
import '../../../modal/custom/gradient_button.dart';

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
                    Image.asset(
                      ConstImage.arrowBack,
                      height: 30,
                      width: 30,
                      color: ConstColor.white,
                    ),
                  ],
                ),
                Expanded(
                  child: Container(),
                ),
                GradientButton(
                  btnLabel: "Capture",
                  onTap: () {},
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
