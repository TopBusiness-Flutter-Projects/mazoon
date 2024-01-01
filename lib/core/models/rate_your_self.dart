class RateYourselfModel {
  RateYourselfModelData data;
  String message;
  int code;

  RateYourselfModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory RateYourselfModel.fromJson(Map<String, dynamic> json) =>
      RateYourselfModel(
        data: RateYourselfModelData.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "code": code,
      };
}

class RateYourselfModelData {
  String fullDegree;
  int correctNumbers;
  int mistakeNumbers;
  String motivationalWord;
  int tryingNumbers;
  RateExamQuestions examQuestions;

  RateYourselfModelData({
    required this.fullDegree,
    required this.correctNumbers,
    required this.motivationalWord,
    required this.mistakeNumbers,
    required this.tryingNumbers,
    required this.examQuestions,
  });

  factory RateYourselfModelData.fromJson(Map<String, dynamic> json) =>
      RateYourselfModelData(
        fullDegree: json["full_degree"],
        motivationalWord: json['motivational_word'],
        correctNumbers: json["correct_numbers"],
        mistakeNumbers: json["mistake_numbers"],
        tryingNumbers: json["trying_numbers"],
        examQuestions: RateExamQuestions.fromJson(json["exam_questions"]),
      );

  Map<String, dynamic> toJson() => {
        "full_degree": fullDegree,
        "correct_numbers": correctNumbers,
        "mistake_numbers": mistakeNumbers,
        "motivational_word": motivationalWord,
        "trying_numbers": tryingNumbers,
        "exam_questions": examQuestions.toJson(),
      };
}

class RateExamQuestions {
  int id;
  String name;
  List<RateYourselfQuestionModel> questions;

  RateExamQuestions({
    required this.id,
    required this.name,
    required this.questions,
  });

  factory RateExamQuestions.fromJson(Map<String, dynamic> json) =>
      RateExamQuestions(
        id: json["id"],
        name: json["name"],
        questions: List<RateYourselfQuestionModel>.from(json["questions"]
            .map((x) => RateYourselfQuestionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class RateYourselfQuestionModel {
  int id;
  String question;
  bool questionStatus;
  dynamic answerUser;
  String answerUserType;
  String questionType;
  String? fileType;
  int degree;
  String note;
  List<RateYourselfAnswersModel> answers;
  DateTime createdAt;
  DateTime updatedAt;

  RateYourselfQuestionModel({
    required this.id,
    required this.question,
    required this.questionStatus,
    required this.answerUser,
    required this.answerUserType,
    required this.questionType,
    required this.fileType,
    required this.degree,
    required this.note,
    required this.answers,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RateYourselfQuestionModel.fromJson(Map<String, dynamic> json) =>
      RateYourselfQuestionModel(
        id: json["id"],
        questionStatus: false,
        question: json["question"],
        answerUser: json["answer_user"],
        answerUserType: json["answer_user_type"],
        questionType: json["question_type"],
        fileType: json["file_type"],
        degree: json["degree"],
        note: json["note"],
        answers: List<RateYourselfAnswersModel>.from(
            json["answers"].map((x) => RateYourselfAnswersModel.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer_user": answerUser,
        "questionStatus": questionStatus,
        "answer_user_type": answerUserType,
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

class RateYourselfAnswersModel {
  int id;
  String answer;
  String answerNumber;
  String answerStatus;
  DateTime createdAt;
  DateTime updatedAt;

  RateYourselfAnswersModel({
    required this.id,
    required this.answer,
    required this.answerNumber,
    required this.answerStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RateYourselfAnswersModel.fromJson(Map<String, dynamic> json) =>
      RateYourselfAnswersModel(
        id: json["id"],
        answer: json["answer"],
        answerNumber: json["answer_number"],
        answerStatus: json["answer_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "answer": answer,
        "answer_number": answerNumber,
        "answer_status": answerStatus,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
      };
}
