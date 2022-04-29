import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_flutter/screens/NotifyScreen.dart';

import 'Routes/RoutesUtils.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late NotificationSettings _settings;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  RemoteMessage? globalRemote;
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'Task Flutter',
    // id //The Same id should pass in the AndroidManifest.xml MetaData android.value
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    playSound: true,
    showBadge: true,
    // description
    importance: Importance.max,
  );

  void initializeNotification(BuildContext context) async {
    AndroidFlutterLocalNotificationsPlugin? localAndroidFlutterNotifications =
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
//to do pushNamed....
    await localAndroidFlutterNotifications
        ?.initialize(const AndroidInitializationSettings("dart_icon"),
        onSelectNotification: (String? value) {
          RoutesUtils.navToNotify(context);



        });

    await localAndroidFlutterNotifications?.createNotificationChannel(channel);

    //Method to Request Notification
    await requestNotification(context);
  }

  Future<void> requestNotification(BuildContext context) async {
    _settings = await _firebaseMessaging.requestPermission();
    if (_settings.authorizationStatus == AuthorizationStatus.authorized) {
      await _onMessage(context);
      await _onMessageOpenedApp(context);
    }
  }

  /// app isn't in open state && foreground state
  Future<void> _onMessage(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      globalRemote = message;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    importance: channel.importance,
                    channelDescription: channel.description,
                    icon:
                    "dart_icon") //The Same icon name should pass in the AndroidManifest.xml MetaData android.resource,
            ));
      }
    });
  }

  /// while the app is in background in opened state and user taps...
  Future<void> _onMessageOpenedApp(BuildContext context) async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      AndroidNotification? android = message.notification?.android;
      if (message.notification != null && android != null) {
        final routeFromMessage = message.data['route'];
        RoutesUtils.navToNotify(context);

      }
    });
  }
}
