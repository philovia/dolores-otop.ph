import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OtopProductServices {
  final String _baseUrl = 'http://127.0.0.1:8097/api/otop';

  // Fetch total number of unique products
  Future<int> getOtopTotalProducts() async {
    final url = Uri.parse('$_baseUrl/total_products');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data["total_products"];
    } else {
      throw Exception('Failed to fetch total unique products');
    }
  }

  // Calculate the percentage change in product count
  Future<double> calculatePercentageChange() async {
    final prefs = await SharedPreferences.getInstance();
    int? previousTotal = prefs.getInt('previousTotalProducts');
    int currentTotal = await getOtopTotalProducts();

    double percentageChange = 0.0;
    if (previousTotal != null && previousTotal > 0) {
      percentageChange = ((currentTotal - previousTotal) / previousTotal) * 100;
    }
    await prefs.setInt('previousTotalProducts', currentTotal);

    return percentageChange;
  }

  Future<List<Map<String, dynamic>>> getTotalQuantityByName() async {
    final url = Uri.parse('$_baseUrl/total_quantity');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data
          .map((item) => {
                "product_name": item["product_name"],
                "total_quantity": item["total_quantity"]
              })
          .toList();
    } else {
      throw Exception('Failed to fetch total quantity by product name');
    }
  }

  // Fetch total products by category (Food and Non-Food)
  Future<Map<String, int>> getTotalProductsByCategory() async {
    final url = Uri.parse('$_baseUrl/total_categories');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return {
        "Food": data["Food"],
        "Non-Food": data["Non-Food"],
      };
    } else {
      throw Exception('Failed to fetch products by category');
    }
  }

  // Count suppliers by store name
  Future<List<Map<String, dynamic>>> countSuppliersByStoreName() async {
    final url = Uri.parse('$_baseUrl/total_suppliers_product');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data
          .map((item) => {
                "store_name": item["store_name"],
                "product_count": item["product_count"]
              })
          .toList();
    } else {
      throw Exception('Failed to count suppliers by store name');
    }
  }

  // Get total suppliers
  Future<int> getTotalSuppliers() async {
    final url = Uri.parse('$_baseUrl/total_suppliers');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data["total_suppliers"];
    } else {
      throw Exception('Failed to fetch total suppliers');
    }
  }

  // Get product counts per supplier
  Future<List<Map<String, dynamic>>> getSupplierProductCounts() async {
    final url = Uri.parse('$_baseUrl/total_suppliers_product');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data
          .map((item) => {
                "store_name": item["store_name"],
                "product_count": item["product_count"]
              })
          .toList();
    } else {
      throw Exception('Failed to fetch supplier product counts');
    }
  }
}
