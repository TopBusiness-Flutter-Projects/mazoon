class ApplyLiveExamModel {
  String question;
  String? answer;

  ApplyLiveExamModel({
    required this.question,
    this.answer,
  });
  Future<Map<String, dynamic>> toJson(int index) async {
    return {
      'details[$index][question]': question,
      if (answer != null) 'details[$index][answer]': answer,
    };
  }
}
