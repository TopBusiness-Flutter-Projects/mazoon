class AudioLessonModel {
  List<LessonAudioData> data;
  String message;
  int code;

  AudioLessonModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory AudioLessonModel.fromJson(Map<String, dynamic> json) =>
      AudioLessonModel(
        data: List<LessonAudioData>.from(
            json["data"].map((x) => LessonAudioData.fromJson(x))),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "code": code,
      };
}

class LessonAudioData {
  int id;
  String? name;
  String? imageOfSubjectClass;
  String? type;
  int? size;
  String? backgroundColor;
  String? status;
  String? subscribe;
  String? link;
  DateTime createdAt;
  DateTime updatedAt;

  LessonAudioData({
    required this.imageOfSubjectClass,
    required this.id,
    required this.name,
    required this.type,
    required this.backgroundColor,
    required this.status,
    required this.subscribe,
    required this.size,
    required this.link,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LessonAudioData.fromJson(Map<String, dynamic> json) =>
      LessonAudioData(
        id: json["id"],
        imageOfSubjectClass: json['image_of_subject_class'],
        name: json["name"],
        size: json['size'],
        type: json["type"],
        backgroundColor: json["background_color"],
        status: json["status"],
        subscribe: json["subscribe"],
        link: json["link"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "size": size,
        "type": type,
        "background_color": backgroundColor,
        "status": status,
        "subscribe": subscribe,
        "image_of_subject_class": imageOfSubjectClass,
        "link": link,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
      };
}
