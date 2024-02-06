import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';
import 'package:new_mazoon/core/remote/service.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/models/sources_references_model.dart';
import '../../../core/models/sources_referenes_by_id_model.dart';
import '../../../core/utils/dialogs.dart';
part 'source_references_state.dart';

class SourceReferencesCubit extends Cubit<SourceReferencesState> {
  SourceReferencesCubit(this.api) : super(SourceReferencesInitial()) {
    getDirectionPath();
    sourcesAndReferencesData();
  }
  getDirectionPath() async {
    dirpath = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
  }

  Duration? duration;
  void setduration(Duration duration) {
    print("<<<<<<<<<<<< start time >>>>>>>>>>>>>>");
    this.duration = duration;
    emit(emitNewState());
  }

  var dirpath;

  final ServiceApi api;
  List<SourcesReferencesDatum> sourcesReferencesList = [];
  List<SourcesReferencesByIdDatum> sourcesReferencesByIdList = [];
  late SourcesReferencesDatum referenceModel;

  sourcesAndReferencesData() async {
    emit(SourceReferencesLoading());
    final response = await api.sourcesAndReferencesData();
    response.fold(
      (l) => emit(SourceReferencesError()),
      (r) {
        sourcesReferencesList = r.data!;
        emit(SourceReferencesLoaded());
      },
    );
  }

  sourcesAndReferencesDataById(int classId) async {
    emit(SourceReferencesByIdLoading());
    final response =
        await api.sourcesAndReferencesByIdData(referenceModel.id!, classId);
    response.fold(
      (l) => emit(SourceReferencesByIdError()),
      (r) {
        sourcesReferencesByIdList = r.data!;
        emit(SourceReferencesByIdLoaded());
      },
    );
  }

  downloadPdf(SourcesReferencesDatum model) async {
    final dio = Dio();
    // int index = sourcesReferencesList.indexOf(model);
    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    await dio
        .download(
          model.filePath!,
          dir.path + "/pdf/" + model.title!.split("/").toList().last + '.pdf',
          onReceiveProgress: (count, total) {
            model.progress = (count / total);
            // sourcesReferencesList.removeAt(index);
            // sourcesReferencesList.insert(index, model);
            emit(PDFSourceReferencesByIdLoaded());
          },
        )
        .whenComplete(
          () {},
        )
        .then((value) {
          successGetBar('success_download'.tr());
          model.progress = 0;
          // sourcesReferencesList.removeAt(index);
          // sourcesReferencesList.insert(index, model);
          emit(PDFSourceReferencesByIdLoaded());
        });
  }

  downloadPdfLessons(SourcesReferencesByIdDatum model) async {
    final dio = Dio();
    int index = sourcesReferencesByIdList.indexOf(model);
    var dir = await (Platform.isIOS
        ? getApplicationSupportDirectory()
        : getApplicationDocumentsDirectory());
    await dio.download(
      model.filePath!,
      dir.path + "/pdf/" + model.title!.split("/").toList().last + '.pdf',
      onReceiveProgress: (count, total) {
        model.progress = (count / total);
        sourcesReferencesByIdList.removeAt(index);
        sourcesReferencesByIdList.insert(index, model);
        emit(PDFSLessonourceReferencesByIdLoaded());
      },
    ).whenComplete(
      () {
        successGetBar('success_download'.tr());
        model.progress = 0;
        sourcesReferencesByIdList.removeAt(index);
        sourcesReferencesByIdList.insert(index, model);
        emit(PDFSLessonourceReferencesByIdLoaded());
      },
    );
  }
}
