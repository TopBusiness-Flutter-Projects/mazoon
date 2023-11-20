import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_mazoon/core/utils/dialogs.dart';
import 'package:new_mazoon/core/utils/show_dialog.dart';
import 'package:new_mazoon/features/liveexam/screen/liveexamresult.dart';
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
  int notiCount = 0;
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
        notiCount = res.data!.notificationCount;
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

  final _controller = CountDownController();

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
    int minutesDifference = examDateTime.difference(now).inMinutes + 1;
    int minutesDifferenceEnd = endDateTime.difference(now).inMinutes + 1;
    quizMinutes = minutesDifferenceEnd <= 0
        ? 0
        : minutesDifferenceEnd; // Check if the exam is before now with a 15-minute buffer
    if (minutesDifference <= 15) {
      print('case 1');
      if (minutesDifference <= 0) {
        print('case 11 $lifeExam');
        lifeExam != null
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LiveExamQuestions(examId: lifeExam.toString())))
            : null;
      } else {
        print('case 12');
        showDialog(
          context: context,
          barrierDismissible: isDialogVisible,
          barrierColor: Colors.black.withOpacity(0.4),
          builder: (BuildContext context) {
            return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(getSize(context) / 22)),
                  shadowColor: Colors.black.withOpacity(0.4),
                  title: Text(
                    'بعد انتهاء العد تلقائيا سيبدأ امتحان  اللايف اجهز يا بطل ',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getSize(context) / 22,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        child: CountDownProgressIndicator(
                          strokeWidth: 12,
                          controller: _controller,
                          valueColor: AppColors.blue,
                          backgroundColor: AppColors.white,
                          initialPosition: 0,
                          duration: minutesDifference <= 0
                              ? 5
                              : minutesDifference * 60,
                          // text: 'mm:ss',
                          onComplete: () {
                            Navigator.pop(context);
                            lifeExam != null
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LiveExamQuestions(
                                            examId: lifeExam.toString())))
                                : null;
                          },
                          timeFormatter: (seconds) {
                            int minutes = (seconds / 60).floor();
                            int remainingSeconds = seconds % 60;
                            String formattedTime =
                                '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
                            // print(formattedTime);
                            return formattedTime;
                          },
                          timeTextStyle: TextStyle(
                            color: AppColors.primary,
                            fontSize: getSize(context) / 22,
                            fontFamily: 'KeaniaOne',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
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
      }
    } else if (now.isAtSameMomentAs(examDateTime) &&
        now.isBefore(DateTime.parse(dateExam + ' ' + endTime))) {
      print('case 2');

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
      print('case 3');
      String? lang;
      Preferences.instance.getSavedLang().then((value) {
        lang = value;
      });
      Fluttertoast.showToast(
          msg: 'live_msg'.tr() +
              '${lang == 'en' ? liveModel!.nameEn : liveModel!.nameAr}');

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

  ///apply live
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
