import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:otop_front/models/product.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:your_project_name/models/product_model.dart';

class SupplierProductService {
  static final Logger logger = Logger(level: Level.debug);
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

  static Future<bool> addProduct(Product product, String token) async {
    const String apiUrl =
        'http://127.0.0.1:8097/products'; // Replace with your API URL

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': product.name,
          'description': product.description,
          'category': product.category,
          'price': product.price,
          'quantity': product.quantity,
        }),
      );

      logger.d('Response Code: ${response.statusCode}');
      logger.d('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        return true;
      } else {
        logger.e('Failed to create product: ${response.body}');
        return false;
      }
    } catch (e) {
      logger.e('Error occurred while adding product: $e');
      return false;
    }
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
  static Future<bool> updateProduct(
      int id, Product product, String token) async {
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
