class SupplierPurchaseCount {
  final String storeName;
  final int purchaseCount;

  SupplierPurchaseCount({required this.storeName, required this.purchaseCount});

  // Factory constructor to create an instance from a JSON map
  factory SupplierPurchaseCount.fromJson(Map<String, dynamic> json) {
    return SupplierPurchaseCount(
      storeName: json['store_name'],
      purchaseCount: json['purchase_count'],
    );
  }
}
