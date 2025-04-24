import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_sales.dart';
// import 'product_sales.dart';

class SoldProductService {
  final String baseUrl = 'http://127.0.0.1:8097/api/otop'; // replace with your actual backend URL

  Future<List<ProductSales>> getTopSoldProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/most_solds'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> productList = data['top_sold_products'];

        return productList
            .map((item) => ProductSales.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load top sold products');
      }
    } catch (e) {
      rethrow;
    }
  }
}
