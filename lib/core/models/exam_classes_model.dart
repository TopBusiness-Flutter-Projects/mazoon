class StartTripExamClassesModel {
  StartTripExamClassesModel({
    this.data,
    this.message,
    this.code,
  });

  final List<ExamClassesDatum>? data;
  final String? message;
  final int? code;

  factory StartTripExamClassesModel.fromJson(Map<String, dynamic> json) =>
      StartTripExamClassesModel(
        data: json["data"] == null
            ? []
            : List<ExamClassesDatum>.from(
                json["data"]!.map((x) => ExamClassesDatum.fromJson(x))),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "code": code,
      };
}

class ExamClassesDatum {
  ExamClassesDatum({
    this.id,
    this.status,
    this.title,
    this.numOfExams,
    this.numOfLessons,
  });

  final int? id;
  final String? status;
  final String? title;
  final int? numOfLessons;
  final int? numOfExams;
  factory ExamClassesDatum.fromJson(Map<String, dynamic> json) =>
      ExamClassesDatum(
        id: json["id"],
        numOfExams: json['num_of_exams'],
        status: json["status"],
        title: json["title"],
        numOfLessons: json["num_of_lessons"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "num_of_exams":numOfExams,
        "title": title,
        "num_of_lessons": numOfLessons,
      };
}
