import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_mazoon/core/utils/toast_message_method.dart';
import 'package:record/record.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/applylessonexammodel.dart';
import '../../../core/models/dependexam.dart';
import '../../../core/models/questionmodel.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/show_dialog.dart';
import 'lessonexamstate.dart';

class QuestionsLessonExamCubit extends Cubit<QuestionsOfLessonExamState> {
  QuestionsLessonExamCubit(this.api) : super(InitLessonExam()) {}

  final ServiceApi api;
  QuestionDateModel? questionOfLessonData;
  getQuestionsOfLessonExam(
      {required int lessonId,
      required BuildContext context,
      required String exam_type}) async {
    emit(LoadingLessonExam());
    final response = await api.getQuestionsOfLessonExam(lessonId, exam_type);
    response.fold(
      (l) => emit(ErrorLessonExam()),
      (r) {
        if (r.code == 200) {
          questionOfLessonData = r.data;
          Navigator.pushNamed(
              arguments: {"exam_type": exam_type, "lessonId": lessonId},
              context,
              Routes.lessonExamScreen);
          emit(LoadedLessonExam());
        } else if (r.code == 201) {
          toastMessage(r.message, context);
          Navigator.pop(context);

          ///go to result of exam or exit him from Questions screen
        } else {
          toastMessage(r.message, context);
        }
        emit(LoadedLessonExam());
      },
    );
  }

  void solveQuestion(int index) {
    questionOfLessonData!.questions[index].isSolving = true;
  }

  ResponseOfApplyLessonExmamData? responseOfApplyLessonExmamData;
  applyLessonExam(
      {required int lessonId,
      required String exam_type,
      required int minutesLeft,
      required BuildContext context}) async {
    createProgressDialog(context, 'wait'.tr());
    ////////////////////
    emit(LoadingApplyLessonExam());
    await setDetailsList(minutesLeft);
    final response = await api.applyLessonExam(
        lessonId: lessonId, exam_type: exam_type, details: details);
    response.fold(
      (l) => emit(ErrorApplyLessonExam()),
      (r) {
        if (r.code == 200) {
          responseOfApplyLessonExmamData = r.data;
          print(r.data.degree);
          print('.................................');
          Navigator.pushReplacementNamed(
              context, arguments: r.data, Routes.resultOfLessonExam);
          details.clear();
          toastMessage(r.message, context);
        } else if (r.code == 415) {
          toastMessage(r.message, context);
          Navigator.pop(context);
        } else if (r.code == 416) {
          toastMessage(r.message, context);
          Navigator.pop(context);
        } else {
          toastMessage(r.message, context);
          Navigator.pop(context);
        }
        emit(LoadedApplyLessonExam());
      },
    );
  }

////////////// fill List of details if you don't add answer
  setDetailsList(int minutesLeft) {
    for (int i = 0; i < questionOfLessonData!.questions.length; i++) {
      bool questionExistsInDetails = details.any((detail) =>
          int.parse(detail.question) == questionOfLessonData!.questions[i].id);
      if (!questionExistsInDetails) {
        addUniqueApplyMakeExam(
          ApplyStudentExam(
            timer: (questionOfLessonData!.quizMinute - minutesLeft),
            answer: '',
            audio: null,
            image: null,
            question: questionOfLessonData!.questions[i].id.toString(),
          ),
        );
      }
    }
  }

  List<ApplyStudentExam> details = [];
  addUniqueApplyMakeExam(ApplyStudentExam exam) {
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

  // addUniqueApplyMakeExam2(ApplyStudentExam exam) {
  //   // details.add(exam);
  //   int isfound = -1;
  //   if (details.isEmpty) {
  //     details.add(exam);
  //     print('item added ${exam.image}');
  //     print('item added ${exam.audio}');
  //   } else {
  //     for (int i = 0; i < details.length; i++) {
  //       if (details[i].question == exam.question) {
  //         isfound = i;
  //         return;
  //       }
  //     }
  //     if (isfound != -1) {
  //       details.removeAt(isfound);
  //     }
  //     details.add(exam);
  //     print('item2 added ${exam.image}');
  //     print('item2 added ${exam.audio}');
  //   }
  // }

  ///
  ///
  AppendLessonExam? appendLessonExam;

  appendDegreeLessonExam(
      {required int lessonId,
      required BuildContext context,
      required String exam_type}) async {
    emit(LoadingAppendLessonExam());

    final response = await api.appendDegreeLessonExam(
        lessonId: lessonId, exam_type: exam_type);

    response.fold((l) => emit(ErrorAppendLessonExam()), (r) {
      if (r.code == 200) {
        toastMessage(r.message, context);
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, Routes.myGradeAndRating);
      } else {
        Navigator.pop(context);
        toastMessage(r.message, context);
      }
//nav
      emit(LoadedAppendLessonExam());
    });
  }

  //try if more 30

  tryAtEndOfExam(
      {required int lessonId,
      required BuildContext context,
      required String type,
      required int time}) async {
    emit(LoadingAddNewtryExamLessonExam());

    final response =
        await api.tryAtEndOfExam(lessonId: lessonId, time: time, type: type);
    response.fold((l) => emit(ErrorAddNewtryExamLessonExam()), (r) {
      // toastMessage(r.message, context);
//nav
      emit(LoadedAddNewtryExamLessonExam());
    });
  }

  //////////////
  bool isRecording = false;
  final audioRecorder = Record();
  XFile? imageFile;
  // String imagePath = '';
  // String audioPath = '';
  TextEditingController answerController = TextEditingController();
  pickImage(
      {required String type,
      required dynamic timer,
      required int index}) async {
    imageFile = await ImagePicker().pickImage(
      source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: imageFile!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
      cropStyle: CropStyle.rectangle,
      compressFormat: ImageCompressFormat.png,
      compressQuality: 90,
    );
    questionOfLessonData!.questions[index].imagePath = croppedFile!.path;

    ///add answer
    addUniqueApplyMakeExam(ApplyStudentExam(
      question: questionOfLessonData!.questions[index].id.toString(),
      image: questionOfLessonData!.questions[index].imagePath,
      timer: timer,
      answer: '',
    ));
    solveQuestion(index);
  }

  Future<void> start() async {
    try {
      if (await audioRecorder.hasPermission()) {
        await audioRecorder.start();
        isRecording = await audioRecorder.isRecording();
        pos = 200;
        emit(LoadedAnswerQuestiionExam());
      }
    } catch (e) {
      print(e);
    }
  }

  double pos = 50;

  Future<void> stop(
      {required String question,
      required dynamic timer,
      required int index}) async {
    questionOfLessonData!.questions[index].recordPath =
        await audioRecorder.stop();
    isRecording = false;
    pos = 50;
    await addUniqueApplyMakeExam(ApplyStudentExam(
      question: questionOfLessonData!.questions[index].id.toString(),
      timer: timer,
      answer: '',
      audio: questionOfLessonData!.questions[index].recordPath,
    ));
    solveQuestion(index);
    emit(LoadedAnswerQuestiionExam2());
  }

  Future<void> stopRecord(int index) async {
    await audioRecorder.stop();
    isRecording = false;
    questionOfLessonData!.questions[index].recordPath == null;
    pos = 50;
    emit(StopRecordingState());
  }
}
