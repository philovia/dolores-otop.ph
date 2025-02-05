import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:otop_front/models/otop_models.dart';
import 'package:otop_front/models/sold_items_model.dart';

class OtopProductServiceAdmin {
  static const String baseUrl = 'http://127.0.0.1:8097/otop';
  static const String otopUrl = 'http://127.0.0.1:8097/api/otop';

  static Future<void> checkout(Map<String, dynamic> data) async {
    final url = Uri.parse('$otopUrl/POS');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Checkout failed: ${response.body}');
    }
  }

  // get all products
  static Future<List<OtopProduct>> getOtopProducts() async {
    final url = Uri.parse('$otopUrl/products');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => OtopProduct.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Get all sold items
  static Future<List<SoldItems>> getAllSoldItems() async {
    final url = Uri.parse('$otopUrl/solds_products');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => SoldItems.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load sold items');
    }
  }

  // Get sold items by supplier ID
  static Future<List<SoldItems>> getSoldItemsBySupplierId(
      int supplierId) async {
    final url = Uri.parse('$otopUrl/solds_products/$supplierId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => SoldItems.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load sold items for the supplier');
    }
  }

//   delete otop products
  static Future<bool> deleteOtopProduct(int id) async {
    final url = Uri.parse('$otopUrl/$id');
    final response = await http.delete(url);

    return response.statusCode == 200;
  }

  //  update otop products
  static Future<bool> updateOtopProduct(int id, OtopProduct product) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(product.toJson()),
    );

    return response.statusCode == 200;
  }

  //  create otop products
  static Future<bool> createOtopProduct(OtopProduct product) async {
    final url = Uri.parse('$otopUrl/add_products');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(product.toJson()),
    );

    return response.statusCode == 201;
  }

// get products by id
  static Future<OtopProduct> getOtopProductById(int id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return OtopProduct.fromJson(json.decode(response.body));
    } else {
      throw Exception('Product not found');
    }
  }
}
