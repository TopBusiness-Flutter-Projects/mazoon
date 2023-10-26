import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:new_mazoon/features/attachment/cubit/attachmentcubit.dart';
import 'package:new_mazoon/features/elmazoon_info/cubit/cubit.dart';
import 'package:new_mazoon/features/make_exam/cubit/cubit.dart';
import 'package:new_mazoon/features/monthplan/cubit/month_cubit.dart';
import 'package:new_mazoon/features/profilescreen/cubit/state.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:screenshot_callback/screenshot_callback.dart';
// import 'package:screenshot_callback/screenshot_callback.dart';

import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';
import 'core/preferences/preferences.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/app_strings.dart';
import 'package:new_mazoon/injector.dart' as injector;
import 'dart:developer' as developer;
import 'package:path/path.dart';

import 'core/utils/toast_message_method.dart';
// import 'features/downloads_videos/cubit/downloads_videos_cubit.dart';
import 'features/change_lang/cubit/lang_cubit.dart';
import 'features/countdown/cubit/countdown_cubit.dart';
import 'features/downloads/cubit/downloadscubit.dart';
import 'features/exam_hero/cubit/exam_hero_cubit.dart';
import 'features/examdegreeaccreditation/cubit/examdegreedependcubit.dart';
import 'features/examinstructions/cubit/examinstructions_cubit.dart';
import 'features/favourites/cubit/favourite_cubit.dart';
import 'features/invite_friends/cubit/cubit.dart';
import 'features/lessonExamScreen/cubit/questionlessonexamcubit.dart';
import 'features/notes/cubit/note_cubit.dart';
import 'features/notificationpage/cubit/notification_cubit.dart';
import 'features/paperexamRegister/cubit/paper_exam_register_cubit.dart';
import 'features/homePage/cubit/home_page_cubit.dart';
import 'features/lessons_of_class/cubit/lessons_class_cubit.dart';
import 'features/login/cubit/login_cubit.dart';
import 'features/navigation_bottom/cubit/navigation_cubit.dart';
import 'features/onboarding/cubit/on_boarding_cubit.dart';
import 'features/payment/cubit/paymentcubit.dart';
import 'features/profilescreen/cubit/cubit.dart';
import 'features/rate_app/cubit/rate_app_cubit.dart';
import 'features/sources_and_references/cubit/source_references_cubit.dart';
import 'features/paperexamdetials/cubit/paper_detials_cubit.dart';
import 'features/splash/presentation/cubit/splash_cubit.dart';
import 'features/start_trip/cubit/start_trip_cubit.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'features/student_reports/cubit/student_reports_cubit.dart';
import 'features/video_details/cubit/video_details_cubit.dart';
import 'features/your_suggest/cubit/your_suggest_cubit.dart';

class Elmazoon extends StatefulWidget {
  const Elmazoon({Key? key}) : super(key: key);

  @override
  State<Elmazoon> createState() => _ElmazoonState();
}

class _ElmazoonState extends State<Elmazoon> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isThemes = false;
  String shortcut = 'no action set';
  ScreenshotCallback screenshotCallback = ScreenshotCallback();
  @override
  void initState() {
    super.initState();
    // screenshotCallback.addListener(() {
    //   BlocProvider.of<HomePageCubit>(context as BuildContext).userScreenshot();
    // });
    FlutterNativeSplash.remove();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      if (event.index == 4) {
        toastMessage(
          'no_internet_connection'.tr(),
          context,
          color: AppColors.error,
        );
      } else if (event == 1 || event == 3) {
        toastMessage(
          'internet_connection'.tr(),
          context,
          color: AppColors.success,
        );
      }
      _updateConnectionStatus(event);
    });

    const QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      setState(() {
        if (shortcutType != null) {
          shortcut = shortcutType;
        }
      });
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      // NOTE: This first action icon will only work on iOS.
      // In a real world project keep the same file name for both platforms.
      const ShortcutItem(
        type: 'Clear Cache',
        localizedTitle: 'Action one',
        icon: 'AppIcon',
      ),
      // NOTE: This second action icon will only work on Android.
      // In a real world project keep the same file name for both platforms.
      const ShortcutItem(
        type: 'action_two',
        localizedTitle: 'Action two',
        icon: 'ic_launcher',
      ),
    ]).then((void _) {
      setState(() {
        if (shortcut == 'no action set') {
          // Preferences.instance.clearAllData();
          //
          // shortcut = 'actions ready';
        }
      });
    });
    // Handle incoming message when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');

        // You can show a local notification or update your app UI here
      }
    });
  }

  @override
  void dispose() {
    screenshotCallback.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(text);

    Preferences.instance.savedLang(
      EasyLocalization.of(context)!.locale.languageCode,
    );

    ProfileCubit.getSavedMode().then((value) {
      ProfileCubit.mode = value;
    });
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => injector.serviceLocator<SplashCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<LoginCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<NavigationCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<HomePageCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<OnBoardingCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<StartTripCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<NoteCubit>(),
        ),

        // BlocProvider(
        //   create: (_) => injector.serviceLocator<DownloadsVideosCubit>(),
        // ),
        BlocProvider(
          create: (_) => injector.serviceLocator<LessonsClassCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<MonthPlanCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<PaperExamRegisterCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<PaperDetialsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ExaminstructionsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<SourceReferencesCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ExamHeroCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<CountdownCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<VideoDetailsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<AttachmentCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<QuestionsLessonExamCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<ExamDegreeAccreditationCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<StudentReportsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<IniviteFreiendsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ProfileCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<PaymentCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ElMazoonCubit>(),
        ),

        BlocProvider(
          create: (_) => injector.serviceLocator<MakeYourExamCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ChangeLangCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<DownloadedFilesCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<YourSuggestCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<RateAppCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<FavouriteCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<NotificationCubit>(),
        ),
        //    BlocProvider(
        //   create: (_) => injector.serviceLocator<RateAppCubit>(),
        // ),
      ],
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return GetMaterialApp(
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ProfileCubit.mode ? appDarkTheme() : appTheme(),
            localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      ),
    );
  }
}
