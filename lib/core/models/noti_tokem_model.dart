
class NotificationTokenModel {
    Data data;
    String message;
    int code;

    NotificationTokenModel({
        required this.data,
        required this.message,
        required this.code,
    });

    factory NotificationTokenModel.fromJson(Map<String, dynamic> json) => NotificationTokenModel(
        data: Data.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "code": code,
    };
}

class Data {
    int id;
    String token;
    String phoneType;
    User user;
    DateTime createdAt;
    DateTime updatedAt;

    Data({
        required this.id,
        required this.token,
        required this.phoneType,
        required this.user,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        token: json["token"],
        phoneType: json["phone_type"],
        user: User.fromJson(json["user"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "phone_type": phoneType,
        "user": user.toJson(),
        "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
    };
}

class User {
    int id;
    String report;
    String name;
    dynamic email;
    String phone;
    Season season;
    Season term;
    String fatherPhone;
    String image;
    String userStatus;
    String center;
    String code;
    dynamic dateStartCode;
    dynamic dateEndCode;
    City city;
    City country;
    String token;
    DateTime createdAt;
    DateTime updatedAt;

    User({
        required this.id,
        required this.report,
        required this.name,
        required this.email,
        required this.phone,
        required this.season,
        required this.term,
        required this.fatherPhone,
        required this.image,
        required this.userStatus,
        required this.center,
        required this.code,
        required this.dateStartCode,
        required this.dateEndCode,
        required this.city,
        required this.country,
        required this.token,
        required this.createdAt,
        required this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        report: json["report"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        season: Season.fromJson(json["season"]),
        term: Season.fromJson(json["term"]),
        fatherPhone: json["father_phone"],
        image: json["image"],
        userStatus: json["user_status"],
        center: json["center"],
        code: json["code"],
        dateStartCode: json["date_start_code"],
        dateEndCode: json["date_end_code"],
        city: City.fromJson(json["city"]),
        country: City.fromJson(json["country"]),
        token: json["token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "report": report,
        "name": name,
        "email": email,
        "phone": phone,
        "season": season.toJson(),
        "term": term.toJson(),
        "father_phone": fatherPhone,
        "image": image,
        "user_status": userStatus,
        "center": center,
        "code": code,
        "date_start_code": dateStartCode,
        "date_end_code": dateEndCode,
        "city": city.toJson(),
        "country": country.toJson(),
        "token": token,
        "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
    };
}

class City {
    int id;
    String nameAr;
    String nameEn;
    dynamic createdAt;
    dynamic updatedAt;

    City({
        required this.id,
        required this.nameAr,
        required this.nameEn,
        required this.createdAt,
        required this.updatedAt,
    });

    factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class Season {
    int id;
    String nameAr;
    String nameEn;
    String? status;

    Season({
        required this.id,
        required this.nameAr,
        required this.nameEn,
        this.status,
    });

    factory Season.fromJson(Map<String, dynamic> json) => Season(
        id: json["id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
        "status": status,
    };
}
