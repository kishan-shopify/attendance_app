import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class CameraScreenController extends GetxController {
  final currentDate = DateTime.now().day.toString();
  String checkIn = "--/--";
  String checkOut = "--/--";
  String checkInUrl = "";
  String checkOutUrl = "";

  late final FaceDetector faceDetector;

  @override
  void onInit() {
    faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableClassification: true,
        enableContours: false,
        enableLandmarks: true,
        enableTracking: true,
        minFaceSize: 0.1,
      ),
    );
    super.onInit();
  }

// Rest of the code...
}
