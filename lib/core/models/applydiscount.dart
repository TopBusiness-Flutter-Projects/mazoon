class ApplyDiscount {
  int id;
  int price;
  dynamic coupon;

  ApplyDiscount({
    required this.id,
    required this.price,
    required this.coupon,
  });
  Future<Map<String, dynamic>> toJson(int index) async {
    return {
      'data[$index][month]': id,
      'data[$index][price]': price,
      "coupon": coupon,
    };
  }
}
