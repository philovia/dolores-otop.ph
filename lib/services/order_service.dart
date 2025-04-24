import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../models/sold_items_model.dart';

class OrderService {
  final String baseUrl = 'http://127.0.0.1:8097/order';
  final Logger _logger = Logger();

  Future<http.Response?> createOrder({
    required int productId,
    required int quantity,
    required int supplierId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'product_id': productId,
          'quantity': quantity,
          'supplier_id': supplierId,
        }),
      );

      if (response.statusCode == 201) {
        return response;
      } else {
        _logger.e('Failed to create order: ${response.body}');
      }
    } catch (e) {
      _logger.e('Error creating order: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>> getAllSoldItems() async {
    final url = Uri.parse('http://127.0.0.1:8097/api/otop/solds_products'); // replace with your actual endpoint
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['overall_amount_sold'] ?? 0).toDouble();
    } else {
      throw Exception('Failed to load overall amount sold');
    }
  }

  // this is how to fetch the overallAmuntSold

  // void fetchTotalSoldAmount() async {
  //   try {
  //     double total = await getOverallAmountSoldOnly();
  //     print('Overall amount sold: ₱$total');
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  Future<List<dynamic>?> fetchOrders() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        _logger.e('Failed to fetch orders: ${response.body}');
      }
    } catch (e) {
      _logger.e('Error fetching orders: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> fetchOrderById(int orderId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$orderId'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        _logger.e('Failed to fetch order: ${response.body}');
      }
    } catch (e) {
      _logger.e('Error fetching order: $e');
    }
    return null;
  }

  Future<http.Response?> updateOrder({
    required int orderId,
    required int quantity,
    required int productId,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$orderId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'quantity': quantity,
          'product_id': productId,
        }),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        _logger.e('Failed to update order: ${response.body}');
      }
    } catch (e) {
      _logger.e('Error updating order: $e');
    }
    return null;
  }

  Future<bool> deleteOrder(int orderId) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$orderId'));
      if (response.statusCode == 200) {
        return true;
      } else {
        _logger.e('Failed to delete order: ${response.body}');
      }
    } catch (e) {
      _logger.e('Error deleting order: $e');
    }
    return false;
  }

// different baseUrl fro this service
  Future<http.Response?> confirmOrder(int orderId, String token) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$orderId/confirm'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        _logger.e('Failed to confirm order: ${response.body}');
      }
    } catch (e) {
      _logger.e('Error confirming order: $e');
    }
    return null;
  }
}
