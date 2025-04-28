import 'dart:convert';
import 'package:http/http.dart' as http;

// Define the SummaryRequest class
class SummaryRequest {
  final String intervalType;

  SummaryRequest({required this.intervalType});

  // Convert the request to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'interval': intervalType,
    };
  }
}

// Service to fetch sales summary
class SalesSummaryService {
  final String baseUrl;

  SalesSummaryService({required this.baseUrl});

  // Method to get sales summary based on the interval
  Future<Map<String, dynamic>> getSalesSummary(SummaryRequest request) async {
    final url = Uri.parse('$baseUrl/your-endpoint'); // Replace with your actual API endpoint

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Parse the response body
      } else {
        throw Exception('Failed to load sales summary');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
