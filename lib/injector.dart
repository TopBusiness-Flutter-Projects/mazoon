import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:new_mazoon/features/monthplan/cubit/month_cubit.dart';
import 'package:new_mazoon/features/paperexamdetials/screens/paper_details_exam_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/app_interceptors.dart';
import 'core/api/base_api_consumer.dart';
import 'core/api/dio_consumer.dart';
import 'core/remote/service.dart';

// import 'features/downloads_videos/cubit/downloads_videos_cubit.dart';
import 'features/exam_hero/cubit/exam_hero_cubit.dart';
import 'features/examinstructions/cubit/examinstructions_cubit.dart';
import 'features/paperexamRegister/cubit/paper_exam_register_cubit.dart';
import 'features/homePage/cubit/home_page_cubit.dart';
import 'features/lessons_of_class/cubit/lessons_class_cubit.dart';
import 'features/login/cubit/login_cubit.dart';
import 'features/navigation_bottom/cubit/navigation_cubit.dart';
import 'features/onboarding/cubit/on_boarding_cubit.dart';
import 'features/sources_and_references/cubit/source_references_cubit.dart';
import 'features/paperexamdetials/cubit/paper_detials_cubit.dart';
import 'features/splash/presentation/cubit/splash_cubit.dart';
import 'features/start_trip/cubit/start_trip_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> setup() async {
  //! Features

  ///////////////////////// Blocs ////////////////////////

  serviceLocator.registerFactory(
    () => SplashCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => LoginCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => NavigationCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => PaperExamRegisterCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => HomePageCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => MonthPlanCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => PaperDetialsCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => OnBoardingCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => StartTripCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
        () => ExaminstructionsCubit(
      serviceLocator()
    ),
  );
  serviceLocator.registerFactory(
    () => SourceReferencesCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => LessonsClassCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => ExamHeroCubit(),
  );
  ///////////////////////////////////////////////////////////////////////////////

  //! External
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  serviceLocator.registerLazySingleton(() => ServiceApi(serviceLocator()));

  serviceLocator.registerLazySingleton<BaseApiConsumer>(
      () => DioConsumer(client: serviceLocator()));
  serviceLocator.registerLazySingleton(() => AppInterceptors());

  // Dio
  serviceLocator.registerLazySingleton(
    () => Dio(
      BaseOptions(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );
}
