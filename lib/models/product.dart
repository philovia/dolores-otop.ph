class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String category;
  final int supplierId;

  static const List<String> validCategories = ['Food', 'Non_Food'];

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.quantity,
      required this.category,
      required this.supplierId}) {
    // Validate category
  }

  // Deserialize from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] ?? 'Unknown Product', // Default value for null name
      description: json['description'] ?? 'No description available', // Default
      category: json['category'] ?? 'Uncategorized', // Default
      price: (json['price'] as num?)?.toDouble() ?? 0.0, // Default to 0.0
      quantity: json['quantity'] as int? ?? 0, // Default to 0
      supplierId: json['supplier_id'] as int,
    );
  }

  // Serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'catergory': category,
      'supplier_id': supplierId
    };
  }
}
