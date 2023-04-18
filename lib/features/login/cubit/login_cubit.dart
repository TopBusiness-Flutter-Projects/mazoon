import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/models/user_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/app_colors.dart';
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
          toastMessage(
            'code_not_found'.tr(),
            context,
            color: AppColors.error,
          );
          emit(userError());
        } else if (response.code == 408) {
          toastMessage(
            'code_not_subscribe'.tr(),
            context,
            color: AppColors.error,
          );
          emit(userError());
        } else {
          Future.delayed(Duration(seconds: 2), () {
            emit(userInitial());
          });
          Preferences.instance.setUser(response);
          emit(userLoaded(response));
        }
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
