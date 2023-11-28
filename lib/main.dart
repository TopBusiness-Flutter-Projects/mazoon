import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/config/routes/app_routes.dart';
import 'package:new_mazoon/core/preferences/preferences.dart';
import 'package:new_mazoon/injector.dart' as injector;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:upgrader/upgrader.dart';
// import 'package:screenshot_callback/screenshot_callback.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'app.dart';
import 'app_bloc_observer.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/restart_app_class.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'firebase_options.dart';
import 'package:showcaseview/showcaseview.dart';

///Cloud messaging step 1
FirebaseMessaging messaging = FirebaseMessaging.instance;

///Cloud messaging step 1
final navigatorKey = GlobalKey<NavigatorState>();
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
  await getNotiStatus();
  print('+++++++++++++++++++++++++++++++');

  ///Cloud messaging step 2

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
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

  ///Cloud messaging step 2
  ////--------------------------------------------------------------
  //Cloud messaging step 3
  getToken();
  //Cloud messaging step 3
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
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // await pushNotificationService!.initialise();
  await injector.setup();
  Bloc.observer = AppBlocObserver();
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

///Cloud messaging step 3
///token used for identify user in databse
getToken() async {
  String? token = await messaging.getToken();
  print("token =  $token");
  return token;
}

///Cloud messaging step 3
///Cloud messaging step 5

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await getNotiStatus();
  print("Handling a background message: ${message.messageId}");
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
            icon: '@drawable/ic_launcher',
            playSound: Preferences.instance.notiSound,
            enableLights: Preferences.instance.notiLight,
            enableVibration: Preferences.instance.notiVisbrate),
      ),
    );
    navigatorKey.currentState?.pushNamed(Routes.homePageScreenRoute);
  }

  ///show notification
}

///Cloud messaging step 5

final locator = GetIt.instance;

AndroidNotificationChannel channel = AndroidNotificationChannel(
  Preferences.instance.notiSound
      ? Preferences.instance.notiVisbrate
          ? Preferences.instance.notiLight
              ? 'high notiVisbrate'
              : 'high notiLight'
          : 'high notiSound'
      : "high notielse", // id
  Preferences.instance.notiSound
      ? Preferences.instance.notiVisbrate
          ? Preferences.instance.notiLight
              ? 'high_notiVisbrateTitle'
              : 'high_notiLightTitle'
          : 'high_notiSoundTitle'
      : "high_importance_channel_elm3", // title
  description: "this notification elmazon1",
  importance: Importance.high,
  enableVibration: Preferences.instance.notiVisbrate,
  playSound: Preferences.instance.notiSound,
  enableLights: Preferences.instance.notiLight,
);
getNotiStatus() async {
  await Preferences.instance.getNotiLights().then((value) {
    Preferences.instance.notiLight = value!;
  });
  await Preferences.instance.getNotiSound().then((value) {
    Preferences.instance.notiSound = value!;
  });
  await Preferences.instance.getNotiVibrate().then((value) {
    Preferences.instance.notiVisbrate = value!;
  });

  print('+++++++++++++++++++++++++++++++');
  print(
      '++sound = ${Preferences.instance.notiSound}+++++/n++ visbrate = ${Preferences.instance.notiVisbrate}++++++++++++++++++++');

  print('+++++++++++++++++++++++++++++++');
}
