import 'dart:convert';

CommunicationModel communicationModelFromJson(String str) =>
    CommunicationModel.fromJson(json.decode(str));

String communicationModelToJson(CommunicationModel data) =>
    json.encode(data.toJson());

class CommunicationModel {
  CommunicationModel({
    required this.data,
    required this.message,
    required this.code,
  });

  CommunicationData data;
  String message;
  int code;

  factory CommunicationModel.fromJson(Map<String, dynamic> json) =>
      CommunicationModel(
        data: CommunicationData.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "code": code,
      };
}

class CommunicationData {
  CommunicationData({
    required this.id,
    required this.facebookLink,
    required this.youtubeLink,
    required this.websiteLink,
    required this.instagramLink,
    required this.twitterLink,
    required this.phones,
    required this.createdAt,
    required this.sms,
    required this.updatedAt,
    required this.smsMessage,
    required this.whatsApp,
  });

  int id;
  String? facebookLink;
  String? youtubeLink;
  String? websiteLink;
  String? smsMessage;
  String? instagramLink;
  String? twitterLink;
  String? sms;
  String? whatsApp;
  List<Phone>? phones;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CommunicationData.fromJson(Map<String, dynamic> json) =>
      CommunicationData(
        sms: json['sms'],
        whatsApp: json['whatsapp_link'],
        id: json["id"],
        smsMessage: json['sms_message'],
        facebookLink: json["facebook_link"],
        youtubeLink: json["youtube_link"],
        websiteLink: json["website_link"],
        instagramLink: json["instagram_link"],
        twitterLink: json["twitter_link"],
        phones: List<Phone>.from(json["phones"].map((x) => Phone.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "whatsapp_link": whatsApp,
        "facebook_link": facebookLink,
        "youtube_link": youtubeLink,
        "website_link": websiteLink,
        "instagram_link": instagramLink,
        "sms_message": smsMessage,
        "twitter_link": twitterLink,
        "phones": List<dynamic>.from(phones!.map((x) => x.toJson())),
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
      };
}

class Phone {
  Phone({
    required this.id,
    required this.phone,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String phone;
  String note;
  DateTime createdAt;
  DateTime updatedAt;

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        id: json["id"],
        phone: json["phone"],
        note: json["note"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "note": note,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
