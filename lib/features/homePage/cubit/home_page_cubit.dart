import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:new_mazoon/core/utils/dialogs.dart';
import 'package:new_mazoon/core/utils/show_dialog.dart';
import 'package:new_mazoon/features/liveexam/screen/liveexamresult.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/models/class_data.dart';
import '../../../core/models/home_page_model.dart';
import '../../../core/models/liveexamapplydata.dart';
import '../../../core/models/liveexamquestions.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/utils/string_to_double.dart';
import '../../liveexam/screen/liveexamquestions.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this.api) : super(HomePageInitial()) {}

  UserModel? userModel;

  Future<void> getUserData() async {
    emit(HomePageLoading());
    userModel = await Preferences.instance.getUserModel();
  }

  final ServiceApi api;
  List<AllClasses> classes = [];
  List<SliderModel> sliders = [];
  LiveModelClass? liveModel;
  List<HomePageVideosModel> videosBasics = [];
  List<FinalReviewModel> videosResources = [];
  dynamic lifeExam;

  bool isDialogVisible = false;

  getHomePageData({
    required BuildContext context,
  }) async {
    emit(HomePageLoading());
    final response = await api.getHomePageData();
    response.fold(
      (error) => emit(HomePageError()),
      (res) {
        classes = res.data!.classes!;
        sliders = res.data!.sliders!;
        videosBasics = res.data!.videosBasics!;
        videosResources = res.data!.videosResources!;
        lifeExam = res.data!.lifeExam;
        liveModel = res.data!.liveModel;
        if (res.data!.liveModel != null) {
          Timer(Duration(seconds: 2), () {
            checkDateTime(
                context: context,
                timeStart: res.data!.liveModel!.timeStart,
                endTime: res.data!.liveModel!.timeEnd,
                dateExam: DateFormat('yyyy-MM-dd')
                    .format(res.data!.liveModel!.dateExam));
          });
        }

        print('......................${quizMinutes}');
        emit(HomePageLoaded(res));
      },
    );
  }

  int quizMinutes = 0;
  void checkDateTime(
      {required BuildContext context,
      required String timeStart,
      required String endTime,
      required String dateExam}) {
    DateTime now = DateTime.now();
    DateTime examDateTime =
        DateTime.parse(dateExam + ' ' + timeStart); // Combine date and time
    DateTime endDateTime = DateTime.parse(dateExam + ' ' + endTime);
    // Calculate the difference in minutes
    int minutesDifference = examDateTime.difference(now).inMinutes;
    int minutesDifferenceEnd = endDateTime.difference(now).inMinutes;
    // Ensure quizMinutes is non-negative
    quizMinutes = minutesDifferenceEnd < 0
        ? 0
        : minutesDifferenceEnd; // Check if the exam is before now with a 15-minute buffer
    if (minutesDifference <= 15) {
      if (minutesDifference < 0) {
        lifeExam != null
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LiveExamQuestions(examId: lifeExam.toString())))
            : null;
      } else {
        showDialog(
          context: context,
          barrierDismissible: isDialogVisible,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: AlertDialog(
                title: Text(
                  'بعد انتهاء العد تلقائيا سيبدأ امتحان  اللايف اجهز يا بطل ',
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getSize(context) / 22,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                content: CircularPercentIndicator(
                  backgroundColor: AppColors.offWiite,
                  radius: getSize(context) / 8,
                  lineWidth: getSize(context) / 32,
                  percent: minutesDifference / 60,
                  center: new Text(
                    minutesDifference.toString(),
                    style: TextStyle(
                        fontSize: getSize(context) / 32,
                        fontWeight: FontWeight.w700),
                  ),
                  progressColor: AppColors.greenDownloadColor,
                ),
              ),
            );
          },
        );
        Timer(Duration(seconds: 1), () {
          if (minutesDifference > 0) {
            minutesDifference--;
          }
          emit(HomePageLiveTimerClass());
        });
        if (minutesDifference < 0) {
          lifeExam != null
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LiveExamQuestions(examId: lifeExam.toString())))
              : null;
        }
      }
    } else if (now.isAtSameMomentAs(examDateTime) &&
        now.isBefore(DateTime.parse(dateExam + ' ' + endTime))) {
      showDialog(
        context: context,
        barrierDismissible: isDialogVisible,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: AlertDialog(
              title: Text('Go!'),
              content: Text('It is time to go.'),
            ),
          );
        },
      );
      if (minutesDifference < 0) {
        lifeExam != null
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LiveExamQuestions(examId: lifeExam.toString())))
            : null;
      }
    } else {
      showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Not Yet'),
            content: Text('It is not time yet.'),
          );
        },
      );

      ///exipre exam
    }
  }

  ///////////Question/////////////
  LiveExamQuestionModel? liveExamQuestions;
  getLiveExamQuestions({required String id}) async {
    emit(HomePageLiveLoadingClass());

    final response = await api.getLiveExamQuestions(id: id);

    response.fold((l) {
      emit(HomePageLiveErrorClass());
    }, (r) {
      liveExamQuestions = r;
      emit(HomePageLiveLoadedClass());
    });
  }

  ////////////////////////////////
  setDetailsList() {
    for (int i = 0; i < liveExamQuestions!.data.questions.length; i++) {
      bool questionExistsInDetails = details.any((detail) =>
          int.parse(detail.question) ==
          liveExamQuestions!.data.questions[i].id);
      if (!questionExistsInDetails) {
        addUniqueApplyMakeExam(
          ApplyLiveExamModel(
            answer: '',
            question: liveExamQuestions!.data.questions[i].id.toString(),
          ),
        );
      }
    }
  }

  void solveQuestion(int index) {
    liveExamQuestions!.data.questions[index].isSolving = true;
  }

  List<ApplyLiveExamModel> details = [];
  addUniqueApplyMakeExam(ApplyLiveExamModel exam) {
    int isfound = -1;
    if (details.isEmpty) {
      details.add(exam);
    } else {
      for (int i = 0; i < details.length; i++) {
        if (details[i].question == exam.question &&
            details[i].answer != exam.answer) {
          details[i] = exam;
        } else {}
        if (details[i].question == exam.question) {
          isfound = i;
          return;
        }
      }
      if (isfound != -1) {
        details.removeAt(isfound);
      }
      details.add(exam);
    }
  }

  applyLiveExam({required BuildContext context}) async {
    createProgressDialog(context, 'wait'.tr());
    emit(HomePageApplyLiveLoadingClass());
    await setDetailsList();
    final response =
        await api.applyLiveExam(id: lifeExam.toString(), details: details);
    response.fold((l) {
      emit(HomePageApplyLiveErrorClass());
    }, (r) {
      if (r.code == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LiveExamResultScreen(id: lifeExam.toString())));
      } else if (r.code == 201) {
        Navigator.pop(context);
        Navigator.pop(context);

        Navigator.pushNamed(context, Routes.liveExamScreen);
        Fluttertoast.showToast(msg: r.message);
      }
      emit(HomePageApplyLiveLoadedClass());
    });
  }

  // openLessonAndClass
  openFirstClass(int classId) async {
    emit(HomePageLoadingClass());
    final response =
        await api.openLessonAndClass(id: classId, type: 'subject_class');
    response.fold((l) => emit(HomePageErrorClass()), (r) {
      emit(HomePageLoadedClass());
    });
  }

  userScreenshot() async {
    emit(UserScreenshotLoadingClass());
    final response = await api.userScreenshot();
    response.fold((l) {
      emit(UserScreenshotErrorClass());
    }, (r) {
      errorGetBar(r.message);
      emit(UserScreenshotLoadedClass());
    });
  }
}
