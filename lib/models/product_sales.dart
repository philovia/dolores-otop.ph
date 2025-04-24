class ProductSales {
  final int productId;
  final String name;
  final int quantitySold;
  final double price;
  final double totalAmount;

  ProductSales({
    required this.productId,
    required this.name,
    required this.quantitySold,
    required this.price,
    required this.totalAmount,
  });

  factory ProductSales.fromJson(Map<String, dynamic> json) {
    return ProductSales(
      productId: json['product_id'],
      name: json['name'],
      quantitySold: json['quantity_sold'],
      price: (json['price'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
    );
  }
}
