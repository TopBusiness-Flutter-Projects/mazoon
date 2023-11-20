// To parse this JSON data, do
//
//     final updateNotification = updateNotificationFromJson(jsonString);

import 'dart:convert';

import 'notifications_model.dart';

UpdateNotification updateNotificationFromJson(String str) =>
    UpdateNotification.fromJson(json.decode(str));

String updateNotificationToJson(UpdateNotification data) =>
    json.encode(data.toJson());

class UpdateNotification {
  final NotificationModel? data;
  final String? message;
  final int? code;

  UpdateNotification({
    this.data,
    this.message,
    this.code,
  });

  factory UpdateNotification.fromJson(Map<String, dynamic> json) =>
      UpdateNotification(
        data: json["data"] == null
            ? null
            : NotificationModel.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
        "code": code,
      };
}
//
// class Data {
//   final int? id;
//   final String? title;
//   final String? body;
//   final String? type;
//   final String? seen;
//   final dynamic serviceId;
//   final String? image;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   Data({
//     this.id,
//     this.title,
//     this.body,
//     this.type,
//     this.seen,
//     this.serviceId,
//     this.image,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     id: json["id"],
//     title: json["title"],
//     body: json["body"],
//     type: json["type"],
//     seen: json["seen"],
//     serviceId: json["service_id"],
//     image: json["image"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "body": body,
//     "type": type,
//     "seen": seen,
//     "service_id": serviceId,
//     "image": image,
//     "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
//     "updated_at": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
//   };
// }
