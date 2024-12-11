class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String category;
  

  static const List<String> validCategories = ['Food', 'Non_Food'];

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category
  }){
    // Validate category
    if (!validCategories.contains(category)) {
      throw ArgumentError('Invalid category. Must be "Food" or "Non_Food".');
    }
  }

  // Deserialize from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
      category: json['catergory']
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
      'catergory':category
    };
  }
}
