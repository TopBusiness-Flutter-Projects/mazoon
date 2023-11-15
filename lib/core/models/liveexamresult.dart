class LiveExamResultModel {
  LiveExamResultModelData data;
  String message;
  int code;

  LiveExamResultModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory LiveExamResultModel.fromJson(Map<String, dynamic> json) =>
      LiveExamResultModel(
        data: LiveExamResultModelData.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "code": code,
      };
}

class LiveExamResultModelData {
  String studentDegree;
  String motivationalWord;
  int numOfCorrectQuestions;
  int numOfMistakeQuestions;
  int ordered;
  ExamQuestions examQuestions;

  LiveExamResultModelData({
    required this.studentDegree,
    required this.motivationalWord,
    required this.numOfCorrectQuestions,
    required this.numOfMistakeQuestions,
    required this.ordered,
    required this.examQuestions,
  });

  factory LiveExamResultModelData.fromJson(Map<String, dynamic> json) =>
      LiveExamResultModelData(
        studentDegree: json["student_degree"],
        motivationalWord: json["motivational_word"],
        numOfCorrectQuestions: json["num_of_correct_questions"],
        numOfMistakeQuestions: json["num_of_mistake_questions"],
        ordered: json["ordered"],
        examQuestions: ExamQuestions.fromJson(json["exam_questions"]),
      );

  Map<String, dynamic> toJson() => {
        "student_degree": studentDegree,
        "motivational_word": motivationalWord,
        "num_of_correct_questions": numOfCorrectQuestions,
        "num_of_mistake_questions": numOfMistakeQuestions,
        "ordered": ordered,
        "exam_questions": examQuestions.toJson(),
      };
}

class ExamQuestions {
  int id;
  String name;
  List<Question> questions;

  ExamQuestions({
    required this.id,
    required this.name,
    required this.questions,
  });

  factory ExamQuestions.fromJson(Map<String, dynamic> json) => ExamQuestions(
        id: json["id"],
        name: json["name"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  int id;
  String questionType;
  bool questionStatus;

  String question;
  String? image;
  String answerUserType;
  int answerUser;
  int questionDegree;
  List<Answer> answers;

  Question({
    required this.id,
    required this.questionType,
    required this.question,
    required this.image,
    required this.questionStatus,
    required this.answerUserType,
    required this.answerUser,
    required this.questionDegree,
    required this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        questionStatus: false,
        questionType: json["question_type"]!,
        question: json["question"],
        image: json["image"],
        answerUserType: json["answer_user_type"]!,
        answerUser: json["answer_user"],
        questionDegree: json["question_degree"],
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question_type": questionType,
        "question": question,
        "image": image,
        "answer_user_type": answerUserType,
        "answer_user": answerUser,
        "question_degree": questionDegree,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
      };
}

class Answer {
  int id;
  String answer;
  String answerNumber;
  String answerStatus;

  Answer({
    required this.id,
    required this.answer,
    required this.answerNumber,
    required this.answerStatus,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"],
        answer: json["answer"],
        answerNumber: json["answer_number"],
        answerStatus: json["answer_status"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "answer": answer,
        "answer_number": answerNumber,
        "answer_status": answerStatus,
      };
}
