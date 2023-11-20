import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/models/user_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/utils/toast_message_method.dart';
import '../models/communication_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api) : super(userInitial()) {
    getCommunicationData();
  }

  final ServiceApi api;
  CommunicationData? communicationData;
  bool isCommunicationData = false;
  String softwareType = '';

  TextEditingController codeController = TextEditingController();

  userWithCode(context) async {
    emit(userLoading());
    final response = await api.postUser(codeController.text);
    response.fold(
      (error) => emit(userError()),
      (response) {
        if (response.code == 407) {
          errorGetBar('code_not_found'.tr());
          emit(userError());
        } else if (response.code == 408) {
          errorGetBar('code_not_subscribe'.tr());
          toastMessage(
            'code_not_subscribe'.tr(),
            context,
            color: AppColors.error,
          );
          emit(userError());
        } else if (response.code == 403) {
          errorGetBar('code_not_subscribe'.tr());
          emit(userError());
        } else {
          // Navigator.pop(context);
          successGetBar('user_success'.tr());
          Future.delayed(Duration(seconds: 2), () {
            emit(userInitial());
          });
          Preferences.instance.setUser(response);
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.homePageScreenRoute,
            (route) => false,
          );
          emit(userLoaded(response));
        }
      },
    );
  }

  // Future<String> getDeviceInfo()  {
  //   if () {
  //   } else if (Platform.isIOS) {
  //     return "Apple";
  //   }
  // }

  Future<void> setNotificationToken({required String notiToken}) async {
    emit(setNotificationTokenLoading());
    final response = await api.notificationToken(
      notiToken: notiToken,
      phoneType: Platform.isAndroid ? "android" : "Apple",
    );
    response.fold(
      (error) => emit(setNotificationTokenError()),
      (response) {
        emit(setNotificationTokenLoaded());
      },
    );
  }

  Future<void> getCommunicationData() async {
    emit(userCommunicationLoading());
    final response = await api.getCommunicationData();
    response.fold(
      (error) => emit(userCommunicationError()),
      (response) {
        if (response.code == 200) {
          communicationData = response.data;
          isCommunicationData = true;
          emit(userCommunicationLoaded());
        } else {
          isCommunicationData = false;
          emit(userCommunicationError());
        }
      },
    );
  }
}
