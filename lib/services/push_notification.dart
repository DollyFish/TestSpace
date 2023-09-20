import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:testing/firebase_options.dart';
import 'package:testing/services/show_notification.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint("Handling a background message: ${message.messageId}");
  await setupFlutterNotifications();
  showFlutterNotification(message);
}

class PushNotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future initialise() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint('User granted permission: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        analytics.logEvent(
            name: 'notification_received',
            parameters: <String, dynamic>{
              'title': message.notification!.title,
              'body': message.notification!.body
            });
        if (message.notification != null) {
          debugPrint('notification title: ${message.notification!.title}');
          debugPrint('notification body: ${message.notification!.body}');
          showFlutterNotification(message);
        }
      });
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  Future<void> setupInteractedMessage(context) async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('message; $message');
      if (message.notification != null) {
        debugPrint('noti title: ${message.notification!.title}');
        debugPrint('noti body: ${message.notification!.body}');
      }
    });
  }
}
