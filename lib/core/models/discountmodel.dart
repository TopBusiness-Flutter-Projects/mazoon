class CalculateDiscountModel {
  CalculateDiscountModelData data;
  String message;
  int code;

  CalculateDiscountModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory CalculateDiscountModel.fromJson(Map<String, dynamic> json) =>
      CalculateDiscountModel(
        data: CalculateDiscountModelData.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "code": code,
      };
}

class CalculateDiscountModelData {
  int total;
  String couponStatus;
  int totalAfterDiscount;

  CalculateDiscountModelData({
    required this.total,
    required this.couponStatus,
    required this.totalAfterDiscount,
  });

  factory CalculateDiscountModelData.fromJson(Map<String, dynamic> json) =>
      CalculateDiscountModelData(
        total: json["total"],
        couponStatus: json["coupon_status"],
        totalAfterDiscount: json["total_after_discount"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "coupon_status": couponStatus,
        "total_after_discount": totalAfterDiscount,
      };
}
