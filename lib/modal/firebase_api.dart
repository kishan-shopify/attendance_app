import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  log("message received! ${message.notification!.title}");
}


class FireBaseApi{
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    }
    log("TOKEN  ===  $fcmToken");
  }
}