import 'package:firebase_messaging/firebase_messaging.dart';

import '../utils/basic_screen_imports.dart';
import 'notification_model.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message ${message.messageId}');
  NotificationModel data = NotificationModel(
      title: message.notification!.title!,
      body: message.notification!.body!
  );

  debugPrint(data.toJson().toString());

  debugPrint('-----------Handling a background message ${message.messageId}----------------');
  debugPrint('-----------Handling a background message ${message.toString()}----------------');
  debugPrint('-----------Handling a background message $data}----------------');
  debugPrint('-----------Handling a background message ${message.notification!.title}----------------');
  debugPrint('-----------Handling a background message ${message.notification!.body}----------------');
}


class NotificationHelper{

  static requestPermission() async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('-----------Permission granted:n ');

    }
    else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint(
          '-------------------User granted provisional permission: ${settings.authorizationStatus}');
    }
    else {
      debugPrint(
          '-------------User declined or has not accepted permission: ${settings.authorizationStatus}');
    }
  }

  static initialization()async{
    await FirebaseMessaging.instance
        .getInitialMessage();
  }

  // init info
  static localNotification( ) async{

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {

      // NotificationService.showLocalNotification(
      //   title: message.notification?.title ?? "",
      //   body: message.notification?.body ?? "",
      // );

      Get.defaultDialog(
          title: message.notification?.title ?? "",
          content: Text(message.notification?.body ?? "")
      );

    });
  }

  static getBackgroundNotification(){
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}