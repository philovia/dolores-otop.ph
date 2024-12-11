import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> recordSoldItems(int productId, int quantitySold) async {
  const String apiUrl = 'http://127.0.0.1:8097/api/otop/sold_items'; 

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'productId': productId,
        'quantity_sold': quantitySold,
      }),
    );

    if (response.statusCode == 200) {
      print('Sold item recorded successfully');
      // You can handle success response here
    } else {
      print('Failed to record sold item');
      // Handle failure (e.g., show an error message)
    }
  } catch (e) {
    print('Error: $e');
    // Handle network or other errors
  }
}
