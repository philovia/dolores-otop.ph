
class OtopProduct {
  final int id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String category;
  final int supplierId;
  final String storeName;
  final String sequentialNumber;
  final Supplier? supplier;

  OtopProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.supplierId,
    required this.storeName,
    required this.sequentialNumber,
    this.supplier,
  });

 factory OtopProduct.fromJson(Map<String, dynamic> json) {
  print('API Response JSON: $json');  // Log the raw response

  return OtopProduct(
    id: json['product_id'] ?? 0,
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    price: (json['price'] ?? 0).toDouble(),
    quantity: json['quantity'] ?? 0,
    category: json['category'] ?? '',
    supplierId: json['supplier_id'] ?? 0,
    storeName: json['store_name'] ?? '',
    sequentialNumber: json['sequential_number'] ?? '',
    supplier: json['supplier'] != null ? Supplier.fromJson(json['supplier']) : null,
  );
}


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category': category,
      'supplierId': supplierId,
      'store_name': storeName,
      'sequential_number': sequentialNumber,
      if (supplier != null) 'supplier': supplier!.toJson(),
    };
  }

  static String validateCategory(String category) {
    if (category != 'Food' && category != 'Non-Food') {
      throw Exception("Category must be either 'Food' or 'Non-Food'");
    }
    return category;
  }

  static String generateSequentialNumber(int maxSequentialNumber) {
    return 'P-${maxSequentialNumber + 1}';
  }
}

class Supplier {
  final int id; 
  final String name;

  Supplier({required this.id, required this.name});

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}