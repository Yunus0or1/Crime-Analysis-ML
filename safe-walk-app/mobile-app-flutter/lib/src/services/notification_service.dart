import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:safe_walk_mobile/src/configs/server_config.dart';
import 'package:safe_walk_mobile/src/models/general/server_config_data.dart';
import 'package:safe_walk_mobile/src/store/store.dart';
import 'package:safe_walk_mobile/src/util/util.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'safe_walk', // id
    'Safe Walk', // title
    description:
        'This channel is used for Safe Walk notifications.', // description
    importance: Importance.max,
    enableVibration: true,
    playSound: true,
    showBadge: true,
    enableLights: true,
    ledColor: Colors.blue);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('onBackgroundMessage Execution');
  // Do not navigate route from here.
}

Future<void> firebaseCloudMessagingListeners() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  try {
    if (Platform.isIOS) iOSPermission();

    FirebaseMessaging.instance.getToken().then((token) async {
      print("Firebase Token Created");
      await Store.instance!.setFirebasePushNotificationToken(token);
    });

    FirebaseMessaging.instance.subscribeToTopic("safe-walk-service");
    if (Platform.isAndroid)
      FirebaseMessaging.instance.subscribeToTopic("safe-walk-service-android");
    if (Platform.isIOS)
      FirebaseMessaging.instance.subscribeToTopic("safe-walk-service-ios");

    if (ServerConfig.environmentMode == "dev")
      FirebaseMessaging.instance.subscribeToTopic("safe-walk-service-dev");

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      // On click to start the app from beginning, this is executed.
      if (message != null) {
        print('getInitialMessage Execution');
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('onMessage Execution');
      // On foreground app, this is executed.
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    icon: 'icon_push',
                    color: Util.colorFromHex('#473fa8')),
                iOS: IOSNotificationDetails(
                  presentAlert: true,
                  presentBadge: true,
                  presentSound: true,
                )));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      // On click the push message this is executed.
      print('onMessageOpenedApp Execution');
    });
  } catch (error) {
    print("ERROR in FCM Service");
    print(error);
  }
}

void iOSPermission() {
  FirebaseMessaging.instance.requestPermission();
}
