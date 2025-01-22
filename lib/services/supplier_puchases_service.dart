import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierPurchaseCountService {
  final String apiUrl =
      'https://cyan-dust-star.glitch.me/suppliers/all_purchases'; // Your backend API URL
  final log = Logger('SupplierPurchaseCountService');

  // Fetch Supplier Purchase Counts Method
  Future<List<SupplierPurchaseCount>?> fetchSupplierPurchaseCounts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      log.info('Fetching supplier purchase counts from the backend...');
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Pass token for authentication
        },
      );

      return _handleFetchResponse(response);
    } catch (e) {
      log.severe('Error fetching supplier purchase counts: $e');
      return null;
    }
  }

  // Response Handler for Fetching Supplier Purchase Counts
  List<SupplierPurchaseCount>? _handleFetchResponse(http.Response response) {
    if (response.statusCode == 200) {
      log.info('Supplier purchase counts fetched successfully.');
      List<dynamic> data = jsonDecode(response.body);
      return data
          .map((e) => SupplierPurchaseCount.fromJson(e))
          .toList(); // Map to the model
    } else {
      final responseBody = jsonDecode(response.body);
      log.warning(
          'Failed to fetch supplier purchase counts: ${responseBody['error'] ?? 'Unknown error'}');
      return null;
    }
  }
}

class SupplierPurchaseCount {
  final String storeName;
  final int purchaseCount;

  SupplierPurchaseCount({
    required this.storeName,
    required this.purchaseCount,
  });

  // Factory constructor to create an instance from a JSON map
  factory SupplierPurchaseCount.fromJson(Map<String, dynamic> json) {
    return SupplierPurchaseCount(
      storeName: json['store_name'],
      purchaseCount: json['purchase_count'],
    );
  }
}
