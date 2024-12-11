import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:otop_front/models/product.dart';
// import 'package:your_project_name/models/product_model.dart';

class SupplierProductService {
  static const String baseUrl = 'http://127.0.0.1:8097/products';

 // Get product by name
  static Future<Product> getProductByName(String name) async {
    final url = Uri.parse('$baseUrl${Uri.encodeComponent(name)}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Product not found');
    }
  }

  // Delete a product
  static Future<bool> deleteProduct(int id, String token) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.delete(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    return response.statusCode == 200;
  }

  // Create a new product
  static Future<bool> createProduct(Product product) async {
    final url = Uri.parse('$baseUrl/');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(product.toJson()),
    );

    return response.statusCode == 201;
  }

  // Get all products
  static Future<List<Product>> getAllProducts() async {
    final url = Uri.parse('$baseUrl/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Get products by supplier (specific to logged-in supplier)
  static Future<List<Product>> getMyProducts(String token) async {
    final url = Uri.parse('$baseUrl/');
    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load your products');
    }
  }

  // Update a product
  static Future<bool> updateProduct(int id, Product product, String token) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: json.encode(product.toJson()),
    );

    return response.statusCode == 200;
  }

  // Get total quantity of products
  static Future<int> getTotalQuantity() async {
    final url = Uri.parse('$baseUrl/total-quantity');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['total_quantity'];
    } else {
      throw Exception('Failed to get total quantity');
    }
  }

  // Get products by supplier ID
  static Future<List<Product>> getProductsBySupplier(int supplierId) async {
    final url = Uri.parse('$baseUrl/supplier/$supplierId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products for supplier');
    }
  }
}
