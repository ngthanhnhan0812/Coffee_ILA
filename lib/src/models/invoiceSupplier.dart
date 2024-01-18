class InvoiceSupplier {
  final int idSupplier;
  final int month;
  final double sumRevenue;
  const InvoiceSupplier({
    required this.month,
    required this.sumRevenue,
    required this.idSupplier,
  });

  factory InvoiceSupplier.fromJson(Map<String, dynamic> json) {
    return InvoiceSupplier(
      idSupplier: json['idSupplier'],
      month: json['month'],
      sumRevenue: json['SumRevenue'] as double,
    );
  }
}
