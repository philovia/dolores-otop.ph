import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:otop_front/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyproductsSupplierService {
  static const String baseUrl =
      'http://localhost:8097'; // Replace with your backend URL

  /// Fetches the products for the authenticated supplier
  Future<List<Product>> getMyProducts() async {
    final token = await _getAuthToken();
    if (token == null) {
      throw Exception('No authentication token found.');
    }

    final url = Uri.parse('$baseUrl/products');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> productList = json.decode(response.body);
        return productList.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch products: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error fetching products: $error');
    }
  }

  /// Retrieves the auth token from SharedPreferences
  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null || token.isEmpty) {
      throw Exception('Authentication token is missing.');
    }
    return token;
  }
}
