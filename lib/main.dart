import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/injector.dart' as injector;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:screenshot_callback/screenshot_callback.dart';
import 'package:upgrader/upgrader.dart';
import 'dart:async';
import 'app.dart';
import 'app_bloc_observer.dart';
import 'core/models/user_model.dart';
import 'core/notification/notification.dart';
import 'core/preferences/preferences.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/restart_app_class.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'features/homePage/cubit/home_page_cubit.dart';
import 'firebase_options.dart';
import 'package:showcaseview/showcaseview.dart';

//ahmed elsapagh
//NEW COMMIT
//ahmed form home
//make exam
//TODO HWB=> step 4)a
FirebaseMessaging messaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationDetails notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(channel.id, channel.name,
        channelDescription: channel.description,
        importance: Importance.max,
        icon: '@mipmap/ic_launcher'));
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //TODO HWB=> step 4)b
  NotificationSettings settings =
      await messaging.requestPermission(alert: true, badge: true, sound: true);
  print("settings of permission : ${settings.authorizationStatus}");
  //TODO HWB=> step 5)
  getToken();
  // await PushNotificationService.instance.initialise();
  if (Platform.isAndroid) {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE)
        .then((value) {
      print('************************************************');
      print(value);
      print('************************************************');
    });
  }
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  AppColors.getPrimaryColor();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  // await pushNotificationService!.initialise();
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  await injector.setup();
  Bloc.observer = AppBlocObserver();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
////////////DeviceOrientation Landscape
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    ShowCaseWidget(
      builder: Builder(builder: (context) {
        return EasyLocalization(
          supportedLocales: [Locale('ar', ''), Locale('en', '')],
          path: 'assets/lang',
          saveLocale: true,
          startLocale: Locale('ar', ''),
          fallbackLocale: Locale('ar', ''),
          child: UpgradeAlert(
              child: HotRestartController(child: const Elmazoon())),
        );
      }),
    ),
  );
}

void getToken() async {
  String? token = await messaging.getToken();
  print("token =  $token");
}

PushNotificationService? pushNotificationService = PushNotificationService();

final locator = GetIt.instance;

late AndroidNotificationChannel channel;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Handling a background message:");
  AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          onDidReceiveLocalNotification: await ondidnotification);
  final LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'Open notification');
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: notificationTapBackground,
  );

  if (message.data.isNotEmpty) {
    checkData(message);

    print("Handling a background message: ${message.data}");
  }
}

void showNotification(RemoteMessage message) async {
  String paylod = "";
  if (message.data["note_type"] == "chat") {
    paylod = message.data['room'] + message.data['note_type'];
  } else {
    message.data['note_type'];
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
  );
  UserModel userModel = await Preferences.instance.getUserModel();

  await flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      payload: paylod,
      notificationDetails);
}

void checkData(RemoteMessage message) {
  if (message.data['note_type'].toString().contains("chat")) {
    showNotification(message);
  } else {
    showNotification(message);
  }
}

Future ondidnotification(
    int id, String? title, String? body, String? payload) async {
  print("object");
  if (payload!.contains("chat")) {
  } else if (payload == "service_request") {}
}

Future notificationTapBackground(NotificationResponse details) async {
  print('notification payload: ${details.payload}');
  if (details.payload!.contains("chat")) {}
}

Future onNotification(String payload) async {
  print(payload);
  if (payload.contains("chat")) {}
}

void _runWhileAppIsTerminated() async {
  await flutterLocalNotificationsPlugin
      .getNotificationAppLaunchDetails()
      .then((value) => {
            if (value != null &&
                value.notificationResponse != null &&
                value.notificationResponse!.payload!.isNotEmpty)
              {}
          });
}
