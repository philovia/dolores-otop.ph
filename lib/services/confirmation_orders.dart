import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmationOrders {
  static const String baseUrl =
      'http://localhost:8097'; // Replace with your backend URL


/// Confirm an order for the authenticated supplier
  Future<Map<String, dynamic>> confirmOrder(int Id) async {
    final token = await _getAuthToken();
    if (token == null) {
      throw Exception('No authentication token found.');
    }

    final url = Uri.parse('$baseUrl/products/confirm/$Id');

    // Create the headers with Authorization Bearer token and Content-Type
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body); // Successful response
      } else {
        throw Exception('Failed to confirm the order: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error confirming order: $error');
    }
  }
  Future<List<Map<String, dynamic>>> getSupplierOrders() async {
    final token = await _getAuthToken(); // Retrieve the auth token
    final supplierID = await _getSupplierID(); // Retrieve the supplier ID

    if (token == null || supplierID == null) {
      throw Exception('Authentication token or Supplier ID is missing.');
    }

    final url = Uri.parse('$baseUrl/products/orders/$supplierID');
    // Construct the URL with supplier_id

    // Create the headers with Authorization Bearer token and Content-Type
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        // If the response is successful, parse the JSON data
        List<dynamic> ordersData = json.decode(response.body);
        return List<Map<String, dynamic>>.from(ordersData);
      } else {
        // Handle errors if the response status code is not 200
        throw Exception('Failed to fetch orders: ${response.body}');
      }
    } catch (error) {
      // Handle any other errors that occur during the request
      throw Exception('Error fetching orders: $error');
    }
  }

  /// Retrieves the auth token from SharedPreferences
  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print('Retrieved token: $token'); // Debugging log
    if (token == null || token.isEmpty) {
      throw Exception('Authentication token is missing.');
    }
    return token;
  }

  /// Retrieves the supplier ID from SharedPreferences
  Future<int?> _getSupplierID() async {
    final prefs = await SharedPreferences.getInstance();
    final supplierId = prefs.getInt('supplier_id');
    print('Retrieved supplier ID: $supplierId'); // Debugging log
    if (supplierId == null) {
      throw Exception('Supplier ID is missing.');
    }
    return supplierId;
  }

  /// Save the auth token and supplier ID to SharedPreferences
  Future<void> _saveAuthData(String token, int supplierId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setInt('supplier_id', supplierId);
    print('Token and supplier ID saved'); // Debugging log
  }

  
}
