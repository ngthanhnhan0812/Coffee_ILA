class InvoiceSupplier {
  final int idSupplier;
  final String createDate;
  final String year;
  final String month;
  final double sumRevenue;
  const InvoiceSupplier({
    required this.month,
    required this.sumRevenue,
    required this.idSupplier,
    required this.createDate,
    required this.year,
  });

  factory InvoiceSupplier.fromJson(Map<String, dynamic> json) {
    return InvoiceSupplier(
      idSupplier: json['idSupplier'],
      createDate: json['createDate'],
      year: json['Years'],
      month: json['Month'],
      sumRevenue: json['SumRevenue'],
    );
  }
}
