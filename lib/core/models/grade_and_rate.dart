// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

GradeAndRateModel welcomeFromJson(String str) =>
    GradeAndRateModel.fromJson(json.decode(str));

String welcomeToJson(GradeAndRateModel data) => json.encode(data.toJson());

class GradeAndRateModel {
  GradeAndRateModelData data;
  String message;
  int code;

  GradeAndRateModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory GradeAndRateModel.fromJson(Map<String, dynamic> json) =>
      GradeAndRateModel(
        data: json["data"] != null
            ? GradeAndRateModelData.fromJson(json["data"])
            : GradeAndRateModelData(),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "code": code,
      };
}

class GradeAndRateModelData {
  List<Degree>? degrees = [];
  String? totalPer;
  String? motivationalWord;

  GradeAndRateModelData({
    this.degrees,
    this.totalPer,
    this.motivationalWord,
  });

  factory GradeAndRateModelData.fromJson(Map<String, dynamic> json) =>
      GradeAndRateModelData(
        degrees:
            List<Degree>.from(json["degrees"].map((x) => Degree.fromJson(x))),
        totalPer: json["total_per"] ?? '',
        motivationalWord: json["motivational_word"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "degrees": List<dynamic>.from(degrees!.map((x) => x.toJson())),
        "total_per": totalPer,
        "motivational_word": motivationalWord,
      };
}

class Degree {
  int id;
  String name;
  String backgroundColor;
  dynamic percentage;
  String degree;

  Degree({
    required this.id,
    required this.name,
    required this.backgroundColor,
    required this.percentage,
    required this.degree,
  });

  factory Degree.fromJson(Map<String, dynamic> json) => Degree(
        id: json["id"],
        name: json["name"],
        backgroundColor: json["background_color"],
        percentage: json["percentage"],
        degree: json["degree"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "background_color": backgroundColor,
        "percentage": percentage,
        "degree": degree,
      };
}
