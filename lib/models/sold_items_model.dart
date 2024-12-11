
class SoldItems {
  final int id;
  final int productId;
  final int quantitySold;
  final double totalAmount;
  final DateTime soldDate;
  final int supplierId;

  SoldItems({
    required this.id,
    required this.productId,
    required this.quantitySold,
    required this.totalAmount,
    required this.soldDate,
    required this.supplierId,
  });

  factory SoldItems.fromJson(Map<String, dynamic> json) {
    return SoldItems(
      id: json['id'] ?? 0,
      productId: json['productId'] ?? 0,
      quantitySold: json['quantity_sold'] ?? 0,
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      soldDate: DateTime.parse(json['sold_date'] ?? DateTime.now().toIso8601String()),
      supplierId: json['supplierId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'quantity_sold': quantitySold,
      'total_amount': totalAmount,
      'sold_date': soldDate.toIso8601String(),
      'supplierId': supplierId,
    };
  }

  static SoldItems setDefaultSoldDate(SoldItems soldItem) {
    if (soldItem.soldDate == DateTime.fromMillisecondsSinceEpoch(0)) {
      return SoldItems(
        id: soldItem.id,
        productId: soldItem.productId,
        quantitySold: soldItem.quantitySold,
        totalAmount: soldItem.totalAmount,
        soldDate: DateTime.now(),
        supplierId: soldItem.supplierId,
      );
    }
    return soldItem;
  }
}
