import 'dart:convert';
import 'package:http/http.dart' as http;

class SoldItemsService {
  static const String baseUrl = 'http://your-backend-url.com'; // <- change this

  static Future<Map<String, dynamic>> fetchSoldItems({String? startDate, String? endDate}) async {
    final url = Uri.parse('$baseUrl/sold-items-by-date');

    // Build the request body
    Map<String, dynamic> body = {};
    if (startDate != null && endDate != null) {
      body['start_date'] = startDate;
      body['end_date'] = endDate;
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer your_token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data; // contains sold_items and overall_amount_sold
      } else {
        throw Exception('Failed to fetch sold items. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching sold items: $e');
      throw Exception('Error fetching sold items');
    }
  }
}
