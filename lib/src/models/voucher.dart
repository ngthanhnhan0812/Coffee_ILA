class Voucher {
  final String id;
  final int condition;
  final int discount;
  final String usercreate;
  final String startDate;
  final String endDate;
  final int isActive;
  // final int used;

  const Voucher({
    required this.id,
    required this.condition,
    required this.discount,
    required this.usercreate,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    // required this.used
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json['id'],
      condition: json['condition'],
      discount: json['discount'],
      usercreate: json['usercreate'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      isActive: json['isActive'],
      // used: json['used']
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['condition'] = condition;
  //   data['discount'] = discount;
  //   data['usercreate'] = usercreate;
  //   data['startDate'] = startDate;
  //   data['endDate'] = endDate;
  //   data['isActive'] = isActive;
  //   return data;
  // }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'coupon': coupon,
  //     'condition': condition,
  //     'discount': discount,
  //     'usercreate': usercreate,
  //     'startDate': startDate.millisecondsSinceEpoch,
  //     'endDate': endDate.millisecondsSinceEpoch,
  //     'isActive': isActive,
  //   };
  // }

  // factory Voucher.fromMap(Map<String, dynamic> map) {
  //   return Voucher(
  //     id: map['id'] as String,
  //     coupon: map['coupon'] as String,
  //     condition: map['condition'] as double,
  //     discount: map['discount'] as int,
  //     usercreate: map['usercreate'] as String,
  //     startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
  //     endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int),
  //     isActive: map['isActive'] as int,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory Voucher.fromJson(String source) =>
  //     Voucher.fromMap(json.decode(source) as Map<String, dynamic>);
}
