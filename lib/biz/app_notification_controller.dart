import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:moneylover/biz/app_controller.dart';
import 'package:moneylover/services/api_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);

class AppNotificationController extends GetxService {
  // final IAppRepository _repo = Get.find();
  final IApiService apiService = Get.find();
  final countNoti = 0.obs;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<void> authenticatedLoad() async {
    _setupNotificationListeners();
    await _fetchNotiUnread();
    Future.delayed(1.seconds).then((_) {
      _checkInitMessage();
    });
  }

  // MARK: - Notifications

  Future<void> _fetchNotiUnread() async {
    try {
      // final count = await _repo.countUnreadNoti();
      // countNoti(count ?? 0);
    } catch (_) {
      countNoti(0);
    }
  }

  void _checkInitMessage() async {
    try {
      await Future.delayed(500.milliseconds);
      final remoteMess = await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMess != null) {
        _handleNotiClicked(remoteMess);
      }
    } catch (e) {
      debugPrint('get init message exception: $e, ${e?.toString()}');
    }
  }

  String _getPlatformString() {
    String platform = 'web';
    if (!GetPlatform.isWeb) {
      if (Platform.isAndroid) {
        platform = 'android';
      } else if (Platform.isIOS) {
        platform = 'ios';
      }
    }
    return platform;
  }

  void _setupNotificationListeners() async {
    if (GetPlatform.isAndroid) {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
      );
      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: onSelectNotification);
    }

    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        ?.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: false,
    );

    debugPrint('User granted permission: ${settings.authorizationStatus}');
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await messaging.getToken().then(_updateToken);
      FirebaseMessaging.onMessage.listen(_handleNoti);
      FirebaseMessaging.onMessageOpenedApp.listen(_handleNotiClicked);
      messaging.onTokenRefresh.listen(_updateToken);
    }
  }

  void _updateToken(String token) {
    debugPrint('FCM: $token');
    // _repo
    //     .setFirebaseToken(token, _getPlatformString())
    //     .then((result) => debugPrint('set fcm token result: ${result.body}'));
  }

  void _handleNotiClicked(RemoteMessage message) async {
    if (message?.data != null) {
      Get.log(jsonEncode(message.data));
      _redirectToNotiDetail(message.data);
    }
  }

  void _redirectToNotiDetail(Map<String, dynamic> data) {
    if (Get.find<AppController>().currentUser == null) {
      return;
    }
    final String id = data['_id'];
    if (id?.isNotEmpty == true) {
      final itemId = data['itemId'];

      redirectForNotification(
        notificationId: id,
        itemId: itemId,
      );
      return;
    }
  }

  void redirectForNotification({
    @required String itemId,
    @required String notificationId,
  }) {
    // switch (type) {
    //   case NotificationType.customerticketReply:
    //     Get.toNamed(Routes.TICKETING_SUPPORT_CHAT + '/$itemId');
    //     return;
    //   default:
    //     Get.toNamed('${Routes.NOTIFICATION_DETAIL}/$notificationId');
    //     return;
    // }
  }

  void _handleNoti(RemoteMessage message) {
    RemoteNotification notification = message.notification;
    if (message.data != null && message.data['type'] == 'message') {
      // newMessageCountNoti.value = (newMessageCountNoti.value ?? 0) + 1;
    }
    if (GetPlatform.isWeb) {
      // showSimpleNotification(Text(notification?.title ?? 'No title'),
      //     trailing: IconButton(
      //       onPressed: () => _handleNotiClicked(message),
      //       icon: Icon(Icons.arrow_forward),
      //     ));
    } else {
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin?.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: '@mipmap/ic_launcher',
              channelDescription: channel.description,
            ),
          ),
          payload: jsonEncode(message.data),
        );
      }
    }
  }

  void reduceReadNoti() {
    countNoti(max(countNoti.value - 1, 0));
  }

  void onSelectNotification(String payload) {
    Get.log(jsonEncode(payload));
    _redirectToNotiDetail(jsonDecode(payload));
  }
}
