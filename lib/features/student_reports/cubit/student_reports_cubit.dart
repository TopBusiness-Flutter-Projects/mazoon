import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/models/student_reports_model.dart';
import '../../../core/remote/service.dart';

part 'student_reports_state.dart';

class StudentReportsCubit extends Cubit<StudentReportsState> {
  List<StudentReports> data = [];
  final ServiceApi api;
  StudentReportsCubit(this.api) : super(StudentReportsInitial()) {
    getAllReports();
  }
  getAllReports() async {
    emit(StudentReportsPageLoading());
    final response = await api.getStudentReports();
    response.fold(
      (error) => emit(StudentReportsPageError()),
      (response) {
        data = response.data;
        emit(StudentReportsPageLoaded());
      },
    );
  }
}
