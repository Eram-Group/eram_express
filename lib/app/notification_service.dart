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


/*
class NotificationService {
  late ValueChanged<Map<String, dynamic>> _onNotificationTap;
  late Completer<void> _notificationServiceCompleter; //بيعمل ايه
  final CacheService _cacheService;  
  final SupportChatService _supportChatService;

  NotificationService(
      {required CacheService cacheService,
      required SupportChatService supportChatService})
      : _supportChatService = supportChatService,
        _cacheService = cacheService;

  Future<void> init(
      ValueChanged<Map<String, dynamic>> onNotificationTap) async {
    _onNotificationTap = onNotificationTap;

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
    _resetBadgeCount();
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call initializeApp before using other Firebase services.
    try {
      debugPrint(
          "Entering Handling a background message: ${message.messageId}");
      await Firebase.initializeApp();

      final notificationService = Injector().notificationService;
      notificationService._incrementBadgeCount();

      debugPrint("Handled a background message: ${message.messageId}");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _incrementBadgeCount() async {
    int newBadgeCount = await _cacheService.getBadgeCount();
    newBadgeCount++;
    _updateBadgeCount(newBadgeCount);
  }

  void _updateBadgeCount(int count) {
    _cacheService.setBadgeCount(count);
    FlutterAppBadger.updateBadgeCount(count);
  }

  void _resetBadgeCount() async {
    await _cacheService.resetBadgeCount();
    FlutterAppBadger.removeBadge();
  }

  Future<void> _init([
    FutureCallback? onReceiveNewNotification,
  ]) async {
    await _openNotificationsPageIfAppOpenedFromTerminated();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final isFreshChatNotification =
          await _supportChatService.isSupportChatNotification(message.data);

      if (isFreshChatNotification)
        return _supportChatService.handlePushNotification(message.data);
      if (onReceiveNewNotification != null) onReceiveNewNotification();

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
        _incrementBadgeCount();
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((notification) {
      //handle when app is in the background
      _resetBadgeCount();

      _onNotificationTap(notification.data);
      if (onReceiveNewNotification != null) onReceiveNewNotification();
    });

    _resetBadgeCount();
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
      _resetBadgeCount();
      // navigateToNotificationPage(
      //     int.tryParse(notification.data['notificationId'].toString()));
    }
  }

  Future<String> getDeviceTokenId() async {
    if (Platform.isIOS || Platform.isAndroid) {
      _requestPermission();

      final messaging = FirebaseMessaging.instance;
      final token = await messaging.getToken();
      if (token != null) _supportChatService.setPushNotificationToken(token);

      if (kDebugMode) {
        print(token);
      }
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


  void markReady() => _notificationServiceCompleter.complete();
}

*/