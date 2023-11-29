import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';
import 'package:new_mazoon/core/remote/service.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/models/class_data.dart';
import '../../../core/models/classes_exam_data_model.dart';
import '../../../core/models/exam_classes_model.dart';
import '../../../core/models/home_page_model.dart';
import '../../../core/utils/dialogs.dart';

part 'start_trip_state.dart';

class StartTripCubit extends Cubit<StartTripState> {
  StartTripCubit(this.api) : super(StartTripInitial()) {
    getDirectionPath();
    // getExplanationData();
    getFinalReviewData();
    getExamClassesData();
  }
  getDirectionPath() async {
    dirpath = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
  }

  var dirpath;

  final ServiceApi api;

  List<AllClasses> classesData = [];
  List<FinalReviewModel> finalReview = [];
  List<ExamClassesDatum> examClasses = [];
  List<ClassesExamDatumModel> examClassList = [];
  int currentIndex = 0;

  selectTap(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexTap());
  }

  getExplanationData() async {
    emit(StartTripExplanationLoading());
    final response = await api.StartTripExplanationData();
    response.fold(
      (l) => emit(StartTripExplanationError()),
      (r) {
        classesData = r.data!;
        emit(StartTripExplanationLoaded());
      },
    );
  }

  getFinalReviewData() async {
    emit(StartTripFinalReviewLoading());
    final response = await api.StartTripFinalReviewData();
    response.fold(
      (l) => emit(StartTripFinalReviewError()),
      (r) {
        finalReview = r.data!;
        emit(StartTripFinalReviewLoaded());
      },
    );
  }

  getExamClassesData() async {
    emit(StartTripExamClassesLoading());
    final response = await api.StartTripExamClassesData();
    response.fold(
      (l) => emit(StartTripExamClassesError()),
      (r) {
        examClasses = r.data!;
        emit(StartTripExamClassesLoaded());
      },
    );
  }

  getExamsClassByIdData(int id) async {
    examClassList = [];
    emit(StartTripExamsClassByIdLoading());
    final response = await api.StartTripExamsClassByIdData(id);
    response.fold(
      (l) => emit(StartTripExamsClassByIdError()),
      (r) {
        examClassList = r.data;
        emit(StartTripExamsClassByIdLoaded());
      },
    );
  }

  startTripAllExamClassesData() async {
    examClassList = [];
    emit(StartTripExamsClassLoading());
    final response = await api.StartTripAllExamClassesData();
    response.fold(
      (l) => emit(StartTripExamsClassError()),
      (r) {
        examClassList = r.data;

        emit(StartTripExamsClassLoaded());
      },
    );
  }

  //////
  dowanload(FinalReviewModel model) async {
    int index = finalReview.indexOf(model);
    final dio = Dio();

    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    await dio.download(
      model.pathFile!,
      dir.path + "/pdf/" + model.name!.split("/").toList().last + '.pdf',
      onReceiveProgress: (count, total) {
        model.progress = (count / total);
        print(model.progress);
        finalReview.removeAt(index);
        finalReview.insert(index, model);
        emit(StartTripFinalReviewLoaded());
      },
    ).whenComplete(
      () {
        successGetBar('success_download'.tr());

        model.progress = 0;
        finalReview.removeAt(index);
        finalReview.insert(index, model);
        emit(StartTripFinalReviewLoaded());
      },
    );
  }

  downloadPdf(ClassesExamDatumModel model) async {
    final dio = Dio();
    int index = examClassList.indexOf(model);

    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    await dio.download(
      model.pdfExamUpload,
      dir.path + "/pdf/" + model.name!.split("/").toList().last + '.pdf',
      onReceiveProgress: (count, total) {
        model.progress = (count / total);
        examClassList.removeAt(index);
        examClassList.insert(index, model);
        emit(StartTripExamClassesLoaded());
      },
    ).whenComplete(
      () {
        successGetBar('success_download'.tr());

        model.progress = 0;
        examClassList.removeAt(index);
        examClassList.insert(index, model);
        emit(StartTripExamClassesLoaded());
      },
    );
  }

  favourite(String type, String action, int video_id, int index) async {
    final response = await api.addToFavouriteExam(
      action: action,
      exam_id: video_id,
      type: type,
    );
    response.fold(
      (l) => emit(ErrorAddHomeWorkToFavorite()),
      (r) {
        examClassList[index].examsFavorite == "un_favorite"
            ? examClassList[index].examsFavorite = "favorite"
            : examClassList[index].examsFavorite = "un_favorite";
        successGetBar(r.message);
        emit(LoadedAddHomeWorkToFavorite());
      },
    );
  }
}
