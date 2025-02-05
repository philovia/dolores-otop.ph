import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:otop_front/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierProductService {
  static final Logger logger = Logger(level: Level.debug);
  static const String baseUrl = 'http://127.0.0.1:8097/products';

  // Get product by supplier ID
  static Future<List<Product>> getProductsBySupplierId(int supplierId) async {
    try {
      // Retrieve the token from shared preferences or wherever it's stored
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      final supplierId = prefs.getInt('supplier_id');

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      if (supplierId == null) {
        throw Exception('No supplier ID found');
      }

      // Prepare the URL for the request
      final url = Uri.parse('$baseUrl/$supplierId');

      // Prepare the headers with the Authorization token
      final headers = {
        'Authorization': 'Bearer $token',
      };

      // Make the HTTP request to the server
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        // If the request is successful, parse the products data
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        throw Exception('No products found for this supplier');
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized access: Token mismatch');
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      logger.e('Error fetching products: $e');
      throw Exception('Failed to fetch products');
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
