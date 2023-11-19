class GetLiveHeroesModel {
  GetLiveHeroesModelData data;
  String message;
  int code;

  GetLiveHeroesModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory GetLiveHeroesModel.fromJson(Map<String, dynamic> json) =>
      GetLiveHeroesModel(
        data: GetLiveHeroesModelData.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "code": code,
      };
}

class GetLiveHeroesModelData {
  MyOrdered myOrdered;
  List<MyOrdered> allExamHeroes;

  GetLiveHeroesModelData({
    required this.myOrdered,
    required this.allExamHeroes,
  });

  factory GetLiveHeroesModelData.fromJson(Map<String, dynamic> json) =>
      GetLiveHeroesModelData(
        myOrdered: MyOrdered.fromJson(json["MyOrdered"]),
        allExamHeroes: List<MyOrdered>.from(
            json["AllExamHeroes"].map((x) => MyOrdered.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "MyOrdered": myOrdered.toJson(),
        "AllExamHeroes":
            List<dynamic>.from(allExamHeroes.map((x) => x.toJson())),
      };
}

class MyOrdered {
  int id;
  String name;
  String country;
  int ordered;
  dynamic studentTotalDegrees;
  dynamic examsTotalDegree;
  String image;
  String studentPer;

  MyOrdered({
    required this.id,
    required this.name,
    required this.country,
    required this.ordered,
    required this.studentTotalDegrees,
    required this.examsTotalDegree,
    required this.image,
    required this.studentPer,
  });

  factory MyOrdered.fromJson(Map<String, dynamic> json) => MyOrdered(
        id: json["id"],
        name: json["name"],
        country: json["country"],
        ordered: json["ordered"],
        studentTotalDegrees: json["student_total_degrees"],
        examsTotalDegree: json["exams_total_degree"],
        image: json["image"],
        studentPer: json["student_per"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
        "ordered": ordered,
        "student_total_degrees": studentTotalDegrees,
        "exams_total_degree": examsTotalDegree,
        "image": image,
        "student_per": studentPer,
      };
}
