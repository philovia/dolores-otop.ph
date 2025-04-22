import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> recordSoldItems(int productId, int quantitySold) async {
  const String apiUrl = 'http://127.0.0.1:8097/api/otop/sold_items';

  final soldItems = [
    {
      'id': productId,
      'quantity': quantitySold,
    }
  ];

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(soldItems), // send as array
    );

    if (response.statusCode != 201) {
      print('Status Code: ${response.statusCode}');
      print('Body: ${response.body}');
      throw Exception('Failed to record sold item');
    } else {
      print('Successfully recorded sold item');
    }
  } catch (e) {
    print('Error: $e');
  }
}

