import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/remote/service.dart';

import '../../../core/models/liveexamresult.dart';
import '../../../core/models/liveexamsmodel.dart';
import '../../../core/models/liveheroes.dart';
import '../../../core/models/livemonthes.dart';
import '../../../core/utils/dialogs.dart';
import 'state.dart';

class LiveExamCubit extends Cubit<LiveExamState> {
  LiveExamCubit(this.api) : super(InitLiveExamState());

  ServiceApi api;
  int currentIndex = 0;
  selectTap(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexTap());
  }

  GetLiveHeroesModelData? liveHeroes;
  List<GetLiveExamsModelData> liveExams = [];
  List<MyOrdered> allExamHeroes = [];
  getLiveExams() async {
    emit(LoadingLiveExamState());
    final response = await api.getLiveExams();
    response.fold((l) {
      emit(ErrorLiveExamState());
    }, (r) {
      liveExams = r.data;
      emit(LoadedLiveExamState());
    });
  }

////////////select monthes
  List<LiveHeroMonthesData> examsMonthes = [];

  Future getLiveHeroesMonthes() async {
    emit(LoadingGetSelctedMonthList());
    final response = await api.getLiveHeroesMonthes();
    response.fold((l) {
      emit(ErrorGetSelctedMonthList());
      return [];
    }, (r) {
      examsMonthes = r.data;
      emit(LoadedGetSelctedMonthList());
      return r.data;
    });
  }

  ///handle UI
  Future getLiveHeroes({required String examId}) async {
    emit(LoadingLiveHeroesState());

    final response = await api.getLiveHeroes(examId: examId);
    response.fold((l) {
      emit(ErrorLiveHeroesState());
    }, (r) {
      liveHeroes = r.data;
      allExamHeroes = r.data.allExamHeroes.length > 3
          ? r.data.allExamHeroes.sublist(3)
          : [];
      emit(LoadedLiveHeroesState());
    });
  }

  favourite(String type, String action, int index) async {
    emit(LoadingAddLiveToFavorite());
    final response = await api.addToFavouriteExam(
      action: action,
      exam_id: liveExams[index].id,
      type: type,
    );
    response.fold(
      (l) => emit(ErrorAddLiveToFavorite()),
      (r) {
        liveExams[index].examsFavorite == "un_favorite"
            ? liveExams[index].examsFavorite = "favorite"
            : liveExams[index].examsFavorite = "un_favorite";
        successGetBar(r.message);
        emit(LoadedAddLiveToFavorite());
      },
    );
  }

  LiveExamResultModel? resultExam;

  getResultExam({required String id}) async {
    emit(LoadingGetLiveExamReslut());
    final response = await api.getLiveExamResult(id: id);
    response.fold((l) {
      emit(ErrorGetLiveExamReslut());
    }, (r) {
      resultExam = r;
      questionColor();
      emit(LoadedGetLiveExamReslut());
    });
  }

  questionColor() {
    for (int i = 0; i < resultExam!.data.examQuestions.questions.length; i++) {
      for (int j = 0;
          j < resultExam!.data.examQuestions.questions[i].answers.length;
          j++) {
        if (resultExam!.data.examQuestions.questions[i].answers[j].id ==
                resultExam!.data.examQuestions.questions[i].answerUser &&
            resultExam!
                    .data.examQuestions.questions[i].answers[j].answerStatus ==
                'correct' &&
            resultExam!.data.examQuestions.questions[i].questionType ==
                'choice') {
          resultExam!.data.examQuestions.questions[i].questionStatus = true;
        }
      }
      emit(TruequestionStatusRateYourselfAttchmentState());
    }
  }
}
