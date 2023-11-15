class LiveHeroMonthes {
  List<LiveHeroMonthesData> data;
  String message;
  int code;

  LiveHeroMonthes({
    required this.data,
    required this.message,
    required this.code,
  });

  factory LiveHeroMonthes.fromJson(Map<String, dynamic> json) =>
      LiveHeroMonthes(
        data: List<LiveHeroMonthesData>.from(
            json["data"].map((x) => LiveHeroMonthesData.fromJson(x))),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "code": code,
      };
}

class LiveHeroMonthesData {
  int id;
  String name;

  LiveHeroMonthesData({
    required this.id,
    required this.name,
  });

  factory LiveHeroMonthesData.fromJson(Map<String, dynamic> json) =>
      LiveHeroMonthesData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
