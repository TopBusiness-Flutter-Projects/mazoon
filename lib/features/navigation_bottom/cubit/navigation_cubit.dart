import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/models/user_model.dart';
import '../../../core/preferences/preferences.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial()){
    getUserData();
  }

  UserModel? userModel;

  getUserData() async {
    emit(NavigationGetUserLoading());
    userModel = await Preferences.instance.getUserModel();
    emit(NavigationGetUserData());
  }

}
