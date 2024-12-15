import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async 
  {
     _requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      logger.debug(message.notification!.title!);
      final notification = message.notification;
      if (notification != null) {
       await  _FlutterLocalNotificationHelper.init();
        _FlutterLocalNotificationHelper.showFCMNotification(
          title: notification.title,
          body: notification.body,
          image: null,
          payload: message.data,
        );

        // _incrementBadgeCount();
      }
    });
  }
  Future<void> _requestPermission() async {
    final notificationSettings =
        await FirebaseMessaging.instance.requestPermission();

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.denied) {
      log('User denied permission');
    }
  }
  }



class _FlutterLocalNotificationHelper {
  static const channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );

  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  static Future<void> init({
    // required void Function(Map<String, dynamic>) onNotificationTab,
    void Function(Map<String, dynamic>)? onNotificationTab,
  }) async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    if (Platform.isAndroid)
      flutterLocalNotificationsPlugin!
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestNotificationsPermission();

    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    flutterLocalNotificationsPlugin!.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      //handle navigating in foreground state  يعني بتعمل ايه
      onDidReceiveNotificationResponse: (details) {
        if (details.payload == null) return;
        final payloadDecoded = json.decode(details.payload!);
        //onNotificationTab(payloadDecoded);
      },
    );
  }

  static Future<void> showFCMNotification({
    String? title,
    String? body,
    Map<String, dynamic>? payload,
    required String? image,
  }) async {
    //final imagePath = image == null ? null : await _downloadAndSaveFile(image);

    return flutterLocalNotificationsPlugin!.show(
      const _NotificationIdGenerator().generate(),
      title,
      body,
      NotificationDetails(
        iOS: image == null
            ? null
            : DarwinNotificationDetails(
                attachments: [DarwinNotificationAttachment(image)]),
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          priority: Priority.max,
          importance: Importance.max,
          icon: '@mipmap/ic_launcher',
          largeIcon: image == null ? null : FilePathAndroidBitmap(image),
        ),
      ),
      payload: payload == null ? null : json.encode(payload),
    );
  }

  static Future<void> cancelAll() async =>
      flutterLocalNotificationsPlugin?.cancelAll();

  Future<void> navigateToNotificationPage([int? notificationId]) async {
    if (notificationId == null) return Future.value();
    // return navigatorKey.currentState!.push(
    //   MaterialPageRoute(
    //     builder: (context) =>
    //         NotificationDetailsView(notificationId: notificationId),
    //     settings: const RouteSettings(name: NotificationDetailsView.routeName),
    //   ),
    // );
  }
}

class _NotificationIdGenerator {
  const _NotificationIdGenerator();

  static final random = math.Random();

  int generate() => random.nextInt(math.pow(2, 31).toInt() - 1);
}
