class SubscriptionsModel {
  List<SubscriptionsDataModel> data;
  String message;
  int code;

  SubscriptionsModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory SubscriptionsModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionsModel(
        data: List<SubscriptionsDataModel>.from(
            json["data"].map((x) => SubscriptionsDataModel.fromJson(x))),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x!.toJson())),
        "message": message,
        "code": code,
      };
}

class SubscriptionsDataModel {
  int id;
  String name;
  int price;
  FreeStatus freeStatus;
  List<Content> content;
  bool? isSelected;

  SubscriptionsDataModel({
    required this.id,
    required this.name,
    required this.price,
    required this.freeStatus,
    this.isSelected = false,
    required this.content,
  });

  factory SubscriptionsDataModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionsDataModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        freeStatus: freeStatusValues.map[json["free_status"]]!,
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "free_status": freeStatusValues.reverse[freeStatus],
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
      };
}

class Content {
  int id;
  String name;
  String time;

  Content({
    required this.id,
    required this.name,
    required this.time,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        name: json["name"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "time": time,
      };
}

enum FreeStatus { NOT_FREE, UNAVAILABLE }

final freeStatusValues = EnumValues(
    {"not_free": FreeStatus.NOT_FREE, "unavailable": FreeStatus.UNAVAILABLE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
