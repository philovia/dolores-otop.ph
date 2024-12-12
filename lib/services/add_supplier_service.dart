import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddSupplierService {
  final String apiUrl = 'http://127.0.0.1:8097/supplier';
  final log = Logger('AddSupplierService');

  // Fetch All Suppliers Method
  Future<List<Map<String, dynamic>>?> fetchAllSuppliers() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      log.info('Fetching all registered suppliers from the backend...');
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return _handleFetchResponse(response);
    } catch (e) {
      log.severe('Error fetching suppliers: $e');
      return null;
    }
  }

  // Register Supplier Method
  Future<bool> registerSupplier(Map<String, String> supplierData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      log.info('Sending supplier registration data to the backend...');
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(supplierData),
      );

      return _handleRegistrationResponse(response);
    } catch (e) {
      log.severe('Error registering supplier: $e');
      return false;
    }
  }

  // Register User Method
  Future<bool> registerUser(Map<String, String> userData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      log.info('Sending user registration data to the backend...');
      final response = await http.post(
        Uri.parse('$apiUrl/register'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(userData),
      );

      return _handleRegistrationResponse(response);
    } catch (e) {
      log.severe('Error registering user: $e');
      return false;
    }
  }

  // Response Handler for Supplier Registration
  bool _handleRegistrationResponse(http.Response response) {
    if (response.statusCode == 201) {
      log.info('Supplier registered successfully.');
      return true;
    } else {
      final responseBody = jsonDecode(response.body);
      log.warning(
          'Failed to register supplier: ${responseBody['error'] ?? 'Unknown error'}');
      return false;
    }
  }

  // Response Handler for Fetching Suppliers
  List<Map<String, dynamic>>? _handleFetchResponse(http.Response response) {
    if (response.statusCode == 200) {
      log.info('Suppliers fetched successfully.');
      List<dynamic> data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      final responseBody = jsonDecode(response.body);
      log.warning(
          'Failed to fetch suppliers: ${responseBody['error'] ?? 'Unknown error'}');
      return null;
    }
  }
}
