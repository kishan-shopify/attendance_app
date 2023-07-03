import 'dart:developer';

import 'package:attendance_app/modal/firebase_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'view/screen/splash_screen.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FireBaseApi().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Janovis",
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      home: const SplashScreen(),
    );
  }
}

const double officeLatitude = 23.027021;
const double officeLongitude = 72.5063857;
bool isInLocation = false;

Future<void> checkDistanceFromOffice() async {
  // Request permission to access the device's location
  LocationPermission permission = await Geolocator.requestPermission();

  if (permission == LocationPermission.denied) {
    // Handle the case when the user denies the location permission
    print('Location permission denied');
    return;
  }

  // Get the current position of the device
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

  log("LATITUDE = ${position.latitude}");
  log("longitude = ${position.longitude}");
  log("FLOOR = ${position.floor}");

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
    isInLocation = true;
  } else {
    isInLocation = false;
  }
}