class MainQuestionModel {
  QuestionDateModel data;
  String message;
  int code;

  MainQuestionModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory MainQuestionModel.fromJson(Map<String, dynamic> json) =>
      MainQuestionModel(
        data: QuestionDateModel.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "code": code,
      };
}

class QuestionDateModel {
  int id;
  String name;
  dynamic note;

  DateTime dateExam;
  int quizMinute;
  List<QuestionModel> questions;

  QuestionDateModel({
    required this.id,
    required this.name,
    this.note,
    required this.dateExam,
    required this.quizMinute,
    required this.questions,
  });

  factory QuestionDateModel.fromJson(Map<String, dynamic> json) =>
      QuestionDateModel(
        id: json["id"],
        name: json["name"],
        note: json["note"],
        dateExam: DateTime.parse(json["date_exam"]),
        quizMinute: json["quiz_minute"],
        questions: List<QuestionModel>.from(
            json["questions"].map((x) => QuestionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "note": note,
        "date_exam":
            "${dateExam.year.toString().padLeft(4, '0')}-${dateExam.month.toString().padLeft(2, '0')}-${dateExam.day.toString().padLeft(2, '0')}",
        "quiz_minute": quizMinute,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class QuestionModel {
  int id;
  String question;
  String questionType;
  String fileType;
  int degree;
  bool isSolving;
  String note;
  List<AnswersModel> answers;
  DateTime createdAt;
  DateTime updatedAt;

  QuestionModel({
    required this.id,
    required this.question,
    required this.questionType,
    required this.fileType,
    required this.degree,
    required this.note,
    required this.answers,
    this.isSolving = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        id: json["id"],
        question: json["question"],
        questionType: json["question_type"],
        fileType: json["file_type"],
        degree: json["degree"],
        note: json["note"],
        answers: List<AnswersModel>.from(
            json["answers"].map((x) => AnswersModel.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": 1200,
        "question_type": questionType,
        "file_type": fileType,
        "degree": degree,
        "note": note,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
      };
}

class AnswersModel {
  int id;
  String answer;
  String answerNumber;
  AnswerStatus answerStatus;
  DateTime createdAt;
  DateTime updatedAt;
  String selectedValue;
  AnswersModel({
    required this.id,
    required this.answer,
    required this.answerNumber,
    required this.answerStatus,
    required this.createdAt,
    this.selectedValue = '',
    required this.updatedAt,
  });

  factory AnswersModel.fromJson(Map<String, dynamic> json) => AnswersModel(
        id: json["id"],
        answer: json["answer"],
        answerNumber: json["answer_number"],
        answerStatus: answerStatusValues.map[json["answer_status"]]!,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "answer": answer,
        "answer_number": answerNumber,
        "answer_status": answerStatusValues.reverse[answerStatus],
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
      };
}

enum AnswerStatus { UN_CORRECT, CORRECT }

final answerStatusValues = EnumValues(
    {"correct": AnswerStatus.CORRECT, "un_correct": AnswerStatus.UN_CORRECT});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class QuestionOfLessonStatus extends QuestionModel {
  QuestionOfLessonStatus({required this.questionModel, this.isSolving = false})
      : super(
          question: questionModel.question,
          answers: questionModel.answers,
          createdAt: questionModel.createdAt,
          degree: questionModel.degree,
          fileType: questionModel.fileType,
          id: questionModel.id,
          note: questionModel.note,
          questionType: questionModel.questionType,
          updatedAt: questionModel.updatedAt,
        );
  QuestionModel questionModel;
  bool isSolving;
}
