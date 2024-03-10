class UserModel {
  UserModel({
    this.data,
    this.message,
    this.code,
  });

  User? data;
  String? message;
  int? code;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: json["data"] != null ? User.fromJson(json["data"]) : null,
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "message": message,
        "code": code,
      };
}

class User {
  User({
    required this.id,
    required this.name,
    this.email,
    required this.phone,
    required this.fatherPhone,
    required this.image,
    required this.userStatus,
    required this.code,
    required this.season,
    required this.term,
    this.dateStartCode,
    this.dateEndCode,
    required this.report,
    required this.center,
    this.country,
    this.city,
    this.subscriptionMonth,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String report;
  String name;
  String? email;
  List<String>? subscriptionMonth;

  String phone;
  String fatherPhone;
  String center;
  String image;
  String userStatus;
  String code;
  Season season;
  Term term;
  DateTime? dateStartCode;
  DateTime? dateEndCode;
  Country? country;
  Country? city;
  String token;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        center: json['center'],
        report: json['report'],
        subscriptionMonth: json["subscription_month"] == null
            ? []
            : List<String>.from(json["subscription_month"]!.map((x) => x)),
        email: json["email"],
        phone: json["phone"] ?? 'no phone',
        fatherPhone: json["father_phone"] ?? 'no father phone',
        image: json["image"],
        userStatus: json["user_status"] ?? 'no status',
        code: json["code"] ?? 'no code',
        season: json["season"] != null
            ? Season.fromJson(json["season"])
            : Season(id: 0, nameAr: '', nameEn: ''),
        term: json["term"] != null
            ? Term.fromJson(json["term"])
            : Term(id: 0, nameAr: '', nameEn: ''),
        dateStartCode: json["date_start_code"] != null
            ? DateTime.parse(json["date_start_code"])
            : DateTime(2022),
        dateEndCode: json["date_end_code"] != null
            ? DateTime.parse(json["date_end_code"])
            : DateTime(2022),
        country:
            json["country"] != null ? Country.fromJson(json["country"]) : null,
        city: json["city"] != null ? Country.fromJson(json["city"]) : null,
        token: json["token"] ?? '',
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : DateTime(2020),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : DateTime(2020),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "report": report,
        "father_phone": fatherPhone,
        "image": image,
        "user_status": userStatus,
        "center": center,
        "code": code,
        "season": season.toJson(),
        "subscription_month": subscriptionMonth == null
            ? []
            : List<dynamic>.from(subscriptionMonth!.map((x) => x)),
        "term": term.toJson(),
        "date_start_code":
            "${dateStartCode?.year.toString().padLeft(4, '0')}-${dateStartCode?.month.toString().padLeft(2, '0')}-${dateStartCode?.day.toString().padLeft(2, '0')}",
        "date_end_code":
            "${dateEndCode?.year.toString().padLeft(4, '0')}-${dateEndCode?.month.toString().padLeft(2, '0')}-${dateEndCode?.day.toString().padLeft(2, '0')}",
        "country": country!.toJson(),
        "city": city!.toJson(),
        "token": token,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
      };
}

class Country {
  Country({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String nameAr;
  String nameEn;
  DateTime createdAt;
  DateTime updatedAt;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
      };
}

class Season {
  Season({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  int id;
  String nameAr;
  String nameEn;

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        id: json["id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
      };
}

class Term {
  Term({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  int id;
  String nameAr;
  String nameEn;

  factory Term.fromJson(Map<String, dynamic> json) => Term(
        id: json["id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
      };
}
