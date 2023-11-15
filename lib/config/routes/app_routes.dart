import 'package:flutter/material.dart';
import 'package:new_mazoon/features/attachment/screens/attachmentscreen.dart';
import 'package:new_mazoon/features/change_lang/screen/screen_change.dart';
import 'package:new_mazoon/features/favourites/screens/favourite_screen.dart';
import 'package:new_mazoon/features/lessonExamScreen/screens/resultexamscreen.dart';
import 'package:new_mazoon/features/lessons_of_class/screens/lesson_details.dart';
import 'package:new_mazoon/features/liveexam/screen/liveexamscreen.dart';
import 'package:new_mazoon/features/navigation_bottom/screens/navigation_bottom.dart';
import 'package:new_mazoon/features/onboarding/screens/onbordingscreen.dart';
import 'package:page_transition/page_transition.dart';

import '../../core/models/ads_model.dart';
import '../../core/models/applylessonexammodel.dart';
import '../../core/models/lessons_model.dart';
import '../../core/models/paper_exam_data_model.dart';
import '../../core/models/paper_exam_details_model.dart';
import '../../core/models/videoModel.dart';
import '../../core/utils/app_strings.dart';
import '../../features/attachment/screens/rate_yourself.dart';
import '../../features/countdown/screens/countdown_screen.dart';
import '../../features/elmazoon_info/screen/elmazoon_info.dart';
import '../../features/exam_hero/screens/exam_hero_screen.dart';
import '../../features/examdegreeaccreditation/screens/mygradeandrating.dart';
import '../../features/examdegreeaccreditation/screens/ratescreen.dart';
import '../../features/examinstructions/screen/examinstructions.dart';
import '../../features/invite_friends/screen/invitefriend.dart';
import '../../features/lessonExamScreen/screens/lessonexamscreen.dart';
import '../../features/make_exam/screen/make_exam.dart';
import '../../features/make_exam/screen/resultexamscreen.dart';
import '../../features/make_exam/screen/startexam.dart';
import '../../features/notificationpage/presentation/screens/notification_page.dart';
import '../../features/notificationpage/presentation/screens/widget/notification_settings_screen.dart';
import '../../features/paperexamRegister/presentation/screens/paper_exam_register.dart';
import '../../features/lessons_of_class/screens/lesson_class.dart';
import '../../features/login/screens/login.dart';
import '../../features/monthplan/screen/monthplan.dart';
import '../../features/paperexamdetials/screens/paper_details_exam_register.dart';
import '../../features/payment/screen/select_months.dart';
import '../../features/profilescreen/screen/profilescreen.dart';
import '../../features/sources_and_references/screens/source_references_details.dart';
import '../../features/splash/presentation/screens/pop_ads_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/student_reports/screens/student_report.dart';
import '../../features/video_details/screens/video_details.dart';
import '../../features/your_suggest/screens/your_suggest.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String paperexamRegisterRoute = '/paperexamRegister';
  static const String paperdetialsexamRegisterRoute =
      '/paperdetailsexamRegister';
  static const String homePageScreenRoute = '/homePageScreen';
  static const String monthplanPageScreenRoute = '/monthplanPageScreen';
  static const String onboardingPageScreenRoute = '/onboardingPageScreen';
  static const String podAdsPageScreenRoute = '/podAdsPageScreen';
  static const String lessonClassScreenRoute = '/lessonClassPageScreen';
  static const String sourceReferencesDetailsRoute = '/sourceReferencesDetails';
  static const String examInstructionsRoute = '/examInstructions';
  static const String examHeroScreenRoute = '/examHeroScreen';
  static const String countdownScreenRoute = '/countdownScreen';
  static const String videoDetailsScreenRoute = '/videoDetailsScreen';

  static const String lessonDetails = '/lessonDetails';

  static const String attachmentScreen = '/AttachmentScreen';

  static const String lessonExamScreen = '/LessonExamScreen';

  static const String resultOfLessonExam = '/ResultExamLessonScreen';

  static const String myGradeAndRating = '/MyGradeAndRating';

  static const String rateYourSelfScreen = '/RateYourSelfScreen';
  static const String reportsScreen = '/reportsScreen';

  static const String rateYourselfDependExamResult =
      '/RateYourselfDependExamResult';

  static const String inviteFreiendsScreen = '/inviteFreiendsScreen';

  static const String profileScreen = '/profileScreen';

  static const String selectMonthPlanPayment = '/selectMonthPlanPayment';
  static const String elMazoonInfo = '/elMazoonInfo';

  static const String makeYourExamScreen = '/makeYourExamScreen';
  static const String startMakeExamScreen = '/startMakeExamScreen';

  static const String resultOfExamScreen = '/resultOfExamScreen';
  static const String changeLanguageScreen = '/changeLanguageScreen';
  static const String suggestScreen = '/AddYourSuggest';
  static const String favouriteScreen = '/favouriteScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String settingsNotificationScreen =
      '/notificationSettingsScreen';
  static const String liveExamScreen = '/LiveExamScreen';
}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case Routes.reportsScreen:
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
          child: StudentReportScreen(),
        );

      case Routes.lessonClassScreenRoute:
        int classId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => LessonsClassScreen(classId: classId),
        );
      case Routes.examInstructionsRoute:
        List<dynamic> data = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
          builder: (context) =>
              ExamInstructions(exam_id: data[0], type: data[1]),
        );
      case Routes.paperexamRegisterRoute:
        PaperExamDetialsModel timeDataModel =
            settings.arguments as PaperExamDetialsModel;
        return MaterialPageRoute(
          builder: (context) =>
              PaperExmRegisterPage(timeDataModel: timeDataModel),
        );
      case Routes.paperdetialsexamRegisterRoute:
        PaperExam paperExamModel = settings.arguments as PaperExam;
        return MaterialPageRoute(
          builder: (context) =>
              PaperDetailsExmRegisterPage(paperExamModel: paperExamModel),
        );
      case Routes.monthplanPageScreenRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
          child: MonthPlan(),
        );
      case Routes.homePageScreenRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
          child: Zoom(),
        );
      case Routes.onboardingPageScreenRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
          child: OnBordingScreen(),
        );

      case Routes.sourceReferencesDetailsRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
          child: SourceReferencesDetails(),
        );

      case Routes.podAdsPageScreenRoute:
        AdsModelDatum adsModelDatum = settings.arguments as AdsModelDatum;
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
          child: PopAdsScreen(
            adsDatum: adsModelDatum,
          ),
        );

      case Routes.examHeroScreenRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
          child: ExamHeroScreen(),
        );

      case Routes.countdownScreenRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
          child: CountdownScreen(),
        );
      case Routes.lessonDetails:
        AllLessonsModel model = settings.arguments as AllLessonsModel;
        return PageTransition(
          child: LessonDetails(model: model),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
        );
      case Routes.videoDetailsScreenRoute:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
          child: VideoDetails(type: data['type'], videoId: data['videoId']),
        );
      case Routes.attachmentScreen:
        VideoModel model = settings.arguments as VideoModel;
        return PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
          child: AttachmentScreen(model: model),
        );
      case Routes.lessonExamScreen:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;

        return PageTransition(
          child: LessonExamScreen(
              exam_type: data['exam_type'], lessonId: data['lessonId']),
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
          type: PageTransitionType.fade,
        );
      case Routes.resultOfLessonExam:
        ResponseOfApplyLessonExmamData model =
            settings.arguments as ResponseOfApplyLessonExmamData;

        return PageTransition(
          child: ResultExamLessonScreen(model: model),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );

      case Routes.myGradeAndRating:
        // ResponseOfApplyLessonExmamData model =
        //     settings.arguments as ResponseOfApplyLessonExmamData;

        return PageTransition(
          child: MyGradeAndRating(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      //RateYourSelfScreen
      case Routes.rateYourSelfScreen:
        // ResponseOfApplyLessonExmamData model =
        //     settings.arguments as ResponseOfApplyLessonExmamData;

        return PageTransition(
          child: RateYourSelfScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      //RateYourselfDependExamResult
      case Routes.rateYourselfDependExamResult:
        return PageTransition(
          child: RateYourselfDependExamResult(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      //ProfileScreen
      case Routes.inviteFreiendsScreen:
        return PageTransition(
          child: InviteFreiendsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.profileScreen:
        return PageTransition(
          child: ProfileScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      //SelectMonthPlanPayment
      case Routes.selectMonthPlanPayment:
        return PageTransition(
          child: SelectMonthPlanPayment(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.elMazoonInfo:
        return PageTransition(
          child: ElMazoonInfo(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.makeYourExamScreen:
        return PageTransition(
          child: MakeYourExamScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.startMakeExamScreen:
        return PageTransition(
          child: StartMakeExamScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      //changeLanguageScreen
      case Routes.resultOfExamScreen:
        return PageTransition(
          child: ResultOfExamScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.changeLanguageScreen:
        return PageTransition(
          child: ChangeLanguageScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.suggestScreen:
        return PageTransition(
          child: AddYourSuggest(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.favouriteScreen:
        return PageTransition(
          child: FavouriteScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.notificationScreen:
        return PageTransition(
          child: NotificationScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      case Routes.settingsNotificationScreen:
        return PageTransition(
          child: NotificationSettingsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      //suggestScreen
      case Routes.liveExamScreen:
        return PageTransition(
          child: LiveExamScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 800),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
