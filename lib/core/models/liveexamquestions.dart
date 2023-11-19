class LiveExamQuestionModel {
  LiveExamQuestionModelData data;
  String message;
  int code;

  LiveExamQuestionModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory LiveExamQuestionModel.fromJson(Map<String, dynamic> json) =>
      LiveExamQuestionModel(
        data: LiveExamQuestionModelData.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "code": code,
      };
}

class LiveExamQuestionModelData {
  int id;
  String name;
  DateTime dateExam;
  String timeStart;
  String timeEnd;
  int quizMinute;
  List<Question> questions;

  LiveExamQuestionModelData({
    required this.id,
    required this.name,
    required this.dateExam,
    required this.timeStart,
    required this.timeEnd,
    required this.quizMinute,
    required this.questions,
  });

  factory LiveExamQuestionModelData.fromJson(Map<String, dynamic> json) =>
      LiveExamQuestionModelData(
        id: json["id"],
        name: json["name"],
        dateExam: DateTime.parse(json["date_exam"]),
        timeStart: json["time_start"],
        timeEnd: json["time_end"],
        quizMinute: json["quiz_minute"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date_exam":
            "${dateExam.year.toString().padLeft(4, '0')}-${dateExam.month.toString().padLeft(2, '0')}-${dateExam.day.toString().padLeft(2, '0')}",
        "time_start": timeStart,
        "time_end": timeEnd,
        "quiz_minute": quizMinute,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  int id;
  String question;
  String? image;
  String questionType;
  String fileType;
  bool isSolving;
  int degree;
  List<Answer> answers;

  Question({
    required this.id,
    required this.question,
    required this.image,
    this.isSolving = false,
    required this.questionType,
    required this.fileType,
    required this.degree,
    required this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        question: json["question"],
        image: json["image"] ?? null,
        questionType: json["question_type"]!,
        fileType: json["file_type"]!,
        degree: json["degree"],
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "image": image,
        "question_type": questionType,
        "file_type": fileType,
        "degree": degree,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
      };
}

class Answer {
  int id;
  String answer;
  String answerNumber;
  String answerStatus;
  dynamic selectedValue;

  Answer({
    required this.id,
    required this.answer,
    this.selectedValue = '',
    required this.answerNumber,
    required this.answerStatus,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"],
        answer: json["answer"],
        answerNumber: json["answer_number"]!,
        answerStatus: json["answer_status"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "answer": answer,
        "answer_number": answerNumber,
        "answer_status": answerStatus,
      };
}
