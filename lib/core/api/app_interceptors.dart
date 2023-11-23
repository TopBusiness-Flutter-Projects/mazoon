import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../preferences/preferences.dart';
import '../utils/app_strings.dart';

class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[AppStrings.contentType] = AppStrings.applicationJson;
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
    if (response.statusCode == 401) {
      Preferences.instance.clearUserData().then((value) {
        Get.to(SplashScreen());
      });
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('errrrrrrrrrrrrrrrror......................................');
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (err.response!.statusCode == 401 || err.response!.statusCode == 407) {
      Preferences.instance.clearUserData().then((value) {
        Get.to(SplashScreen());
      });
    }
    print('......................................');

    ///
    super.onError(err, handler);
  }
}
