import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  late ValueChanged<Map<String, dynamic>> _onNotificationTap;

  late Completer<void>
      _notificationServiceCompleter; //What is this function for?

  NotificationService();

  Future<void> init() async {
    //ValueChanged<Map<String, dynamic>> onNotificationTap) async {
    //_onNotificationTap = onNotificationTap;

    _notificationServiceCompleter = Completer<void>();
    await _FlutterLocalNotificationHelper.init(
        onNotificationTab: (payload) => _onNotificationTap(payload));

    await _init();

    try {
      await getDeviceTokenId();
      await cancelAll();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  @pragma('vm:entry-point')
  Future<void> _init(
      /*
    [
    FutureCallback? onReceiveNewNotification,
  ]
  */
      ) async {
    await _openNotificationsPageIfAppOpenedFromTerminated();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      //if (onReceiveNewNotification != null) onReceiveNewNotification();
      logger.debug("run notification in foreground");
      final notification = message.notification;
      final image = message.data['image'] ??
          notification?.android?.imageUrl ??
          notification?.apple?.imageUrl;

      if (notification != null) {
        _FlutterLocalNotificationHelper.showFCMNotification(
          title: notification.title,
          body: notification.body,
          image: image,
          payload: message.data,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((notification) {
      logger.debug("run notification in background");

      _onNotificationTap(notification.data);
      //  if (onReceiveNewNotification != null) onReceiveNewNotification();
    });
  }

  Future<void> _openNotificationsPageIfAppOpenedFromTerminated() async {
    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await Future.delayed(const Duration(
        milliseconds: 500,
      ));
      _notificationServiceCompleter.future.then(
        (_) => _onNotificationTap(
          notification.data,
        ),
      );

      // navigateToNotificationPage(
      //     int.tryParse(notification.data['notificationId'].toString()));
    }
  }

  Future<String> getDeviceTokenId() async {
    if (Platform.isIOS || Platform.isAndroid) {
      _requestPermission();
      final messaging = FirebaseMessaging.instance;
      final token = await messaging.getToken();
      logger.debug(token!);
      return token!;
    } else
      throw Exception('Not supported platform');
  }

  Future<void> _requestPermission() async {
    final notificationSettings =
        await FirebaseMessaging.instance.requestPermission();

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.denied) {
      log('User denied permission');
    }
  }

  Future<void> cancelAll() => _FlutterLocalNotificationHelper.cancelAll();

/*
  Future<void> subscribeToTopic(NotificationsTopic notificationTopic) async {
    log("subscribe ${notificationTopic.name}");
    await FirebaseMessaging.instance.subscribeToTopic(notificationTopic.name);
  }

  Future<void> unsubscribeToTopic(NotificationsTopic notificationTopic) async {
    log("unsubscribe ${notificationTopic.name}");

    await FirebaseMessaging.instance
        .unsubscribeFromTopic(notificationTopic.name);
  }

  Future<void> unsubscribeAll() async {
    log("unsubscribe from all");

    for (final topic in NotificationsTopic.values) {
      await FirebaseMessaging.instance.unsubscribeFromTopic(topic.name);
    }
  }

  Future<void> subscribeToList(List<NotificationsTopic> topics) async {
    if (topics.isEmpty) return;
    for (final topic in topics) {
      await FirebaseMessaging.instance.subscribeToTopic(topic.name);
      log("subscribe ${topic.name}");
    }
  }
*/
  void markReady() => _notificationServiceCompleter.complete();
}

class _FlutterLocalNotificationHelper {
  static const channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );

  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  static Future<void> init({
    required void Function(Map<String, dynamic>) onNotificationTab,
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
      //handle navigating in foreground state
      onDidReceiveNotificationResponse: (details) {
        if (details.payload == null) return;
        final payloadDecoded = json.decode(details.payload!);
        onNotificationTab(payloadDecoded);
      },
    );
  }

  static Future<void> showFCMNotification({
    String? title,
    String? body,
    Map<String, dynamic>? payload,
    required String? image,
  }) async {
    // final imagePath = image == null ? null : await _downloadAndSaveFile(image);

    return flutterLocalNotificationsPlugin!.show(
      const _NotificationIdGenerator().generate(),
      title,
      body,
      NotificationDetails(
        iOS: null,
        /* imagePath == null
            ? null
            : DarwinNotificationDetails(
                attachments: [DarwinNotificationAttachment(imagePath)]),
                */
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          priority: Priority.max,
          importance: Importance.max,
          icon: '@mipmap/ic_launcher',
          largeIcon: null,
          //imagePath == null ? null : FilePathAndroidBitmap(imagePath),
        ),
      ),
      payload: payload == null ? null : json.encode(payload),
    );
  }

  static Future<void> cancelAll() async =>
      flutterLocalNotificationsPlugin?.cancelAll();

/*
  static Future<String> _downloadAndSaveFile(String url) async {
    final UrlHelper urlHelper = UrlHelper();
    final fileName = urlHelper.getFileName(url);
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final Response response = await Dio().get(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    final File file = File(filePath);
    await file.writeAsBytes(response.data as List<int>);
    return filePath;
  }

*/
}

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

class _NotificationIdGenerator {
  const _NotificationIdGenerator();

  static final random = math.Random();

  int generate() => random.nextInt(math.pow(2, 31).toInt() - 1);
}
