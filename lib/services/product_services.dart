  // ignore_for_file: file_names

  import 'dart:convert';
  import 'package:http/http.dart' as http;
  import 'package:logger/logger.dart';

  class ProductServices {
    final String baseUrl = 'http://localhost:8097/api/products/supplier';
    final Logger _logger = Logger();

    Future<List<dynamic>?> getProductsByStore(int supplierId) async {
      try {
        final response = await http.get(Uri.parse('$baseUrl/$supplierId'));

        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          _logger.e('Failed to fetch products: ${response.body}');
        }
      } catch (e) {
        _logger.e('Error fetching products: $e');
      }
      return null;
    }
  }
