class LessonExamModel2 {
  LessonExamData2? data;
  String message;
  int code;

  LessonExamModel2({
    required this.data,
    required this.message,
    required this.code,
  });

  factory LessonExamModel2.fromJson(Map<String, dynamic> json) =>
      LessonExamModel2(
        data: json["data"] == null
            ? null
            : LessonExamData2.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "message": message,
        "code": code,
      };
}

class LessonExamData2 {
  int id;
  String name;
  String examsFavorite;
  String backgroundColor;
  int numOfQuestion;
  int totalTime;

  LessonExamData2({
    required this.id,
    required this.name,
    required this.examsFavorite,
    required this.backgroundColor,
    required this.numOfQuestion,
    required this.totalTime,
  });

  factory LessonExamData2.fromJson(Map<String, dynamic> json) =>
      LessonExamData2(
        id: json["id"],
        name: json["name"],
        examsFavorite: json["exams_favorite"],
        backgroundColor: json["background_color"],
        numOfQuestion: json["num_of_question"],
        totalTime: json["total_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "exams_favorite": examsFavorite,
        "background_color": backgroundColor,
        "num_of_question": numOfQuestion,
        "total_time": totalTime,
      };
}
