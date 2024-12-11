class SupplierProduct {
  final int id;
  final String sequentialNumber;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final int supplierId;
  final String category;

  SupplierProduct({
    required this.id,
    required this.sequentialNumber,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.supplierId,
    required this.category,
  });

  // Factory constructor to create a Product object from a JSON map
  factory SupplierProduct.fromJson(Map<String, dynamic> json) {
    return SupplierProduct(
      id: json['id'],
      sequentialNumber: json['sequential_number'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      supplierId: json['supplier_id'],
      category: json['category'],
    );
  }

  // Method to convert a Product object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sequential_number': sequentialNumber,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'supplier_id': supplierId,
      'category': category,
    };
  }
}
