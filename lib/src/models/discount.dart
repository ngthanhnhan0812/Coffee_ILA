class Discount {
  final int id;
  final int discount;
  final String dateBegin;
  final String dateEnd;
  final int idProduct;
  final int isStatus;
  final int indC;
  final String? image;

  const Discount({
    required this.id,
    required this.discount,
    required this.dateBegin,
    required this.dateEnd,
    required this.idProduct,
    required this.isStatus,
    required this.indC,
    this.image,
  });

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
        id: json['id'],
        discount: json['discount'],
        dateBegin: json['dateBegin'],
        dateEnd: json['dateEnd'],
        idProduct: json['idProduct'],
        isStatus: json['isStatus'],
        indC: json['indC'],
        image: json['image']);
  }
}
