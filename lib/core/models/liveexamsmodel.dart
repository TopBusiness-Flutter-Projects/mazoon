class GetLiveExamsModel {
  List<GetLiveExamsModelData> data;
  String message;
  int code;

  GetLiveExamsModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory GetLiveExamsModel.fromJson(Map<String, dynamic> json) =>
      GetLiveExamsModel(
        data: List<GetLiveExamsModelData>.from(
            json["data"].map((x) => GetLiveExamsModelData.fromJson(x))),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "code": code,
      };
}

class GetLiveExamsModelData {
  int id;
  String name;
  String examsFavorite;
  String? answerVideoFile;

  GetLiveExamsModelData({
    required this.id,
    required this.name,
    required this.examsFavorite,
    required this.answerVideoFile,
  });

  factory GetLiveExamsModelData.fromJson(Map<String, dynamic> json) =>
      GetLiveExamsModelData(
        id: json["id"],
        name: json["name"],
        examsFavorite: json["exams_favorite"],
        answerVideoFile: json["answer_video_file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "exams_favorite": examsFavorite,
        "answer_video_file": answerVideoFile,
      };
}
