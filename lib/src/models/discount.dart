class Discount {
  final int id;
  final int discount;
  final String dateBegin;
  final String dateEnd;
  final int idProduct;
  final int isStatus;
  final int indC;
  final String image;
  final int priceSale;
  final String title;
  final int price;
  final int timeExpiered;

  const Discount(
      {required this.id,
      required this.discount,
      required this.dateBegin,
      required this.dateEnd,
      required this.idProduct,
      required this.isStatus,
      required this.indC,
      required this.image,
      required this.price,
      required this.priceSale,
      required this.timeExpiered,
      required this.title
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
      image: json['image'],
      price: json['price'],
      priceSale: json['priceSale'],
      timeExpiered: json['timeExpiered'],
      title: json['title'],
    );
  }
}
