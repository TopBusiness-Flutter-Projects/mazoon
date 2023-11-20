// import 'dart:async';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get_it/get_it.dart';
// import 'package:rxdart/rxdart.dart';
// // import '../../firebase_options.dart';
// import 'notification_listen.dart';

// class PushNotificationService {
//   static final PushNotificationService instance =
//       PushNotificationService._internal();

//   PushNotificationService._internal();

//   factory PushNotificationService() => instance;

//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   final locator = GetIt.instance;
//   late AndroidNotificationChannel channel;

//   final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

//   RemoteMessage? initialMessage;

//   Future initialise() async {
//     initialMessage = await FirebaseMessaging.instance.getInitialMessage();
//     channel = const AndroidNotificationChannel(
//         'high_importance_channel', // id
//         'High Importance Notifications', // title
//         importance: Importance.high,
//         playSound: true,
//         enableVibration: true);

//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//       onDidReceiveLocalNotification: await onDidNotification,
//     );
//     final LinuxInitializationSettings initializationSettingsLinux =
//         LinuxInitializationSettings(defaultActionName: 'Open notification');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//       linux: initializationSettingsLinux,
//     );

//     flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: notificationTapBackground,
//     );

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//     NotificationSettings settings = await _fcm.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//     FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true, // Required to display a heads up notification
//       badge: true,
//       sound: true,
//     );
//     print('User granted permission: ${settings.authorizationStatus}');

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Got a message whilst in the foreground!');
//       print('Message data: ${message.data}');
//       checkData(message);
//       //showNotification(message);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       print('Got a message whilstt in the foreground!');
//       print('Message data: ${message.data}');

//       checkData(message);
//     });
//     // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//   }

//   Future<void> showNotification(RemoteMessage message) async {
//     flutterLocalNotificationsPlugin.show(
//       message.data.hashCode,
//       message.data['title'],
//       message.data['body'],
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channelDescription: channel.description,
//           importance: Importance.max,
//           icon: '@mipmap/ic_launcher',
//         ),
//       ),
//     );
//   }

//   void checkData(RemoteMessage message) {
//     var notification = LocalNotification("data", message.data);
//     NotificationsBloc.instance.newNotification(notification);
//     showNotification(message);
//   }

//   Future notificationTapBackground(NotificationResponse details) async {
//     // print('notification payload: ${details.payload}');
//     // if (details.payload!.contains("chat")) {
//     //   chatModel = ChatModel.fromJson(jsonDecode(
//     //       details.payload!.replaceAll("chat", "").replaceAll("room", "")));
//     //
//     //   behaviorchat.add(chatModel!);
//     //   behaviorSubject.add("chat");
//     //   // streamController.add("chat");
//     // }
//   }

//   Future onDidNotification(
//       int id, String? title, String? body, String? payload) async {
//     print("object");
//     print('notification payload: ${payload}');
//     // if (payload!.contains("chat")) {
//     //   chatModel = ChatModel.fromJson(
//     //       jsonDecode(payload!.replaceAll("chat", "").replaceAll("room", "")));
//     //
//     //   behaviorchat.add(chatModel!);
//     //   behaviorSubject.add("chat");
//     //   // streamController.add("chat");
//     // }
//     //   streamControllerstreamController.add("chat");
//     // behaviorchat.add(chatModel!);
//     // behaviorSubject.add(payload!);
//   }
// }
