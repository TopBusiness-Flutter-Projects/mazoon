class NotificationsModel {
  NotificationsModel({
    this.data,
  });

  List<NotificationModel>? data;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        data: List<NotificationModel>.from(
            json["data"].map((x) => NotificationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NotificationModel {
  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.notificationType,
    required this.videoType,
    required this.videoId,
    required this.examType,
    required this.examId,
    required this.seen,
    required this.image,
    required this.timeOfNotification,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String title;
  String body;
  String notificationType;
  dynamic videoType;
  dynamic videoId;
  dynamic examType;
  dynamic examId;
  String seen;
  dynamic image;
  String timeOfNotification;
  DateTime createdAt;
  DateTime updatedAt;
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        notificationType: json["notification_type"],
        videoType: json["video_type"],
        videoId: json["video_id"],
        examType: json["exam_type"],
        examId: json["exam_id"],
        seen: json["seen"],
        image: json["image"],
        timeOfNotification: json["time_of_notification"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "notification_type": notificationType,
        "video_type": videoType,
        "video_id": videoId,
        "exam_type": examType,
        "exam_id": examId,
        "seen": seen,
        "image": image,
        "time_of_notification": timeOfNotification,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
      };
}
