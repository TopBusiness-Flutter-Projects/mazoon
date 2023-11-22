import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../utils/app_strings.dart';

class Preferences {
  static final Preferences instance = Preferences._internal();

  Preferences._internal();
//
  factory Preferences() => instance;

  Future<void> setFirstInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('onBoarding', 'Done');
  }

  Future<String?> getFirstInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('onBoarding');
    return jsonData;
  }

  ////notification
  bool notiSound = true;
  bool notiVisbrate = true;
  bool notiLight = true;

  Future<void> setNotiSound({bool status = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notiSound', status);
  }

  Future<bool?> getNotiSound() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      notiSound = prefs.getBool('notiSound') ?? true;
    } catch (e) {
      notiSound = true;
    }
    return notiSound;
  }

  Future<void> setNotiVibrate({bool status = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notiVibrate', status);
  }

  Future<bool?> getNotiVibrate() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      notiVisbrate = prefs.getBool('notiVibrate') ?? true;
    } catch (e) {
      notiVisbrate = true;
    }
    return notiVisbrate;
  }

  Future<void> setNotiLights({bool status = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notiLights', status);
  }

  Future<bool?> getNotiLights() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      notiLight = prefs.getBool('notiLights') ?? true;
    } catch (e) {
      notiLight = true;
    }
    return notiLight;
  }
  //////////////////////////////////

  Future<String> getPrimaryColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('primaryColor') ?? '#4455D7';
  }

  Future<void> setPrimaryColor(String color) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('primaryColor', color);
  }

  Future<void> saveDownloadPaths(String path) async {
    List<String> paths = await getSavedDownloadPaths();
    paths.add(path);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('savedDownloadPaths', paths);
  }

  // Future<void> saveDownloadVideos(SaveVideoModel saveVideoModel) async {
  //   SaveVideoModelList videos = await getSavedDownloadVideos();
  //   videos.savedList.add(saveVideoModel);
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(
  //     'savedDownloadVideos',
  //     jsonEncode(videos),
  //   );
  // }

  Future<List<String>> getSavedDownloadPaths() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('savedDownloadPaths') ?? [];
  }

  // Future<SaveVideoModelList> getSavedDownloadVideos() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? jsonData = prefs.getString('savedDownloadVideos');
  //   SaveVideoModelList saveVideoModelList;
  //   if (jsonData != null) {
  //     print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
  //     print(jsonData);
  //     saveVideoModelList = SaveVideoModelList.fromJson(jsonDecode(jsonData));
  //     // saveVideoModelList = SaveVideoModelList(savedList: []);
  //   } else {
  //     print('##########################################');
  //     saveVideoModelList = SaveVideoModelList(savedList: []);
  //   }
  //   return saveVideoModelList;
  // }

  Future<bool> searchOnSavedDownloadPaths(String path) async {
    List<String> paths = await getSavedDownloadPaths();
    if (paths.contains(path) == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> setUser(UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(
      'user',
      jsonEncode(
        UserModel.fromJson(
          userModel.toJson(),
        ),
      ),
    );
  }

  Future<UserModel> getUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonData = preferences.getString('user');
    UserModel userModel;
    if (jsonData != null) {
      userModel = UserModel.fromJson(jsonDecode(jsonData));
      // userModel.data?.isLoggedIn = true;
    } else {
      userModel = UserModel();
    }
    return userModel;
  }
  //
  // Future<void> setexam(ExamAnswerListModel examAnswerListModel) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString(
  //     'exam',
  //     jsonEncode(
  //       ExamAnswerListModel.fromJson(
  //         examAnswerListModel.toJson(),
  //       ),
  //     ),
  //   );
  // }
  //
  // Future<ExamAnswerListModel> getExamModel() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? jsonData = preferences.getString('exam');
  //   ExamAnswerListModel examAnswerListModel;
  //   if (jsonData != null) {
  //     examAnswerListModel = ExamAnswerListModel.fromJson(jsonDecode(jsonData));
  //     // userModel.data?.isLoggedIn = true;
  //   } else {
  //     examAnswerListModel = ExamAnswerListModel(answers: null, id: 0, time: '');
  //   }
  //   return examAnswerListModel;
  // }

  Future<bool> clearUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove('user');
  }

  Future<bool> clearAllData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.clear();
  }

  Future<String> getSavedLang() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(AppStrings.locale) ?? 'ar';
  }

  Future<void> savedLang(String local) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(AppStrings.locale, local);
  }

  //theme
}
