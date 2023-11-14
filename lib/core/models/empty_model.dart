class EmptyModel {
  String data;
  String message;
  int code;

  EmptyModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory EmptyModel.fromJson(Map<String, dynamic> json) => EmptyModel(
        data: json["data"],
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "message": message,
        "code": code,
      };
}
